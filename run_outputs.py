import time
from time import sleep
import os
import io
import subprocess
from subprocess import call

## create the lines that are to be inserted into the output file

## insert the .odb file location and filename here eg. 'C:/Temp/Test.odb
odb_location =
## insert the location to send the output files
output_location = 

## finds and targets the extract_coordinates python file
target_files = [f for f in os.listdir() if f.startswith('extract')]
a = int(len(target_files))

## edits lines in the extract_coordinates python file to include the odb file and output file locations
for i in range(0,a):

    bases = target_files[i]
    text_read=open(bases,'r')
    output_file = 'extract_coordinates_new.py'
    text_write=open(output_file,'w')
    lines=text_read.read()
    if 'odb_file_locs' in lines:
        lines = lines.replace('odb_file_locs',odb_location)
    if 'output_file_locs' in lines:
        lines = lines.replace('output_file_locs',output_location)   
    text_write.write(lines)
    text_write.close()
    text_read.close()

## finds and targets the report_time python file
target_files = [f for f in os.listdir() if f.startswith('report')]

## edits lines in the report_time python file to include the odb file and output file locations
a = int(len(target_files))
for i in range(0,a):

    bases = target_files[i]
    text_read=open(bases,'r')
    output_file = 'report_time_new.py'
    text_write=open(output_file,'w')
    lines=text_read.read()
    if 'odb_file_locs' in lines:
        lines = lines.replace('odb_file_locs',odb_location)
    if 'output_file_locs' in lines:
        lines = lines.replace('output_file_locs',output_location)   
    text_write.write(lines)
    text_write.close()
    text_read.close()


## finds and targets the organise_time_files
target_files = [f for f in os.listdir() if f.startswith('organise')]

## edits lines in the organise_time_files python file to include the odb file and output file locations
a = int(len(target_files))
for i in range(0,a):

    bases = target_files[i]
    text_read=open(bases,'r')
    output_file = 'organise_time_files_new.py'
    text_write=open(output_file,'w')
    lines=text_read.read()
    if 'odb_file_locs' in lines:
        lines = lines.replace('odb_file_locs',odb_location)
    if 'output_file_locs' in lines:
        lines = lines.replace('output_file_locs',output_location)   
    text_write.write(lines)
    text_write.close()
    text_read.close()

## runs the newly created python files to output the nodal coordinates, displacements at each time point and rearrange the files into the correct format for importing into Matlab
command1 = 'abaqus cae noGui=extract_coordinates_new.py'
os.system(command1)

command2 = 'abaqus cae noGui=report_time_new.py'
os.system(command2)

command3 = 'abaqus cae noGui=organise_time_files_new.py'
os.system(command3)

os.remove('extract_coordinates_new.py')
os.remove('report_time_new.py')
os.remove('organise_time_files_new.py')

##print('output from: thrombus_'+str(l)+'_'+str(f)+'_'+str(s)+'_run.odb complete')
  





