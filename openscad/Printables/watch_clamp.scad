$fn=128;

thick=3;
width=18;
size=15;
depth=10;

rotate([90,0,0])
clamp();

module clamp(){
    union(){
        cube([width+thick,size,thick]);

        cube([thick,size,depth+thick]);
        translate([width+thick,0,0])
        cube([thick,size,depth+thick]);
    }

    d=thick*1.3;
    translate([d/2,size,depth])
    rotate([90,0,0])
    cylinder(h=size, d=d);
}