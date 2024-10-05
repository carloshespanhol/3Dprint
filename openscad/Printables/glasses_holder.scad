/* Battery Holder */
use <../lib.scad>
$fn=100;

lineHeigth=0.20;
lineWidth=0.80;

width=15;
width_glasses=3;
length=50;
height= 15;
thick = 2;
tol = 0.5;

/************************************/
w=multiple(width+tol, lineWidth);
wg=multiple(width_glasses+tol, lineWidth);
l=multiple(length+tol, lineWidth);
h=multiple(height, lineHeigth);
t=multiple(thick, lineWidth);
th=multiple(thick, lineHeigth);


nccube(t,l,h);   
translate([w+t,0,0]) rotate([0,0,5]){
    nccube(t,l,h);
    
    translate([wg+t/4,l/2,0]) rotate([0,0,-4])
    nccube(t,l/2,h);
}

difference(){
    union(){
        translate([w/2+t,0,0]) zcylinder(w+t*2,h);
        translate([w+t,0,0]) rotate([0,0,5]){
            translate([wg/2+t,l,0]) zcylinder(wg+t*2,h);
        }
    }

    
    translate([w/2+t,0,-.1]) zcylinder(w,h+1);
    translate([0,0.5,-.1])nccube(w*2,w,h+1);
    
    translate([w+t,0,0]) rotate([0,0,5]){
        translate([wg/2+t,l,-.1]) zcylinder(wg,h+1);
        translate([t,l-wg-t,-.1])nccube(wg,wg+t,h+1);
    }
   
}
