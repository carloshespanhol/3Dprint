use <../lib.scad>
$fn=100;

lineHeigth=0.20;
lineWidth=0.80;

dout=75;
height=15;
thick=1.01;
hole=20;

hole_pos=5;
din = 63.5;

//hole_pos=-55;
//din=60;

/************************************/
h=multiple(height, lineHeigth);
t=multiple(thick, lineWidth);
th=multiple(thick, lineHeigth);


cap();


module cap(){
difference(){
    union(){
        cylinder(d=dout, h=th);
        difference(){
            cylinder(d=din, h=h);
            cylinder(d=din-t*2, h=h+1);
        }
    }

    //------------------------------------------------------  
    translate([-hole_pos,0,0]){
        translate([din/2,0,-.1])
        cylinder(d=hole, h=h*2);
        translate([din/2,-hole/2,-.1])
        cube([hole,hole,h*2]);
    }
    /**/
}    
}