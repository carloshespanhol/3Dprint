include <config.scad>
use <parts.scad>
use <../lib.scad>
$fn=100;
cl=0.5;

disc_diam = 23;
disc_height = 1.6;
thickness = 1.6;
bearing_diam=22;
bearing_height=7;
gear_diam=12;
gear_height=13;
filament=1.75;
/*****************************/
t=thickness;
bd=bearing_diam;
bh=bearing_height;
dd=disc_diam;
dh=disc_height;
gd=gear_diam;
gh=gear_height;

/* Idler */
difference(){
    union(){
        translate([gh-bh-t*1.5,0,bd/2+gd/2+filament/2])
        rotate([0,90,0])
        cylinder(d=bd, h=2);

        translate([gh+t*.5,0,bd/2+gd/2+filament/2])
        rotate([0,90,0])
        cylinder(d=bd, h=2);
    }
    
}

// bearing
color("grey")
translate([gh-bh,0,bd/2+gd/2+filament/2])
rotate([0,90,0]) 608zz();
// pin
translate([gh-bh-t*2,0,bd/2+gd/2+filament/2])
rotate([0,90,0])
cylinder(d=8, h=bh+t*4);
    
/* Parts */
color("grey"){
    translate([-bh-t,0,0])
    rotate([0,90,0]) 608zz();

    rotate([0,90,0]) mk7_gear();

    translate([t+gh,0,0])
    rotate([0,90,0]) 608zz();
}
/* Disc */
translate([-dh-bh-t-6.3,0,0])
rotate([0,90,0]) disc(disc_diam, disc_height);

/* Sensor *
%translate([-11.5,0,-bd+5])
rotate([0,0,180])
import("./stl/optical_endstop.stl");
/**/
body();

module body(){
    bdd=bd+11;
    bdh=bh*2+gh+t*4;
    echo(bdd);
    echo(bdh);
    
    translate([-bh-t*2, 0, 0])
    rotate([0,90,0])
    difference(){
        union(){
            cylinder(d=bdd, h=bdh);
        }
        
        /* Sensor */
        translate([17,0,-1])
        rotate([0,90,180])
        import("./stl/optical_endstop.stl");
        
        // bearing fit
        translate([0,0,t])
        cylinder(d=bd+cl, h=bh*2+gh+t*2);
        
        // innerhole
        translate([0,0,-.1])
        cylinder(d=bd-4, h=bh*3+gh+t*5);
            
        translate([0,0,bh+t*2])
        cylinder(d=bd-1, h=gh+t);

        translate([0, 0, bh+t])
        cylinder(d=bd+cl*2, h=gh+t*2);

       // translate([-dd/2, -bd/2-cl, bh+t*2+(gh-bh)-t+1])
        //rcube(dd/2, bd+cl*2, bh+t);
        translate([-bd, -bd/2-cl, bh+t])
        rcube(bd, bd+cl*2, gh+bh+dh+.5);
    }
}

module disc(d,h){
    difference(){
        union(){
            cylinder(d=d, h=h);
        }
        translate([0,0,-.1])
        cylinder(d=5, h=h+1);
    }
} 