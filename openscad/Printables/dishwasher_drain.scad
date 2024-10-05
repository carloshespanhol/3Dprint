use <../lib.scad>
$fn=200;

dfoot=38;
dist=135;
di=22;
t=3.6;
l=dist+dfoot/2+di/2;



difference(){
    union(){
        hull(){
            cylinder(d=di+t*2, h=t);
            
            translate([0,l,0])   
            cylinder(d=dfoot+t*2, h=t);
        }
    
        translate([0,l,0])   
        cylinder(d=dfoot+t*2, h=t*2);    
    }

    translate([0,0,-.1])
    cylinder(d=di, h=t+1);

    translate([0,l,2])
    cylinder(d=dfoot, h=t*3);

}