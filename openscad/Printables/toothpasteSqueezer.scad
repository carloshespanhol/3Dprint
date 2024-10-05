$fn=200;

use <../lib.scad>

lineHeight = 0.32;
lineWidth = 0.64;
/*
slot=80;        // Cetafil
ws=1.4;         // width of slot

slot=50;        // Creme barbear
slot=65;        // Bepantol
*/
slot=60;        // Colgate
ws=0.88;        // width of slot

width=5;
height=4;

/*****************************/
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight); 
echo(w);
echo(h);

difference(){
    rcube(slot+w*2,w*2+ws,h,4);
    
    translate([w,w,-.1])    scube(slot,ws,h*2);
}   