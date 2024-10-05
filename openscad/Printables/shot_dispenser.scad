/**/
translate([0,4.25,90])
rotate([0,90,0])
import("/home/hespanhol/OneDrive/openscad/Printables/shotsdispenser.stl");
    
translate([0,0,31])
cylinder(d=30, h=4);

    
/**
use <../lib.scad>
$fn=100;

difference(){
    union(){
        /*
        hull(){
            cylinder(d=63, h=.1);
        
            translate([0,0,20])
            cylinder(d=35, h=.1);
        }
        translate([0,0,20])
        cylinder(d=35, h=40);
        translate([-5,-16,20])
        rotate([45,0,0])
        rcube(10,10,40,2);
    }
    //------------------------
     translate([-10,-23,49])
     rotate([0,90,0])
     cylinder(d=12, h=20);
     translate([-10,-23,60])
     rotate([45,0,0])
     #cube([20,20,1]);
    hull(){
        translate([0,0,-.1])
        cylinder(d=55, h=.1);
        translate([0,0,20])
        cylinder(d=28, h=.1);
    }
    hull(){
        translate([0,0,20])
        cylinder(d=28, h=.1);
        translate([0,0,23])
        cylinder(d=18, h=4);
    }
}    
/**/
