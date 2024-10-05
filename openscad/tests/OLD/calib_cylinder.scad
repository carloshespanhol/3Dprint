use <../lib.scad>
$fn=200;

size=40;
thick=2;
height=5;

difference(){
    cylinder(d=size, h=height);

    translate([0,0,-.1])
    cylinder(d=size-thick*2, h=height+1);
}