#!/usr/bin/env python
"""file of constatns  of position 
that are use in this package
for quicker change and orientation"""

import roslib; roslib.load_manifest('clopema_smach')
import rospy, smach, smach_ros, math, copy, tf, PyKDL, os, shutil, numpy
from tf.transformations import quaternion_from_euler, quaternion_about_axis, quaternion_from_matrix, rotation_matrix
from tf_conversions import posemath
from clopema_smach import *
from geometry_msgs.msg import *
from smach import State
from clopema_smach.msg import MA1400JointState
from clopema_smach.utility_states import PoseBufferState

"""OLD POSITION ARE AT THE END OF FILE""" 
#adjustment
visualize = False

#position of x1_xtion
x_pos_r1_xtion = -0.6
y_pos_r1_xtion = -0.6
z_pos_r1_xtion = 1.2
phi_r1_xtion = math.pi
teta_r1_xtion = -math.pi/2
sigma_r1_xtion = -math.pi/4

#first position of r2_ee
x1_pos_r2_ee = 0.8
y1_pos_r2_ee = -1.2
z1_pos_r2_ee = 0.5
phi1_r2_ee = math.pi
teta1_r2_ee = 0
sigma1_r2_ee = 0

#second position of r2_ee
x2_pos_r2_ee = 0.25
y2_pos_r2_ee = -1.55
z2_pos_r2_ee = z1_pos_r2_ee
phi2_r2_ee = phi1_r2_ee
teta2_r2_ee = teta1_r2_ee
sigma2_r2_ee = sigma1_r2_ee

#swing
swing=[math.pi/32,0]
t_pos=[0,-math.pi/2]

#ext.axis
ext_axis=[0, math.pi/5, -math.pi/4]

#position r1 - joints
s1=[-math.pi/4,                          -math.pi/4,                          -math.pi/4,                           ]
l1=[0,                                   0,                                   0,                                    ]
u1=[-29*math.pi/64,                      -29*math.pi/64,                      -29*math.pi/64,                       ]
r1=[-s1[0]+10*math.pi/32,                -s1[1]+10*math.pi/32,                -s1[2]+21*math.pi/64,                 ]
b1=[(math.pi-0.00001)-math.pi/16,        (math.pi-0.00001)-math.pi/16,        (math.pi-0.00001)-math.pi/16,         ]
t1=[math.pi/4,                           math.pi/4,                           math.pi/4,                            ]
#position r2 - joints
s2=[-4*math.pi/64,                       -0.181688748501656,                 -4*math.pi/64,                         -4*math.pi/64,                      ]
l2=[8*math.pi/64,                        0.740690504760511,                   6*math.pi/64,                         0*math.pi/64,                       ]
u2=[12*math.pi/64,                        1.11236742407980,                  10*math.pi/64,                         12*math.pi/64,                      ]
r2=[0.0,                                 -0.280681425850237,                  0.0,                                  -0.0,                               ]
b2=[l2[0]-2*math.pi/64-u2[0],            -0.405389079034982,                  l2[2]-2*math.pi/64-u2[2],             math.pi/4,                          ]
t2=[6*math.pi/64,                        6*math.pi/64,                        6*math.pi/64,                         6*math.pi/64,                       ]

def get_joints_r1(_pos=0):
    joints = MA1400JointState()
    joints.s = s1[_pos]
    joints.l = l1[_pos]
    joints.u = u1[_pos]
    joints.r = r1[_pos]
    joints.b = b1[_pos]
    joints.t = t1[_pos]
    return joints
    
def get_joints_r2(_pos=0, m_pos=0):
    joints = MA1400JointState()
    joints.s = s2[_pos]
    joints.l = l2[_pos]
    joints.u = u2[_pos]
    joints.r = r2[_pos]-swing[1-m_pos]
    joints.b = b2[_pos]-swing[m_pos]
    joints.t = t2[_pos]+t_pos[m_pos]
    return joints

def get_joints_r2_m(_pos=0, m_pos=0):
    joints = MA1400JointState()
    joints.s = s2[_pos]
    joints.l = l2[_pos]
    joints.u = u2[_pos]
    joints.r = r2[_pos]+swing[1-m_pos]
    joints.b = b2[_pos]+swing[m_pos]
    joints.t = t2[_pos]+t_pos[m_pos]
    return joints

def get_new_pose(x,y,z,phi,teta,sigma):
    """return new position"""
    pose = PoseStamped()
    pose.header.frame_id = 'base_link'
    pose.pose.position.x = x
    pose.pose.position.y = y
    pose.pose.position.z = z
    pose.pose.orientation = Quaternion(*quaternion_from_euler(phi,teta,sigma))
    return pose

