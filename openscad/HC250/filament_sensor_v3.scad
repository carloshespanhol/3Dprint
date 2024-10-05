include <config.scad>
use <parts.scad>
use <../lib.scad>
$fn=100;
cl=0.5;

disc_diam = 35;
disc_height = 1.6;
thickness = 1.6;
bearing_diam=22;
bearing_height=7;
gear_diam=12;
gear_height=13;
filament=1.75;
filament_position=3;
/*****************************/
t=thickness;
bd=bearing_diam;
bh=bearing_height;
dd=disc_diam;
dh=disc_height;
gd=gear_diam;
gh=gear_height;
fp=filament_position;

/* Filament */
color("red")
translate([gh-fp, 50, gd/2])
rotate([90,0,0])
cylinder(d=filament, h=100);

/* Parts *
color("grey"){
    translate([-bh-t*2,0,0])
    rotate([0,90,0]) 608zz();

    rotate([0,90,0]) mk7_gear();

}
/* Disc *
translate([-dh-bh-t-6.8,0,0])
rotate([0,90,0]) disc(disc_diam, disc_height);

/* Sensor *
color("grey")
translate([-12,0,-bd-1])
rotate([0,0,180])
import("./stl/optical_endstop.stl");
/* bearing */
color("grey")
translate([gh-bh+.25,0,bd/2+gd/2+filament/2])
rotate([0,90,0]) 608zz();
/**/

color("cyan")
body();

idler();

module idler(){
    // pin
    color("green")
    translate([gh-bh-t*2+.5,0,bd/2+gd/2+filament/2])
    rotate([0,90,0])
    cylinder(d=8, h=bh+t*4-.5);
    /**/
    
    difference(){
        union(){
            // hinge
            hull(){
                translate([t*2-.2,0,bd/2+gd/2+filament/2])
                rotate([0,90,0])
                cylinder(d=14, h=13.5);
                
                translate([3,bd/2+5.5,bd/2+5.5])
                rotate([0,90,0])
                cylinder(d=8, h=13.5);
                /*
                translate([3, 10, bd/2+2.5])
                rcube(13.5, bd-15, 4);
                /**/
            }
            hull(){
                translate([t*2-.2,0,bd/2+gd/2+filament/2])
                rotate([0,90,0])
                cylinder(d=14, h=13.5);

                translate([3, -18, bd/2+2.5])
                rcube(13.5, bd+8, 4);
            }
            
            translate([-7, -18, bd/2+2.5])
            rcube(13.5, 8, 4);
        }
        
        // bearing
        translate([t*2+2.8,0,bd/2+gd/2+filament/2])
        rotate([0,90,0])
        cylinder(d=25, h=7.5);
        
        // screw
        translate([-bh-t*2, 0, 0])
        rotate([0,90,0])
        translate([-16.5,bd/2+5.5,bh-8])
        rotate([0,0,42])
        Mnut(0); //no sacrifice bridge

        translate([-2, -bd/2-3, 8])
        rotate([0,0,180])
        MnutPocket(30);
        
        // hole
        translate([t*2-1,0,bd/2+gd/2+filament/2])
        rotate([0,90,0])
        cylinder(d=8, h=20);

        // bottom
        s=50;
        translate([0,-s/2,-s/4+1])
        cube([s,s,s/2]);
        
    }
}
   
module body(){
    bdd=bd+18;
    bdh=bh+gh+t*5+2;
    echo("diametro: ",bdd);
    echo("largura",bdh);
    
    // sacrifice bridge
    translate([t*1.5+.1, 0, 0])
    rotate([0,90,0])
    cylinder(d=bd, h=.2);
    
    translate([-bh-t*2, 0, 0])
    rotate([0,90,0]){
        difference(){
            // hinge
            hull(){
                translate([-16.5,bd/2+5.5,bh+t+1.4])
                cylinder(d=8, h=gh+t*5-1);
                translate([-10,bd/2+1,bh+t+1.4])
                cylinder(d=8, h=gh+t*5-1);
            }
            // screw
            translate([-16.5,bd/2+5.5,bh-8])
            Mnut(0); //no sacrifice bridge

            translate([-bd, -bd/2+10, bh+t*4-.5])
            rcube(bd, bd+3, gh+1);
        }
        
    difference(){
        hull(){            
            cylinder(d=bdd, h=bdh);
            
            translate([23,-7,0])
            rotate([0,0,90])
            vrcube(14,5,16.5);
            
        }

        translate([-16.5,bd/2+5.5,bd/2+1.9])
        cylinder(d=10, h=14);
        
        /* Sensor */
        translate([25.2,-5.5,-5])
        rotate([0,0,90])
        vrcube(11,6.6,20);
        
        translate([16,0,3.1])
        rotate([-90,0,90])
        MnutPocket();
        
        // bearing fit
        translate([0,0,-.1])
        cylinder(d=bd+cl, h=bh);
        
        // innerhole
        translate([0,0,-.1])
        cylinder(d=gd+4, h=bh*3+gh+t*5);
        
        // idler
        translate([-bd-2, -bd/2, bh+t*4-.5])
        rcube(bd, bd, gh+1);
        //
        translate([-5, -bd/2-3, 8])
        rotate([0,90,180])
        MnutPocket(18);
        
        // filament
        translate([-gd/2, 50, bh+t*2+gh-fp])
        rotate([90,0,0])
        cylinder(d=4, h=100);
        
        s=50;
        //z,y,x
        /* bottom
        translate([20,-s/2,-s/4])
        cube([s/2,s,s]);
        /* top */
        translate([-38,-s/2,-s/4])
        cube([s/2,s,s]);
        /**/
    }
}
}

module disc(d,h){
    n=40;
    w=1;
    difference(){
        union(){
            cylinder(d=d, h=h);

            cylinder(d=9, h=7);
            cylinder(d=8, h=7+t*2+bh);
            cylinder(d=5, h=7+t*2+bh+gh);
        }
        
        translate([0,0,-h/2])
        for ( i = [0 : 360/n : 360] ) {
            rotate ([0,0,i])
            translate([-w/2,-d/2+1, -0])
            cube([w,4,h*2]);
        }
    }
} 