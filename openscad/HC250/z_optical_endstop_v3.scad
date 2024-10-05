include <config.scad>
use <../lib.scad>
$fn=64;

sensor();
//translate([-10,0,2]) rotate([0,180,0]) 
//lock();
flag();

module lock(){
    difference(){
        union(){
            // body
            translate([20,-18,0])
            cube([23,16,5]);
            
            // Chanel lock
            translate([17,-13,-6])
            cube([10,6,8]);
            
            // cover
            translate([-25,-18,15.5])
            cube([43,16,4]);
            
            translate([16.5,-18,0])
            cube([4,16,19.5]);
            
        }
        // 5mm screw
        translate([35,-10,-0.01])
        cylinder(h=10, d=5.7); 
        // M3 screw
        translate([23.5,-10,9])
        rotate([0,-90,0])
        Mscrew(40);
    }
}

module flag(){
    al=78;
    h=8;
    translate([50,0,0])
    difference(){
        union(){
            // body
            translate([-3,-20,0])
            cube([22,40,4]);
            
            // Chanel lock
            translate([14,-13,0])
            cube([5,6,10]);
            translate([-3,-13,0])
            cube([5,6,10]);
           
            // arm 
            rotate([0,0,15])
            hull(){
                rotate([0,0,-15])
                translate([-3,20,0])
                cube([22,1,4]);
                
                translate([4.5,25,0])
                cube([6.5,al-25,h]);
            }
            
            //flag
            rotate([0,0,15])
            translate([7,al,0])
            cube([1.5,12,h]);
        }
        translate([-10,-.1,4])
        cube([30,20,10]);

        // 5mm screw
        translate([8,-10,-0.01])
        cylinder(h=10, d=5.7);    
    }
}

module sensor(){
#translate([8,30,1.5])
rotate([0,0,90])
import("./stl/optical_endstop.stl");
    
    difference(){
        union(){
            translate([0,-18,0])
            cube([16,70,5]);
            
            translate([-14,-18,0])
            cube([30,16,15]);
            
            // chanel lock
            translate([-12,-13,-6])
            cube([28,6,8]);
            
        }
        /******************************/
        translate([2.5,13,-0.01])
        union(){
            translate([5.5,12,-1])
            cylinder(h=10, d=3.5);

            translate([5.5,30,-1])
            cylinder(h=10, d=3.5);

            cube([11,7,10]);
        }    
        
        // M3 screw
        translate([22,-10,9])
        rotate([0,-90,0])
        Mscrew(40);
        
        // nut pocket
        translate([11,-10,9])
        rotate([90,0,-90])
        MnutPocket(1);
        
        
        /* 5mm screw
        translate([8,-10,-0.01])
        cylinder(h=10, d=5.7);    
        // Recess
        translate([1.5,0,1.5])
        cube([13,100,8]);
        
        // lock
        translate([-3,-17,-0.01])
        cube([22,14,2]);
        /**/
    }

    /* End border
    translate([0,50,0])
    cube([16, 1.5,5]);
    /**/
}


