use <../lib.scad>

$fn= 64;  // Circle 
thickness=1.2;

difference(){
    roundCube(40,40,thickness,4,true);
    
    // Holes
    translate([0,0,-1]) cylinder(2,11.5,11.5);

    translate([15.5,15.5,-1]) cylinder(2,2,2);
    translate([-15.5,15.5,-1]) cylinder(2,2,2);
    translate([15.5,-15.5,-1]) cylinder(2,2,2);
    translate([-15.5,-15.5,-1]) cylinder(2,2,2);
}    