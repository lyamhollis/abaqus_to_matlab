odb_file_locs
output_file_locs

from abaqus import *
from abaqusConstants import *

session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=98, 
    height=209.866683959961)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from viewerModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()

o1 = session.openOdb(
    name=odb_location)
session.viewports['Viewport: 1'].setValues(displayedObject=o1)

for i in range(1,9):

    session.writeFieldReport(fileName=output_location+'time_'+str(i)+'_report.rpt', append=OFF,
        sortItem='Node Label', odb=o1, step=0, frame=i, outputPosition=NODAL, 
        variable=(('U', NODAL, ((COMPONENT, 'U1'), (COMPONENT, 'U2'), (COMPONENT, 
        'U3'), )), ))
