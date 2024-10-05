include <config.scad>
use <parts.scad>
use <../lib.scad>
$fn=200;

line_width=0.44;
line_height=0.20;

w=45;
l=35;
bh=3.2;
gh=1.9;
t=2;
gcut=12;

h=bh+gh+2*t;

rotate([0,0,90]){
    difference(){
        union(){
            rcube(w,l,h,2);
        }
        
        // glass cut
        translate([-.1, gcut+t*2, gh])
        cube([w+1, l,gh+1]);

        // bed cut
        translate([-.1, t*2, gh+t-.1])
        cube([w+1, l,bh]);        
    }
}
