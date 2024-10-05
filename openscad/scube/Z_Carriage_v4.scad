// www.thingiverse.com/thing:2756180 recreated in openscad.
// quick and dirty 3d trace, lots of hard coded variables all over the place.
// designed so you can change the bearing cutout and rod cutout sizes easily.  
/*
LM12LUU
Inside Diameter: 12mm
Outside Diameter: 21mm
Length: 57mm
*/
include <config.scad>
use <bearing-holder.scad>
use <parts.scad>
use <../lib.scad>
use <../ruler.scad>
$fn=150;

rod_cutout_diameter = 13; //12 is the default
bearing_cutout_diameter = 21; //16 is the default
bearing_cuttout_length = 57; //25.6 is the default
w=bearing_cutout_diameter+12;
l=bearing_cuttout_length+3;
h=bearing_cutout_diameter/2 + 1.5;
bd=bearing_cutout_diameter;
clamp_height=10;
clamp_width=w;
clamp_depth=13;
shorten=0.3;
m3=3.3;

frame_chanel=6;
w_framebed=310;
t=10;


    /* frame */
        color("grey") 
        translate([0,10,-10]) 
        cube([300,20,20], center=true);
        
translate([0,0,-40])  nema14ls();
translate([0,-15,0])  z_carriage();

//bed_support();

module bed_support(){
    depth=40;
    height=4;
    diam=8;
    thick=1;
    m3=3.5;
    
    difference(){
        translate([0,0,10])
        union(){
            ccube(w_framebed,t,20);
            translate([0, depth, 0])
            ccube(w_framebed,t,20);
            
            translate([-w_framebed/2 +t/2, depth/2-t/2,0])
            ccube(t,depth,20);
            translate([+w_framebed/2 -t/2, depth/2-t/2,0])
            ccube(t,depth,20);
            
            translate([0,-10,-5])
            ccube(40,30,10);

            /* Coil guide */
            translate([0,-15,0])
            difference(){
                cylinder(h=height, d=diam+thick*2);

                translate([0,0,thick])
                cylinder(h=height, d=diam);
                // M3 screw
                translate([0,0,-0.1])
                cylinder(h=height, d=m3);    
            }                
        }
        
        translate([0,-15,-5])
        cylinder( d=3.5, h=30);
        // left hole
        translate([-w_framebed/2-10, depth/2, 10])
        xcylinder(5.5,30);
        translate([-w_framebed/2+5, depth/2, 10])
        xcylinder(10,30);
        // right hole
        translate([w_framebed/2-10, depth/2, 10])
        xcylinder(5.5,20);
        translate([w_framebed/2-25, depth/2, 10])
        xcylinder(10,20);
    }
}

module  z_carriage(){
    translate([-30,-8.5,29])
    rotate([180,0,0])
    import("stl/Z_Mount_with_T8_Thread.STL");

    /* left */
    translate([-87.5,-6,28.5])
    rotate([90,0,90])
    mirror([1,0,0])
    bholder();
    difference(){
            translate([-107.5,-54,2.5])
            nccube(20,62.5,5);

        translate([-100,14,17.5])
        xcylinder(5.5,50);
        translate([-82,14,17.5])
        xcylinder(10,15);
        
        translate([-97.5,14,-1])
        zcylinder(5.5,50);
        translate([-97.5,-44,-1])
        zcylinder(5.5,50);
        
    }

    /* right */
    translate([87.5,-6,28.5])
    rotate([90,0,-90])
    bholder();
    difference(){
            translate([87.5,-54,2.5])
            nccube(20,62.5,5);

        translate([70,14,17.5])
        xcylinder(5.5,50);
        translate([67,14,17.5])
        xcylinder(10,15);

        translate([97.5,14,-1])
        zcylinder(5.5,50);
        translate([97.5,-44,-1])
        zcylinder(5.5,50);
    }

    /* center */
    difference(){
        union(){
            translate([87.5,-30,2.5])
            mirror([1,0,0])
            quadz(50,35,20,25, false);
            translate([-87.5,-30,2.5])
            quadz(50,35,20,25, false);

            difference(){
                translate([0,-29,15])
                ccube(175,10,25);
                
                //  Lead Nut
                translate([0,-20,10])
                quadz(20,50,22,50,true);                
            }
            translate([0,-44,5])
            ccube(175,20,5);            
        }
        
        // bearing
        translate([73,-6,-20])
        cylinder(d=21, h=200);
        translate([-73,-6,-20])
        cylinder(d=21, h=200);
 
        // Screws Center
        translate([-45,0,17.5])
        ycylinder(5.5,50);
        translate([-45,-10,17.5])
        ycylinder(10,19);
        
        translate([45,0,17.5])
        ycylinder(5.5,50);
        translate([45,-10,17.5])
        ycylinder(10,19);

        // low        
        translate([-32.5,-44,-1])
        zcylinder(5.5,50);
        translate([32.5,-44,-1])
        zcylinder(5.5,50);
        
        // Nut slot
        translate([-59.8,-25,30])
        quady(5,15,10,50,true);        
        // Nut slot
        translate([59.8,-25,30])
        quady(5,15,10,50,true);
    }


    /* bed *
    translate([0,-170,30]) 
    #ccube(250,220,1);

        color("white") 
        translate([0,-41,17.5]) {
        cube([200,20,20], center=true);
        translate([-97.5,-94,0])
        cube([20,310,20], center=true);
        translate([97.5,-94,0])
        cube([20,310,20], center=true);
        }
        
    
    /**/
}
