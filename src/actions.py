#!/usr/bin/env python
import roslib; roslib.load_manifest('clopema_smach')
import rospy, smach, smach_ros, math, copy, tf, PyKDL, os, shutil, numpy
from tf.transformations import quaternion_from_euler, quaternion_about_axis
from tf_conversions import posemath
from clopema_smach import *
from clopema_motoros.srv import *
from geometry_msgs.msg import *
from smach import State, Sequence
from clopema_smach.msg import MA1400JointState
from clopema_smach.utility_states import PoseBufferState
from sensor_msgs.msg import JointState
import _pos

def ExtAxisMove(pos=0):
	#rospy.init_node("move_ext_sm")
    sq = Sequence(outcomes=['succeeded', 'aborted', 'preempted'], connector_outcome='succeeded')
    sm = gensm_plan_vis_exec(PlanExtAxisState(), input_keys=[], output_keys=[], visualize = _pos.visualize)
    #sm = gensm_plan_vis_exec(PlanExtAxisState())
    sm.userdata.position = _pos.get_ext_axis_position(pos)

    with sq:
        smach.Sequence.add('GOTO', sm, transitions={'aborted':''})
        #smach.Sequence.add('POWER_OFF', SetServoPowerOffState())
   
    sis = smach_ros.IntrospectionServer('introspection_server', sq, '/SM_ROOT')
    sis.start()
    outcome = sq.execute()
    sis.stop()

def remove_middle_points(ud):
    """By Vladimir Petrik"""
    if len(ud.trajectory.points) <= 1:
        return 'succeeded'
    
    new_points = []
    k = ud.density
    for i in range(len(ud.trajectory.points)):
        if i % k == 0:
            new_points.append(ud.trajectory.points[i])
    
    for i in range(ud.middle_points):
        new_points.append(ud.trajectory.points[len(ud.trajectory.points) - 1])
    
    for i in reversed(range(len(ud.trajectory.points))):
        if i % k == 0:
            new_points.append(ud.trajectory.points[i])
    
    for i in range(ud.end_points):
        new_points.append(ud.trajectory.points[0])
    
    print 'Number of points: ', len(new_points)
    ud.trajectory.points = new_points
    return 'succeeded'

def OpenGrip(name = 'open_grip', _open=True):
    sm = gensm_grippers(False, _open)
    sm.execute()

def CloseGrip(name = 'close_grip'):
    OpenGrip(_open=False)

def _move(name, new_smash, new_smash_plan):
    with new_smash:
        smach.Sequence.add('GOTO', new_smash_plan, transitions={'aborted':''})
        smach.Sequence.add('POWER_OFF', SetServoPowerOffState())

    sis = smach_ros.IntrospectionServer(name, new_smash, '/SM_ROOT')
    sis.start()
    #os.system('clear')
    outcome = new_smash.execute()
    sis.stop()
    
def GoHome(name = 'go_home'):
    ExtAxisMove()
    new_smash = smach.Sequence(outcomes=['succeeded', 'preempted', 'aborted'], connector_outcome='succeeded')
    new_smash_plan = gensm_plan_vis_exec(PlanToHomeState(), input_keys=[], output_keys=[], visualize = _pos.visualize)
    _move(name, new_smash, new_smash_plan)
    
def GoToAction(name = 'go_actions'):
    new_smash = smach.Sequence(outcomes=['succeeded', 'preempted', 'aborted'], connector_outcome='succeeded')
    new_smash_plan = gensm_plan_vis_exec(Plan1ToXtionPoseState(), input_keys=['goal', 'ik_link'], output_keys=[], visualize = _pos.visualize)
    new_smash.userdata.goal = _pos.get_pos_r1_xtion()
    new_smash.userdata.ik_link = 'r1_xtion'
    _move(name, new_smash, new_smash_plan)    

    new_smash = smach.Sequence(outcomes=['succeeded', 'preempted', 'aborted'], connector_outcome='succeeded')
    new_smash_plan = gensm_plan_vis_exec(Plan1ToPoseState(), input_keys=['goal', 'ik_link'], output_keys=[], visualize = _pos.visualize)
    new_smash.userdata.goal = _pos.get_pos1_r2_ee()
    new_smash.userdata.ik_link = 'r2_ee'
    _move(name, new_smash, new_smash_plan)
    
    OpenGrip()

