use <../lib.scad>
$fn=100;

axis=8;
thick=10;
len=52;
top_screw=len+8-12.5;

//mirror()
{
    //translate([0,5,thick]) rotate([-90,0,0])
    y_axis_support();
    //translate([0,20, thick-1]) rotate([-90,0,0])
    y_axis_clamp();
}
/**
    y_axis_support();
    y_axis_clamp();
/*
mirror([0,1,0])
translate([0,10,thick]) rotate([-90,0,90])
y_axis_support();
mirror([1,0,0])
translate([40,0, thick-2]) rotate([-90,90,90])
y_axis_clamp();
*/

//screws();

module screws(){
    /* M3 Screws */
    %translate([-2,4.5,35])             
    rotate([-90,0,-90]) 
    Mscrew(15);  
    
    /* M5 Screws */
    %translate([19,-5,top_screw])             
    rotate([-90,0,0]) 
    Mscrew(15, 5);
    %translate([19,-5,14])             
    rotate([-90,0,0]) 
    Mscrew(15, 5);        
}    
module y_axis_support(){
    difference(){
        union(){
            // corpo
            translate([9,0,7]) 
            cube([17,thick,len]);

            // encaixe
            translate([-6,0,7]){ 
                cube([17,thick,7]);
                cube([7,thick,14]);
            }
        }

        // Axis
        translate([10,15,26])             
        rotate([90,0,0]) 
        cylinder(d=axis,h=20);

        // M3 Screws
        translate([0,thick/2,35])             
        rotate([-90,0,-90]) 
        cylinder(d=3.5,h=30); 
       // M3 Nut
        translate([26,thick/2,35])             
        xnut();
        
        // M5 Screws
        translate([19,2, top_screw])             
        rotate([0,90,90]) 
        roundCube(8,5,20,2,true);
        translate([19,-5, top_screw])             
        rotate([0,90,90]) 
        roundCube(13,10,20,3,true);
            
        translate([19,-7,14])             
        rotate([-90,0,0]) 
        Mscrew(15, 5.5);
        translate([19,-thick,14])             
        rotate([-90,0,0]) 
        cylinder(d=10,h=15);
    }
}
module y_axis_clamp(){    
    difference(){
        union(){
            // corpo
            translate([1.2,0,14.3]) 
            cube([thick-2.5,thick-1,26]);
        }
        union(){
            // Axis
            translate([10,15,26])             
            rotate([90,0,0]) 
            cylinder(d=axis,h=20);
            
            // M3 Screws
            translate([-2,4.5,35])             
            rotate([-90,0,-90]) 
            Mscrew(15);  
        }
    }
}
