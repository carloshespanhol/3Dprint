use <../sc.scad>
use <../lib.scad>
use <../ISOThread.scad>
$fn=200;
print=1;


cylinder(r=8,h=2,$fn=5);
iso_thread(m=8.5, p=2 ,l=7 ,t=0);

D=8.5;
f=2;
Tx(20)
difference() {
    union() {
        cylinder(h=3,d=D*1.5);
    }
    //--------------------------------------------
    fillet_r(f,D/2);
    
    translate([0,0,2.5])
    mirror([0,0,1])
    fillet_r(f/2,D/2);
    
    iso_thread(m=D ,p=2 ,l=5, t=0.2);
}        

