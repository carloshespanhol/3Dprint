use <../../lib.scad>
$fn=100;
s=40;
l=2;
r=2;
is=30;

p=8.5;
ir=60;
t=5;
h=19;


difference(){
    union(){
        translate([-ir/2-25,-10,0])
        rcube(ir+50,20,t,r);
        
        translate([0,0,-.1])
        cylinder(d=ir+t, h=h);
    }
    //---------------------------
    
    // Screws
    translate([-ir/2-25/2,0,-.1])
    cylinder(d=5.5, h=h);
    translate([ir/2+25/2,0,-.1])
    cylinder(d=5.5, h=h);

    // inner
    translate([0,0,t])
    cylinder(d=ir, h=h);
    translate([0,0,-1])
    cylinder(d=ir/2, h=h);
    //
    translate([0,0,11+t+p/2])
    rotate([-90,0,0])
    cylinder(d=p, h=ir);
    translate([0,0,10.5+t+p/2])
    rotate([90,0,0])
    cylinder(d=12, h=ir);

    // rod
    translate([-8,-ir,-1])
    rotate([-90,0,0])
    cylinder(d=9, h=ir*2, $fn=6);
    
}