def get_pos_r1_xtion():
    """return position of r1_xtion"""
    return get_new_pose( x_pos_r1_xtion, y_pos_r1_xtion, z_pos_r1_xtion, phi_r1_xtion, teta_r1_xtion, sigma_r1_xtion)
    
def get_pos1_r2_ee():
    """return first position of r2_ee"""
    return get_new_pose( x1_pos_r2_ee, y1_pos_r2_ee, z1_pos_r2_ee, phi1_r2_ee, teta1_r2_ee, sigma1_r2_ee)

def get_pos2_r2_ee():
    """return second position of r2_ee"""
    return get_new_pose( x2_pos_r2_ee, y2_pos_r2_ee, z2_pos_r2_ee, phi2_r2_ee, teta2_r2_ee, sigma2_r2_ee)

def get_poses():
    pose = Pose()
    pose.position.x = x2_pos_r2_ee
    pose.position.y = y2_pos_r2_ee
    pose.position.z = z2_pos_r2_ee
    pose.orientation = Quaternion(*quaternion_from_euler(phi2_r2_ee,teta2_r2_ee,sigma2_r2_ee))

    poses = []
    poses.append(copy.deepcopy(pose))
    pose.position.x = x1_pos_r2_ee
    pose.position.y = y1_pos_r2_ee
    pose.position.z = z1_pos_r2_ee
    pose.orientation = Quaternion(*quaternion_from_euler(phi1_r2_ee,teta1_r2_ee,sigma1_r2_ee))
    poses.append(copy.deepcopy(pose))
    return poses

def get_ext_axis_position(ext=0):
    return ext_axis[ext]
    
   
"""
OLD POSITIONS


#adjustment
visualize = False

#position of x1_xtion
x_pos_r1_xtion = -0.6
y_pos_r1_xtion = -0.6
z_pos_r1_xtion = 1.2
phi_r1_xtion = math.pi
teta_r1_xtion = -math.pi/2
sigma_r1_xtion = -math.pi/4

#first position of r2_ee
x1_pos_r2_ee = 0.35
y1_pos_r2_ee = -1.45
z1_pos_r2_ee = 1.8
phi1_r2_ee = 5*math.pi/8
teta1_r2_ee = math.pi/4
sigma1_r2_ee = 0

#swing
swing=math.pi/16

#second position of r2_ee
x2_pos_r2_ee = 0.25
y2_pos_r2_ee = -1.55
z2_pos_r2_ee = z1_pos_r2_ee
phi2_r2_ee = phi1_r2_ee
teta2_r2_ee = teta1_r2_ee
sigma2_r2_ee = sigma1_r2_ee

#position r1 - joints
s1=-math.pi/8
l1=math.pi/4
u1=-math.pi/4
r1=-s1+math.pi/2
b1=math.pi-0.00001
t1=math.pi/4


#position r2 - joints
s2=0.0
l2=0.0
u2=-math.pi/16
r2=0.0
b2=-u2-swing/2
t2=0.0
#change r2 during measure - joints
s2m=s2+0.0
l2m=l2+0.0
u2m=u2+0.0
r2m=r2+0.0
b2m=b2+swing
t2m=t2+0.0

NEWER

#position r1 - joints
s1=[-math.pi/4,                          -math.pi/4,                          -math.pi/4,                           ]
l1=[0,                                   0,                                   0,                                    ]
u1=[-29*math.pi/64,                      -29*math.pi/64,                      -29*math.pi/64,                       ]
r1=[-s1[0]+10*math.pi/32,                -s1[1]+10*math.pi/32,                -s1[2]+11*math.pi/32,                 ]
b1=[(math.pi-0.00001)-math.pi/16,        (math.pi-0.00001)-math.pi/16,        (math.pi-0.00001)-math.pi/16,         ]
t1=[math.pi/4,                           math.pi/4,                           math.pi/4,                            ]
#position r2 - joints
s2=[-4*math.pi/64,                       -0.0309350676414990,                 -4*math.pi/64,                        ]
l2=[8*math.pi/64,                        0.649183646607166,                   6*math.pi/64,                         ]
u2=[12*math.pi/64,                        0.597959730940564,                  10*math.pi/64,                         ]
r2=[0.0,                                 -0.261901304127543,                  0.0,                                  ]
b2=[l2[0]-2*math.pi/64-u2[0],            0.0414739670654518,                  l2[2]-2*math.pi/64-u2[2],             ]
t2=[6*math.pi/64,                        6*math.pi/64,                        6*math.pi/64,                         ]




"""
