/* Battery Holder */
use <../lib.scad>
$fn=100;

lineHeigth=0.20;
lineWidth=0.80;

// AA
bat_len  = 50.5;
bat_diam = 14.5;

// AAA
//bat_len  = 44.5;
//bat_diam = 10.5;

height= bat_diam*6;
thick = 2;
tol = 1;

/************************************/
w=multiple(bat_len+tol, lineWidth);
l=multiple(bat_diam+tol, lineWidth);
h=multiple(height, lineHeigth);
bh=multiple(bat_diam, lineHeigth);
t=multiple(thick, lineWidth);
th=multiple(thick, lineHeigth);
r=3;


translate([t,t,th]) xrtriangle(l/2,w);

difference(){
    union(){
        // Base
        roundCube(w+t*2,l*2+t*2,bh*.6+th, r); 
        
        roundCube(w+t*2,l+t*2,h+th, r);
        nccube(w+t*2,l/ 2,h+th, r);        
    }
    
    translate([t,t,th]){
        roundCube(w,l*2,bh*1.25);     // Base
        roundCube(w,l,h+th);

        translate([w/4,l/2,h/3])
        nccube(w/2,l,h+th);        
    }
    
}
