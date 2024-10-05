use <../lib.scad>
use <../ruler.scad>
$fn=150;

size=40;
width=10;
height=10;

/*
nccube(width,size,width);
nccube(size,width,width);

rotate([0,0,45])
ccube(width,size,width);
*/

translate([0,0,height/2])
difference(){
    ccube(size,size,height);

    ccube(size-width*2,size-width*2,height*2);
}