include <config.scad>
use <../lib.scad>
use <parts.scad>
use <Z_Carriage_v4.scad>
use <../ruler.scad>
$fn=32;

//#translate([0,l/2-t-17.5,0]) ccube(w,.5,h);

frame();
translate([0,0,-11]) yaxis();
translate([0,0, 4.5]) xaxis();
//translate([0,l/2-t,0]) nema14ls();

translate([-w/2+bush_width*.4,  0, h+bush_width-axis])  xyjoiner();

translate([0,0,h+bush_width]) x_carriage();
translate([0,0,h+bush_width+48]) rotate([0,180,90]) %e3d();

translate([-w/2, l/2, h]) {
motor_support();
stepper();
}

//translate([-w/2, -l/2, h])      idler();


/*
translate([0,l/2-t-11.5,50])  {
    z_carriage();
    // z axis
    translate([73,-6,-50])
    %cylinder(d=12, h=h);
    translate([-73,-6,-50])
    %cylinder(d=12, h=h);
}
/**/

module x_carriage(){
    difference(){
        ccube(bush_len, axis_distance, bush_width/2);

        ccube(bush_len/3*2, axis_distance/2, bush_width);
    }
}    
/*
    color("silver") 
    translate([12.5,23,axis+4.5]) 
    {
    gt2_idler();
    translate([13,14,9.5]) 
    gt2_idler();
    }
*/
module xyjoiner(){
    color("silver") 
    translate([26,0,bush_width+axis/2+1]) 
    {
    translate([0,-10,0]) 
    gt2_idler();
    translate([0,10,0]) 
    gt2_idler();
    }
    
    difference(){
        union(){
            translate([6,-(axis_distance+axis*2)/2,axis])
            roundCube(27, axis_distance+axis*2, axis*2,3);
        }
        translate([t/2+1,axis_distance/2, 21])
        mirror([0,1,0])
        {
            
             // Bearing screws
            translate([17,-7,-18])
            rotate([0,0,0])
            Mscrew(30);
            translate([17,-7,-28.01])
            cylinder(h=24,d=6);            
            translate([4,7,10])
            rotate([180,0,0])
            Mscrew(22);
            translate([4,7,4])
            cylinder(h=30,d=6);
            
            // Bearing Nut        
            translate([17,-6,13])
            rotate([0,0,180])
            MnutPocket();
            translate([7,6,-15])
            MnutPocket();
        }
    }
}    
