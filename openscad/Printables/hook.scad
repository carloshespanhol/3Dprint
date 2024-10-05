use <../lib.scad>
$fn=200;


do=60;
di=45;
t=3;
h=35;


difference(){
    intersection(){
        union(){
            cylinder(d=do, h=t);
            
            translate([0,0,h-t])
            cylinder(d=do, h=t);

            translate([0,-do/2+di/4,0])
            cylinder(d=di, h=h);
        }

        cylinder(d=do, h=h);
    }
    
    translate([0,do/3,-.1])
    cylinder(d=5, h=t+1);
}    