odb_file_locs
output_file_locs

import os
import io
import csv
import glob

from abaqus import *
from abaqusConstants import *
from odbAccess import *



##path = 'J:/PhD/extraction_test/'
####path = raw_input('input path to .odb file: ')
##target_files = [f for f in os.listdir(path) if f.endswith('.odb')]
##a=int(len(target_files))

##path = "J:\PhD\extraction_test"
##text_file = "thrombus_70mm_50Hz_1kPa_run.inp"

#Main loop

##filename = 'thrombus_70mm_50Hz_1kPa_run.inp'
filename=odb_location
o1 = session.openOdb(name=odb_location)

##for i in range (0,a):
##    jobfile = target_files[i]
##    patient_ID = jobfile.split('.odb')[0]
##    filename = path+'\\'+jobfile
##    o1 = session.openOdb(name=filename)

# find the instances in the model and store them
instanceName = o1.rootAssembly.instances.keys()
numInstance = len(instanceName)

for j in range(0,numInstance):
    
        part_instance = o1.rootAssembly.instances[instanceName[j]] #loop over for all parts

        outFile = open('coords_'+str(j)+'_part.txt' , 'w' ) #modify based on line above

        numNodesTotal = len( part_instance.nodes )

        for ii in range( numNodesTotal ):

            curNode =  part_instance.nodes[ii]

            defNodePos = curNode.coordinates #+ dispField.values[i].data

            outFile.write( '\n' )

            for jj in range( 3 ):

                outFile.write( str( defNodePos[jj] ) + ' ' )
        outFile.close()

read_files = glob.glob('*_part.txt')

with open (output_location+'coords.txt','wb') as outfile:
    for f in read_files:
        with open (f,'rb') as infile:
            outfile.write(infile.read())

for j in range(0,numInstance):
    os.remove('coords_'+str(j)+'_part.txt')

o1.close()

            
