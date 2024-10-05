//import("/Users/carloshespanhol/Downloads/endstopy.stl");
/*
import("/Users/carloshespanhol/Downloads/HCY_Stop.stl");

color("blue")
cube([30,4,30]);
*/

$fn=64;

difference(){
    union(){
        cube([20.5,56.5,5]);
        
        translate([-20,0,0])
        cube([40.5,23,9]);

        translate([-2.5,0,0])
        cube([2.5,30,5]);
    }

    // Wire pass
    translate([5,4,4])
    cube([30,5,6]);
    
    translate([-30.5,3,-0.01])
    cube([27,17,5]);

    translate([0,29.5,0])
    union(){
        translate([3,3.5,-1])
        cylinder(h=10, d=3.5);

        translate([3,22.5,-1])
        cylinder(h=10, d=3.5);

        translate([7,5.5,-1])
        cube([3,15,10]);
    }    
    translate([2.5,27,-1])
    cube([10,3,10]);
    
    // 5mm screw
    translate([-12,11.5,0])
    cylinder(h=10, d=5.7);    
    
    translate([-0.01,4.01,1.5])
    cube([18,57.01,8]);

}

// End border
translate([0,56.5,0])
cube([20.5, 2.5,5]);



