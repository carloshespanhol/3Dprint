//-- Spool Hub with 608zz bearing
//-- remixed from thing #545954 by mateddy (James Lee)
//-- commented source and eliminated some sharp edges,
//-- reinforced legs a little bit
//-- AndrewBCN - December 2014
//-- GPLV3
use <../lib.scad>
include <config.scad>

// Parameters
/* 3DX * Muito Ruim
spoolDiameter = 72;
spoolMaxDiameter = 80;

/* 3D Prime *
spoolDiameter = 52;
spoolMaxDiameter = 60;

/* 3D Fila *
spoolDiameter = 48.5;
spoolMaxDiameter = 65;

/* eSun *
spoolDiameter = 51.5;
spoolMaxDiameter = 58;

/* National 3D *
spoolDiameter = 72;
spoolMaxDiameter = 80;

/*  */
spoolDiameter = 57;
spoolMaxDiameter = 72;
/*****/

// Spool hub height
HolderHeight = 7;

useBearing=1;
// Bearing diameter (22 mm for 608 ZZ/2RS)
bearingDiameter = 22;

// Bearing height (7 mm for 608 ZZ/2RS)
bearingHeight = 7;



r_spool = spoolMaxDiameter/2; // radius of spool hub 

edge_cut=3;   // decreases by edge edge_cut

h = HolderHeight;
w = 20;     // Legs width

bd = bearingDiameter;
br = bearingDiameter/2 ; // bearing radius with tolerance for insertion
bh = bearingHeight;     // bearing height
th=4;   // top height
t=4;

ir = 7.8 / 2;  // threaded rod radius + ample tolerance

$fn = 100;

// Print the part
simplehub();

// Modules
module simplehub() {
    r = spoolDiameter/2; // radius of spool hub 
    
    /* sacrifice bridge */
    if(useBearing){
        translate([0,0,bh-.1])
       # cylinder(d=bd, h=0.2);
    }
    
    difference() {
        union(){
            if(useBearing){
                /* top */
                translate([0,0,bh]) 
                cylinder(r1=br+t,r2=br+t/2, h=th);
                /* central cylinder */
                cylinder(r=br+t, h=bh);
            }
            cylinder(r=r, h=h);
            /* base */
            cylinder(r=r_spool, h=3);
        }
        
        // central hole for threaded rod
        translate([0,0,-.1])
        cylinder(r=ir, h=h*4);
        
        if(useBearing){
            /* space for bearing */
            translate([0,0,-.1]){
                cylinder(d=bd+pressfit, h=bh);
                
                cylinder(d=13, h=h*4);
            }
        }
        /**/                                      
        difference(){
            translate([0,0,-0.1])
            cylinder(r=r-4, h=h+th+.5);
            
            translate([0,0,-0.2])
            cylinder(r=br+t, h=h+th+1);
        }
        /**/
    }
    
    
    /**/
    difference(){
        union(){
            for(i = [0:1:3] ){ 
                rotate([0,0,90*i])
                hull(){
                    translate([-r+2,-7,0])
                    scube(.1,14,h-0.01);
                    translate([-r/2+1,-4,0])
                    scube(.1,8,h-0.01);
                }
            }
        }
        /******************************/
        // central hole for threaded rod
        translate([0,0,-.1])
        cylinder(d=(ir*2)+1, h=h*4);
        
        // space for bearing
        translate([0,0,-.1]) 
        cylinder(d=bd+pressfit, h=bh);
    }
    /**/
}
