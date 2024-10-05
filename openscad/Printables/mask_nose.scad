use <../lib.scad>
$fn=200;

uw= 44;
lw=54;
uh=1;
lh=10;
sh=100;
nd=20;
t=2.5;

difference(){
    union(){
        hull(){
            translate([0,nd,0])
            rotate([90,0,0])
            cylinder(d=uw, h=1);

            rotate([90,0,0])
            cylinder(d=lw, h=1);
        }

        translate([0,-8,-(sh/2-lh/2)/2])
        rotate([90,0,0])
        cylinder(d=sh, h=t);

        translate([-2,-8,lw/2-t])
        cube([4,8,t]);
    }

    // Inner
    hull(){
        translate([0,nd+.1,0])
        rotate([90,0,0])
        cylinder(d=uw-t*2, h=1);

        translate([0,-.1,0])
        rotate([90,0,0])
        cylinder(d=lw-t*2, h=1);
    }

    // Cut Bottom
    translate([-sh,-sh/2,-sh])
    cube([sh*2,sh,sh]);
}