#def ActionMove(name = 'move_measure'):
    #poses = _pos.get_poses()

    #sm = smach.Sequence(outcomes=['succeeded', 'preempted', 'aborted'], connector_outcome='succeeded')
    #sm_plan = gensm_plan_vis_exec(Plan1ToPoseState(), input_keys=['goal', 'ik_link'], output_keys=[], visualize = _pos.visualize)
    #sm.userdata.poses = PoseArray()
    #sm.userdata.poses.header.frame_id = 'base_link'
    #sm.userdata.poses.poses = poses
    #sm.userdata.ik_link = 'r2_ee' 
    
    #with sm:
        #smach.Sequence.add('POSE_BUFFER', PoseBufferState(), transitions={'aborted':'POWER_OFF'})
        #smach.Sequence.add('GOTO', sm_plan, transitions={'aborted':'POSE_BUFFER', 'succeeded':'POSE_BUFFER'},
                           #remapping={'goal':'pose'})
        #smach.Sequence.add('POWER_OFF', SetServoPowerOffState())

    #sis = smach_ros.IntrospectionServer(name, sm, '/SM_ROOT')
    #sis.start()
    ##os.system('clear')
    #outcome = sm.execute()
    #sis.stop()
    
def ActionMove(pos=0, m_pos=0, name = 'move_measure'):
    sm = smach.Sequence(outcomes=['succeeded', 'preempted', 'aborted'], connector_outcome='succeeded')

    sm.userdata.goals = []
    sm.userdata.goals.append(copy.deepcopy(_pos.get_joints_r2(pos, m_pos)))    
    sm.userdata.goals.append(copy.deepcopy(_pos.get_joints_r2_m(pos, m_pos)))
    sm.userdata.robot = 2
    sm.userdata.density = 1000 #large number means there is only first point
    sm.userdata.middle_points = 5 #number of the points in the middle of the trajectory (pause)
    sm.userdata.end_points = 20 #number of the points at the end of the trajectory - to prevent early stop
    
    with sm:
        smach.Sequence.add('INTERPOLATE', Interpolate1JointsState())
        smach.Sequence.add('REMOVE_MIDDLE_POINTS', FunctionApplicationState(remove_middle_points, input_keys=['trajectory', 'density', 'middle_points', 'end_points'], output_keys=['trajectory']))
        smach.Sequence.add('EXECUTE', TrajectoryExecuteState())
        #smach.Sequence.add('POWER_OFF', SetServoPowerOffState())
    
    sis = smach_ros.IntrospectionServer(name, sm, '/SM_ROOT')
    sis.start()
    outcome = sm.execute()
    sis.stop()

def JointsState(sm,name):
    with sm:
        smach.Sequence.add('PLAINT_TO_STATE', Plan1ToJointsState())
        smach.Sequence.add('EXECUTE', TrajectoryExecuteState())
        #smach.Sequence.add('POWER_OFF', SetServoPowerOffState())
    
    sis = smach_ros.IntrospectionServer(name, sm, '/SM_ROOT')
    sis.start()
    outcome = sm.execute()
    sis.stop()

def GoToActionJoints_r1(pos=0, name='go_actions_joints'):
    sm = smach.Sequence(outcomes=['succeeded', 'preempted', 'aborted'], connector_outcome='succeeded')
    sm.userdata.goal = _pos.get_joints_r1(pos)   
    sm.userdata.robot = 1
    #sm.userdata.density = 1000 #large number means there is only first point
    #sm.userdata.middle_points = 5 #number of the points in the middle of the trajectory (pause)
    #sm.userdata.end_points = 20 #number of the points at the end of the trajectory - to prevent early stop
    JointsState(sm,name)
    
def GoToActionJoints_r2(pos=0, m_pos=0, name='go_actions_joints'):
    sm = smach.Sequence(outcomes=['succeeded', 'preempted', 'aborted'], connector_outcome='succeeded')
    sm.userdata.goal = _pos.get_joints_r2(pos,m_pos)   
    sm.userdata.robot = 2
    #sm.userdata.density = 1000 #large number means there is only first point
    #sm.userdata.middle_points = 5 #number of the points in the middle of the trajectory (pause)
    #sm.userdata.end_points = 20 #number of the points at the end of the trajectory - to prevent early stop
    JointsState(sm,name)
