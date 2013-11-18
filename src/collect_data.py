#!/usr/bin/env python
"""program for collecting data, only menu"""
import roslib; roslib.load_manifest('clopema_smach')
import rospy, smach, smach_ros, math, copy, tf, PyKDL, os, shutil, numpy, time, subprocess
from _bag_files_hydro import stop_bag_file, start_bag_file_camera_def, start_bag_file_topic
from actions import GoHome, GoToAction, ActionMove, OpenGrip, CloseGrip, GoToActionJoints_r1, GoToActionJoints_r2, ExtAxisMove

time_to_close = 0
time_to_measure = 0

class bag_file_record:
    def __init__(self):
        self.subname_of_file = ''
        #self.number_of_file = ''
        self.time_more = 8.0
        self.robot_speed = '0.1'
                
    #def zeros(self):
        #_h_num=int(self.number_of_file)
        #count=0
        #while _h_num >= 10:
           	#_h_num = _h_num/10
           	#count+=1
        #s = str(int(self.number_of_file))
        #for i in range(3-count):
            #s=''.join(['0',s])
        #self.number_of_file=s       

    #def increase_number(self):
        #num=int(self.number_of_file)
        #num+=1
        #self.number_of_file=str(num)
        #self.zeros()
    
    def rename_bag(self):
        self.subname_of_file = str(raw_input('\nPut a name of file:\n'))
        while self.subname_of_file == '':
            self.subname_of_file = str(raw_input('\nPut a name of file:\n'))
        #self.number_of_file = str(raw_input('\nPut a number of file:\n'))
        #while self.number_of_file == '':
            #self.number_of_file = str(raw_input('\nPut a number of file:\n'))
        #self.zeros()

    def get_next_name(self):
        #if self.subname_of_file == '' or self.number_of_file == '':
        if self.subname_of_file == '':
	        self.rename_bag()
        #next_name=''.join([self.subname_of_file, '_', self.robot_speed, '_', self.number_of_file,'_RB.', 'bag'])
        next_name=''.join([self.subname_of_file, '_', self.robot_speed, '_RB.', 'bag'])
        return next_name
    
    def change_speed(self):
        self.robot_speed = '0'
        while self.robot_speed == '0':
            self.robot_speed = str(raw_input('Put a new speed of robot: '))
        p=subprocess.Popen(['rosservice', 'call', '/set_robot_speed', self.robot_speed])

def get_subname(i,y):
    if y==0:
        s='B'
    else:
        s='R'
    subname=''.join([s,str(i+1)])
    return subname

def action_record_submenu(f):
    ExtAxisMove(1)
    #for i in range(0,3):
        #for y in range (0,2):		
            #GoToActionJoints_r1(i)
            #GoToActionJoints_r2(i,y)
            #time.sleep(f.time_more)
            #pid=start_bag_file_all(f.subname_of_file,f.robot_speed,f.number_of_file,get_subname(i,y))
            #time.sleep(2)
            #ActionMove(i,y)
            #stop_bag_file(pid,f.time_more)
            #time.sleep(2)            
            
    #GoToActionJoints_r1(0)
    #GoToActionJoints_r2(0,0)
    
    """Can measure more different position, but now is only one"""
    for i in range(1,2):
        for y in range (0,2):
            GoToActionJoints_r1(i)
            GoToActionJoints_r2(i,y)
            time.sleep(f.time_more)
            #pid=start_bag_file_topic(f.subname_of_file,f.robot_speed,f.number_of_file,str(i))
            pid=start_bag_file_topic(f.subname_of_file,f.robot_speed,get_subname(i,y))
            time.sleep(2)
            ActionMove(i,y)
            stop_bag_file(pid,f.time_more)
            time.sleep(2)
    #f.increase_number()
    
#def action_record(f):
    #i=raw_input("\n\n PRESS ENTER to close grip in %d seconds(...n...for exit)\n\n" % time_to_close)
    #if i != 'n' and i != 'N':
        #time.sleep(time_to_close)
        #CloseGrip()
        #i=raw_input("\n\n PRESS ENTER to action in %d seconds(...n...for open grip and exit)\n\n" % time_to_measure)
        #if i != 'n' and i != 'N':
			
            #time.sleep(time_to_measure)
            #action_record_submenu(f)
        #else:
		    #OpenGrip()
            
def action_record(f):
        i=raw_input("\n\n PRESS A BUTTON to action in (...n...for open grip and exit)\n\n")
        if i != 'n' and i != 'N':
            action_record_submenu(f)
        #else:
		    #OpenGrip()
		    
def _record_change_menu(i,f):
    #may do no.3 - change time
    if i=='1' or i=='rename':
        f.rename_bag()
        _record_change(f)
    elif i=='2' or i=='speed':
        f.change_speed()
        _record_change(f)
    elif i=='3' or i=='open':
        OpenGrip()
        _record_change(f)
    elif i=='4' or i=='close':
        time.sleep(time_to_close)
        CloseGrip()        
        _record_change(f)
    elif i=='5' or i=='cont':
        _record(f)
    elif i=='menu':        
        print ""
    elif i=='stop':
        os._exit(0)
    else:
	    print "Doesn't work"

def _record_change(f):
    i = raw_input ("\n...1....CHANGE NAME (rename)\n...2....CHANGE SPEED (speed)\n...3....OPEN GRIPPER (open)\n...4....CLOSE GRIPPER (close)\n\n...5....CONTINUE RECORDING (cont)\n..menu..EXIT from recording\n\n..stop..EXIT program\n\n")
    _record_change_menu(i,f)

def _record_menu(i,f):
    if i=='Y' or i=='y':
        action_record(f)
    else:
        _record_change(f) 
    
def _record(f):    
    i=''
    while i != 'n' and i != 'N':        
        i = raw_input ("\nFor edit [n]\nWant you record %s file? [Y/n]\n" % f.get_next_name())
        _record_menu(i,f)
        
def _cameraDefaultRecord():
    ExtAxisMove(1)
    GoToActionJoints_r2(3,0)
    for i in range(0,3):
        GoToActionJoints_r1(i)
        pid=start_bag_file_camera_def(str(i))
        stop_bag_file(pid,4)
    
def _menu(i,f):
    if i=='1' or i=='home':
        GoHome()
    elif i=='2' or i=='mpos':
        GoToActionJoints_r1(0)
        GoToActionJoints_r2(0,0)
        ExtAxisMove(1)
    elif i=='3' or i=='action':
        _record(f)
    elif i=='4' or i=='open':
        OpenGrip()
    elif i=='5' or i=='close':        
        time.sleep(time_to_close)
        CloseGrip()
    elif i=='6' or i=='camdef':        
        _cameraDefaultRecord()
    elif i=='stop':
        os._exit(0)
    else:
	    print "Doesn't work"

def start_program(f):
    i=''
    while i != 'stop':
        i = raw_input ("\n...1....Move to the HOME position (home)\n...2....Move to READY TO MEASURE position (mpos)\n...3....Move and record (action)\n...4....Open Gripper (open)\n...5....Close Gripper (close)\n...6....Camera default record (camdef)\n..stop..EXIT\n\n")
        _menu(i,f)

def main():
    rospy.init_node('collect_data')
    f=bag_file_record()
    p=subprocess.Popen(['rosservice', 'call', '/set_robot_speed', f.robot_speed])
    print f.time_more
    start_program(f)    

if __name__ == '__main__':
    main()
    
