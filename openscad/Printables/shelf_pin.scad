use <../lib.scad>
$fn=200;
fit=.3;

pin_diameter=5.1;
pin_lenght=8;
sx=20;  // size x
sy=12;  // size y
thickness=4*0.8;
//========================
pd=pin_diameter;
pl=pin_lenght;
t=thickness;

difference(){
    union(){
        rcube(sx/2,sy,t,2);
        rcube(sx,sy,t,sy/2);
        
        hull(){
            rcube(8,sy,t,2);
            
            translate([0,sy/2,pd/2-.6])
            rotate([0,90,0])
            cylinder(d=pd+t*2,h=t);
        }

        // pin
        translate([0,sy/2,pd/2-.6])
        rotate([0,-90,0])
        cylinder(d=pd,h=pl);
    }
    //---------------------------------
    translate([-pl-1,0,-t*2])
    cube([sx,sy,t*2]);
}    
