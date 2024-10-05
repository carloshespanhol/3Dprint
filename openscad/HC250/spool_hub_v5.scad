//-- Spool Hub with 608zz bearing
//-- remixed from thing #545954 by mateddy (James Lee)
//-- commented source and eliminated some sharp edges,
//-- reinforced legs a little bit
//-- AndrewBCN - December 2014
//-- GPLV3
use <../lib.scad>
include <config.scad>

// Parameters
/* 3DX *** Muito Ruim ***
spoolDiameter = 72;
spoolMaxDiameter = 80;

/* 3D Prime *
spoolDiameter = 52;
spoolMaxDiameter = 60;

/* 3D Fila *
width = 72
diam out=220;
diam fil = 94
diam in= 53

spoolDiameter = 48.5;
spoolMaxDiameter = 65;

/* eSun *
width = 61
diam out=200;
diam fil = 90
diam in= 51

spoolDiameter = 51.5;
spoolMaxDiameter = 58;

/* National 3D *
spoolDiameter = 72;
spoolMaxDiameter = 80;

/* Zonestar - Anet */
spoolDiameter = 57;
spoolMaxDiameter = 72;

/*****/

// Spool hub height
HolderHeight = 7.5;

useBearing=0;
// Bearing diameter (22 mm for 608 ZZ/2RS)
bearingDiameter = 22;

// Bearing height (7 mm for 608 ZZ/2RS)
bearingHeight = 7;

lh = .32; // lineHeight


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

$fn = 200;

// Print the part
spool_hub();

// Modules
module spool_hub() {
    r = spoolDiameter/2; // radius of spool hub 
    sbh = multiple(bh,lh)+lh;
    echo(sbh);
    
    /* sacrifice bridge */
    if(useBearing){
        translate([0,0,sbh-lh*2])
        %cylinder(d=bd+2, h=lh);
    }else{
        translate([0,0,4.7])
        %cylinder(d=bd+2, h=lh);
    }
    
    /* Center */
    difference() {
        if(useBearing){
            hull(){
                /* top */
                translate([0,0,sbh+th]) 
                cylinder(r=br+t/2, h=.1);
                /* central cylinder */
                cylinder(r=br+t, h=sbh);
            }
        }else{
            /* central cylinder */
            cylinder(r=br+t, h=h);
        }
        //-------------------------------------
        if(useBearing){
            /* space for bearing */
            translate([0,0,-.01]){
                cylinder(d=bd+pressfit, h=sbh);
                
                cylinder(d=13, h=h*4);
            }
        }else{
            /* space for nut */
            translate([0,0,-2]){
                hex(12.6, 6.7);
                cylinder(d=11, h=h*4);
            }
        }
    }
        
    
    difference() {
        union(){
            cylinder(r=r, h=h);
            /* base */
            cylinder(r=r_spool, h=2.5);
        }

        /**/                                      
        translate([0,0,-0.1])
        cylinder(r=r-4, h=h+th+.5);
    }
    
    /**/
    for(i = [0:1:3] ){ 
        rotate([0,0,90*i])
        hull(){
            translate([-r+2,-7,0])
            scube(.1,14,h);
            translate([-r/2+1,-4,0])
            scube(.1,8,h);
        }
    }
    /**/
}
