use <../lib.scad>
$fs=0.1;
$fn=64;
size=100;
height=20;
thick=1;
innersize=size-thick*2;

difference(){
    union(){
        rcube(size,size,height,10);
        translate([size-20,0,0])
        cube([20,size,height]);
    }
    translate([thick,thick,-0.1])
    union(){
        rcube(innersize,innersize,height+thick,10);
        translate([innersize-20,0,0])
        cube([20,innersize,height+thick]);
    }
}    