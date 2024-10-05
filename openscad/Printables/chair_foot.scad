use <../lib.scad>
$fn=200;


do=19;
di=16.5;
t=2;
h=6;



difference(){
    union(){
        cylinder(d=do, h=t);
        
        translate([0,0,t])
        cylinder(d1=di, d2=di-0.5, h=h);
    }



}