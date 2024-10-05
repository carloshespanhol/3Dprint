use <../lib.scad>
$fn=200;
dp=2.2;
d=3.01;
w=21;
*import("/home/hespanhol/3D Print/stl_files/Logitech_K235_keyboard_feet.stl");

// Pins
translate([w,-1,1.5])
rotate([0,90,0])
cylinder(d=dp, h=2);

translate([-2,-1,1.5])
rotate([0,90,0])
cylinder(d=dp, h=2);


difference(){
    hull(){
        translate([0,-.5,1.5])
        rotate([0,90,0])
        cylinder(d=d, h=w);
    
        translate([0,-26,0])
        cube([w,10,3]);
    }
    //---------------------
    translate([-1,-26.36,0])
    rotate([52.5,0,0])
    cube([w+2,5,2]);

    translate([(w-17)/2,-18,2])
    cube([17,21,3]);

    translate([(w-12)/2,-15,-.1])
    rcube(2,21,5,1);
    translate([(w-12)/2+10,-15,-.1])
    rcube(2,21,5,1);
}