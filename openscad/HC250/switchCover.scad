/* [Plug Options] */
//The width of the plug, in mm (The long way)
plugWidth=48;
//The height of the plug, in mm (The short way)
plugHeight=27.5;
//How far the angles on the plug should go, measured along the x axis from the right, in mm
plugChamfer=6;
//At 0, the plug will be in the bottom right corner, but not hitting the chamfer or the interior. This moves the plug left, in mm.
plugXOffset=5;
//Moves the plug up, in mm
plugZOffset=5;

/* [Size Options] */
thickness=3.84;
width=80;
height=95;

/* [Hidden] */
use <../lib.scad>
$fn=100;
/*
translate([0,-20-thickness,0]){
%scube(100,20,20);
%scube(20,20,100);
}
/**/
//switch();
cap();

module cap(){
    difference(){
        mirror([1,0,0])
        scale([1.045,1.07,0.7]) plug();
        
        mirror([1,0,0])
        translate([1.05,1.05,1.2]) plug();
        
        translate([-60,1.05,1.2]) cube([30,6,20]);
    }
}

module test(){
    difference(){
        rotate([90,0,0])
        translate([20,20,0])
        rcube(width-30,height-30,thickness,1);
        
        translate([width-20-plugWidth/2,thickness*2, height-20]) rotate([0,90,-90]) 
        plug();
    }
}
        
module plug(){
    hull(){
        rcube(plugWidth-plugChamfer,plugHeight,thickness*4,2);
        
        translate([0,plugChamfer,0])
          scube(plugWidth,plugHeight-2*plugChamfer,thickness*4);
    };
}

module switch(){
    difference()
    {
        rotate([90,0,0])
        union(){
            rcube(width,height,thickness,1);

            translate([20,20,thickness])
            difference(){
                rcube(width-20,height-20,20,1);
                
                translate([thickness,thickness,-.1])
                rcube(width-20-(2*thickness),height-20-(2*thickness),21,1);
                
                translate([thickness,height/2-20,20-2])
                rotate([-90,0,0])
                cylinder(d=2,h=20);
                translate([width-20-thickness,height/2-20,20-2])
                rotate([-90,0,0])
                cylinder(d=2,h=20);
            }
        }
        /************************************/
        // Plug
        translate([width-20-plugWidth/2,thickness*2, height-18]) 
        rotate([0,90,-90]) 
        plug();
        
        // Screws
        translate([30,0,10]) rotate([90,0,0])
        cylinder(d=5.5, h=20,center=true);
        translate([width-10,0,10]) rotate([90,0,0])
        cylinder(d=5.5, h=20,center=true);

        translate([10,0,30]) rotate([90,0,0])
        cylinder(d=5.5, h=20,center=true);
        translate([10,0,height-10]) rotate([90,0,0])
        cylinder(d=5.5, h=20,center=true);
        
         // lateral screw
        translate([19,-20-thickness+10-3.5,height-20])
        rcube(11,7,11,.1,0);
        translate([width-20,-20-thickness+10-3.5,19])
        rcube(11,7,11,.1,0);
    }
}