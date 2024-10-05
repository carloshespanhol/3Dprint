use <../lib.scad>
$fn= 100;

x=60;
t=3;
tf=4;   // thick to fix to frame
h=40;
ct=20;  // cell thickness
f=10;   // front
sup_pos=10;

//rotate([0,90,0])
rotate([0,0,-90])
{
    difference(){
        union(){
            rcube(h+t,ct+t*2,x,1);
            
            translate([t,ct+t,0])
            cube([h+sup_pos-t+10,t,x]);
        }
        
        translate([-f,-t,-.1])
        cube([h,ct,x+1]);

        translate([-.1,t,-.1])
        cube([h,ct,x+1]);
    }
    // Support
    difference(){
        translate([h+sup_pos-tf, ct+t, 0])
        cube([tf,20,x]);

        // Hole
        translate([0, ct+tf+10, x/2])
        rotate([0,90,0])
        cylinder(d=5.5, h=h+sup_pos+1);
        
        // Chamfer
        hull(){
            translate([0, ct+t*2, -.1])
            cube([h+sup_pos+1,20,.1]);
            translate([0, ct+t+20, 0])
            cube([h+sup_pos+1,.1,20]);
        }
        hull(){
            translate([0, ct+t*2, x+.1])
            cube([h+sup_pos+1,20,.1]);
            translate([0, ct+t+20, x-20])
            cube([h+sup_pos+1,.1,20]);
        }
    }
}
