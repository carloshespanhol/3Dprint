use <../lib.scad>
$fn=64;

nozzle=0.6;
lineHeight=0.20;
lineWidth=0.88;

width=40;
length=30;
height=2;
thick=0;
base=5;
top=1;
/*********************************/
w=multiple(width, lineWidth);
l=multiple(length, lineWidth);
h=multiple(height, lineHeight);
t=multiple(top, lineWidth);

rough_skin(w,l,h,base,t);
