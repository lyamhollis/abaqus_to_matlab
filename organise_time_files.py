odb_file_locs
output_file_locs

import os
import io
import csv
import re


#USER INPUTS:
##path = "J:\PhD\extraction_test"

for i in range(1,9):

    text_file = output_location+'time_'+str(i)+'_report.rpt'

    ##path = input('Location of .inp file directory: ')
    ##text_file= input('enter name of .inp file to import: ')

    #THIS SECTION PLACES EACH LINE OF THE FILE CORRESPONDING TO THE NODAL COORDINATES INTO A LIST:
    parsed_lines=[]
    with open(text_file, 'r') as file:
        for lines in file:
            #this next line uses a regular expression to extract the line featuring the current node
            #only when it conforms to the following pattern node id, x, y, z. This eliminates
            #the program accidently picking up occurances of the node later when connectivity is being described
            nodal_lines=re.match(r'^\s+\d+\s+\S+\s+\S+\s+\S+\s+$',lines)
            if nodal_lines:
                parsed_lines.append(lines)
                    
    file.close()

    #THIS SECTION WRITES THE CONTENTS OF COORDS OUT TO A NEW TEXT FILE BASED ON THE .CSV FILE NAME:
    output=output_location+'time_'+str(i)+'.txt'
    with open(output,'w') as new_file:
        for lines in parsed_lines:
            new_file.write(lines)
        new_file.close()

for j in range(1,9):    
    os.remove(output_location+'time_'+str(j)+'_report.rpt')
