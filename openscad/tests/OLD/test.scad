use <../lib.scad>;
$fn=100;
s=5;
q=10;
h=s*3;

m=[
[0,0,1,1,1,0,1,0,1,1],
[0,1,1,0,0,0,0,0,0,0],
[1,0,0,0,1,0,1,1,1,1],
[1,0,0,0,1,0,1,0,0,1],
[1,1,0,0,1,0,1,1,1,0]
];

translate([0,0,.9]){
// Base
translate([0,0,-.9])
cube([s*q,s*q/2,1]);

difference(){
    for(i=[0:4]){
        for(j=[0:q]){
            if(m[i][j]){
                translate([j*s, (q/2*s)-(i*s)-s, 0])
                cube([s,s,h]);
            }
        }
    }    
    
    hull(){
        translate([7*s,-.01,0])
        cube([2*s,s+.01,.01]);
        translate([9*s,0,1])
        cube([.01,s+.01,2*s]);
    }
    
    // Hole
    translate([s*2,s*2,h/2])
    rotate([0,0,-90])
    vcylinder(d=s, h=h);
}
// Cone
translate([s*3, s*2, 0])
cylinder(d1=s, d2=1.2, h=h);
// Cilindro
translate([s/2, s*4+s/2, 0])
cylinder(d=s, h=h);
translate([s*8, s*4+s/2, 0])
cylinder(d=s, h=h);
// Bridge
translate([0,0,h-2])
cube([8*s,s,2]);
}
