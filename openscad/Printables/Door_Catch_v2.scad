/*---------------------------------------------------------
Parametric Door Catch.
Design by Jon Frosdick em: jon@bee53.com on 05-Mar-2019.

licenced under Creative Commons :
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
http://creativecommons.org/licenses/by-nc-sa/4.0/

Remixed from: https://www.thingiverse.com/thing:891278  by Worlds6440

Basic Instructions - OpenSCAD:
1. The parameters below can be adjusted, though not all need to be.
2. make any required changes then hit F5 to view the model.
3. Press F6 to render and then export to STL.
4. Slice in your favourite software and print.

Note: There is no error checking so you need to use commnon-sense when changing parameters. For example
 there is nothing stopping you from entering screw hole diameters larger than the wall plate width except
 your own good judgement. Or hell, go for it just for the giggles...

v1.01 - updated Tolerance variable to accpet whole numbers - Customizer compatibility issue.
v1.0 - First upload 05-Mar-2019
---------------------------------------------------------*/
//CUSTOMIZER VARIABLES
//these most likely should be changed

//Show pieces together? "true" = see how tolerances look, "false" = ready to print
ShowTogether = "false"; //[true,false]

//The diameter of the ball.
BallD = 10; //[3:25]

//The tolerance in % between the ball and the socket (higher numbers = looser) - note: makes ball smaller, not the socket larger.
Tolerance = 2; //[0:5]

//Rounded or square wall plate. "true" = rounded corners, "false" = square corners.
WPRounded = "true"; //[true,false]

//The height the wall plate extends from door when fitted in mm.
WPThickness = 3; //[1.5:8.0]

//The width of the wall plate in mm.
WPWidth = 11; //[5:25]

//The length of the wall plate in mm.
WPLength = 35; //[10:90]

//The diameter of the screw hole in mm.
ScrewD = 4; //[0:7.5]

//The depth in mm of the screw countersink (must be smaller than thickness).
ScrewCS = 1.5; //[0:3.0]

//How many times bigger the top of the countersink section is than the screw hole diameter.
ScrewCSFactor = 2; //[1.0:3.0]

//The thickness of the arm part in mm.
ArmThickness = 3.2; //[1.0:10.0]

//The thickness of the socket in mm.
SocketThickness = 3.2; //[1.0:10.0]

//The distance from door to centre of ball socket in mm (Note: StandoffF + StandoffM = Total length of the two connected pieces.)
StandoffF = 13; //[5:75]

//The distance from wall to centre of ball in mm (Note: StandoffF + StandoffM = Total length of the two connected pieces.)
StandoffM = 12; //[5:75]

//the portion of the socket that is removed in degrees. Note the rounded edges are added back on after so resultant gap is always smaller than this.
GapAngle = 140; //[100:145]

//
AngSup = "true";


//CUSTOMIZER VARIABLES END
//---------------------------------------------------------------------------------------
//You should not need to make any changes below this line.
$fn=100;



makeLayout();




//Assemble pieces and display accordingly
module makeLayout(){       
    if (ShowTogether == "true"){
        makeMale();
        translate([StandoffF+StandoffM, 0, WPWidth])
        rotate([0, 180, 0])
        makeFemale();
    } else {
        translate([StandoffF+20+BallD/2+SocketThickness,0,0])
        makeMale();
        translate([StandoffF+BallD/2+SocketThickness, 0 , WPWidth])
        rotate([0, 180, 0])
        makeFemale();
    }
}



module makeMale(){
    translate([0, WPWidth/2,WPWidth/2])
    rotate([0,90,0])
    makeWallPlate();
    
    translate([StandoffM/2, WPLength/2,WPWidth/2])
    makeArm(StandoffM, ArmThickness, WPWidth);
    
    translate([StandoffM, WPLength/2,0])
    makeBall();
   
}


