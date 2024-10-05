include <config.scad>
use <parts.scad>
use <../lib.scad>
$fn=200;

line_width=0.44;
line_height=0.20;

w=30;
l=50;
bh=3;
gh=1.9;
t=2;
gcut=25;
gsup=12;

h=bh+gh+2*t;

//rotate([0,0,90])
{
    difference(){
        union(){
            rcube(w,l,h,2);
        }
        
        // bed cut
        translate([-.1, gcut+t*2, t])
        cube([w+1, l,bh]);

        // glass cut
        translate([-.1, t*2, bh+t-.1])
        cube([w+1, l,gh]);
        
        translate([-.1, gsup+t*2, t+bh])
        cube([w+1, l,h]);
    }
}
