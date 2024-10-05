use <../lib.scad>
$fn=64;

clereance=0.5;
size=15;
hole=10;
heigth=5;

difference(){
    rccube(size,size,heigth,.5);

    translate([0,0,-.1])
    cylinder(d=hole, h=heigth+1);
}

cylinder(d=hole-clereance, h=heigth);

translate([0,0,heigth])
rccube(2,hole-1,2,.5,0);