module makeFemale(){
    union(){
        if (AngSup == "true"){
            translate([0, WPWidth/2 , WPWidth])
            mirror([0,0,1])
            makeWallPlate();
            // Strength
            hull(){
                translate([0, WPLength/2,WPWidth-ArmThickness/2])
                cube([WPWidth, ArmThickness*2, ArmThickness], center=true);

                translate([WPThickness+(StandoffF-BallD)/2, WPLength/2,WPWidth/2])
                makeArm(StandoffF-BallD, ArmThickness, WPWidth);
            }
            /*
            translate([WPThickness+(StandoffF-BallD)/2, WPLength/2,WPWidth/2-ArmThickness/2])
            makeArm(StandoffF-BallD, ArmThickness, WPWidth+ArmThickness);
            
            translate([StandoffF, WPLength/2,-ArmThickness])
            makeSocket();
            */
        }else{       
            translate([0, WPWidth/2,WPWidth/2])
            rotate([0,90,0])
            makeWallPlate();
        }
        
        translate([WPThickness+(StandoffF-BallD)/2, WPLength/2,WPWidth/2])
        makeArm(StandoffF-BallD, ArmThickness, WPWidth);
        
        translate([StandoffF, WPLength/2,0])
        makeSocket();
    }
}


module makeWallPlate(){
    difference(){
        if (WPRounded == "true") { //rounded corners
            hull(){
                translate([0, WPLength-WPWidth, 0])
                linear_extrude(WPThickness)
                circle(d=WPWidth);
                
                translate([0, 0, 0])
                linear_extrude(WPThickness)
                circle(d=WPWidth);
            }
        } else { //square corners   
            hull(){
                translate([0, WPLength-WPWidth, 0])
                linear_extrude(WPThickness)
                square(WPWidth, center=true);
                
                translate([0, 0, 0])
                linear_extrude(WPThickness)
                square(WPWidth, center=true);
            }
        }
        translate([-0.5, 0, 0])
        makeCountersunkScrewhole(WPThickness, ScrewD, ScrewCS, ScrewCSFactor);
        translate([0.5, 0, 0])
        makeCountersunkScrewhole(WPThickness, ScrewD, ScrewCS, ScrewCSFactor);
        
        translate([-0.5, WPLength-WPWidth, 0])
        makeCountersunkScrewhole(WPThickness, ScrewD, ScrewCS, ScrewCSFactor);
        translate([0.5, WPLength-WPWidth, 0])
        makeCountersunkScrewhole(WPThickness, ScrewD, ScrewCS, ScrewCSFactor);
    }
}


module makeCountersunkScrewhole(Z=10, D=4, CSZ=4, CSF=2){
    translate([0, 0, -.1])
    cylinder(Z, d=D); //screwhole
    translate([0,0,Z-CSZ])
    cylinder(CSZ+.1, d1=D, d2=(D*CSF)); //countersink
}


module makeArm(X, Y, Z){
    //TODO maybe add strength here later if needed
    cube([X, Y, Z], center=true);
}


module makeSocket(){
    union(){
        difference(){
            //Outer cylinder
            cylinder(WPWidth, d=BallD+SocketThickness*2);
            
            //Subtract
            //Inner cylinder
            translate([0,0,-.1])
            cylinder(WPWidth+1, d=BallD);
            
            //and the Wedge
            translate([0,0,-.1])
            linear_extrude(WPWidth+1)
            polygon([[0,0],[5*(BallD+SocketThickness)*cos(GapAngle/2), 5*(BallD+SocketThickness)*sin(GapAngle/2)] ,[5*(BallD+SocketThickness)*cos(GapAngle/2), -5*(BallD+SocketThickness)*sin(GapAngle/2)]]); 
        }
    }
    translate([(BallD+SocketThickness)/2*cos(GapAngle/2), (BallD+SocketThickness)/2*sin(GapAngle/2),0])
    cylinder(WPWidth, d=SocketThickness);
    
    translate([(BallD+SocketThickness)/2*cos(GapAngle/2), -(BallD+SocketThickness)/2*sin(GapAngle/2),0])
    cylinder(WPWidth, d=SocketThickness);
}


module makeBall(){
    cylinder(WPWidth, d=BallD*(1-Tolerance/100));
}