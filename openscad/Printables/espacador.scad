use <../lib.scad>
$fn=200;
cf=.4;  // Fit
cl=.3;  // Cleareance

ct=.3;  // Thread

lineHeigth=0.24;
lineWidth=0.48;
h=9;

difference(){
    cylinder(d=30, h=h);
    
    translate([0,0,-.1])
    cylinder(d=9, h=h);

    translate([0,0,h-5])
    cylinder(d=18, h=h);
}    
/**/