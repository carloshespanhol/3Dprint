$fn=200;

use <../../lib.scad>

x=60;
y=15;
h=5;
r=5;
pw=10;

calib();

module calib(){
    difference(){
        union(){
            rcube(x,y,h,r);
        }
        
        translate([5,-.01,-.1])
        cube([pw,y-5,h+1]);

        translate([x-2.5-2,y/2,-.1])
        cylinder(d=5, h=h+1);
    }
}    

