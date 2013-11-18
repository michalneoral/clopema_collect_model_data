#!/usr/bin/env python
"""Functions for work with bag files"""
import os, glob, time, operator
import signal
import subprocess
import string
import local_options

path_to_files = local_options.savefolder
#path_to_files = '/home/neoral/'
path_to_topic = ''.join([local_options.pcglocate,'matlab/topics/topics'])

""" number of best topic file """
number_of_topic_file = '1'


#def start_bag_file_all(name,speed,number,subname):
def start_bag_file_all(name,speed,subname):
    """function to save bag file
       save only topics in ./../matlab/topics.txt"""   
    #read a file with names of topics
    try:
        filename = "".join([path_to_topic,'.txt'])
        f = open(filename, "r")
        try:
            topicfile = f.readlines()            
        finally:
            f.close()
    except IOError:
        pass

    m=range(0,len(topicfile)+5)
    #name_of_file=''.join([path_to_files, name, '_', speed, '_', str(number), '_', subname])
    name_of_file=''.join([path_to_files, name, '_', speed, '_', subname])
    m[0]='rosbag'
    m[1]='record'
    m[2]='--duration=8'
    m[3]='-O'    
    m[4]=name_of_file
    for i in range(0,len(lines)):
        s=str(lines[i]).strip()
        m[i+5]=s
    p = subprocess.Popen(m)
    return p.pid  
    
#def start_bag_file_topic(name,speed,number,subname):
def start_bag_file_topic(name,speed,subname):
    """function to save bag file
       save only topics in ./../matlab/topics.txt"""   
       
    #read a file with names of topics
    filename = "".join([path_to_topic,number_of_topic_file,'.txt'])
    try:
        f = open(filename, "r")
        try:
            topicfile = f.readlines()            
        finally:
            f.close()
    except IOError:
        pass

    #name_of_file=''.join([path_to_files, name, '_', speed, '_', str(number), '_', subname])
    name_of_file=''.join([path_to_files, name, '_', speed, '_', subname])
    m=range(0,len(topicfile)+5)
    m[0]='rosbag'
    m[1]='record'
    m[2]='--duration=8'
    m[3]='-O'    
    m[4]=name_of_file
    for i in range(0,len(topicfile)):
        s=str(topicfile[i]).strip()
        m[i+5]=s
    p = subprocess.Popen(m)
    return p.pid     

def start_bag_file_camera_def(number_of_position):
    """function to save bag file
       save only topics in ./../matlab/topics.txt"""   
    try:
        print "open"
        filename = "".join([path_to_topic,'.txt'])
        f = open(filename, "r")
        try:
            lines = f.readlines()            
        finally:
            f.close()
    except IOError:
        print lines
        pass

    name_of_file=''.join([path_to_files, 'camera_default', '_',number_of_position])
    m=range(0,len(lines)+5)
    m[0]='rosbag'
    m[1]='record'
    m[2]='--duration=3'
    m[3]='-O'    
    m[4]=name_of_file
    for i in range(0,len(lines)):
        s=str(lines[i]).strip()
        m[i+5]=s
    p = subprocess.Popen(m)
    return p.pid    
    
def stop_bag_file(pid, time_more):
    print 'stop'
    time.sleep(time_more)
    #os.kill(pid, signal.SIGINT)
