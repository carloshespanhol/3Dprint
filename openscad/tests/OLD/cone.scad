$fn=100;

base=10;
height=15;

// Base
bs=base;
translate([-bs/2,-bs/2,0])
cube([bs,bs,0.4]);

// Cone
cylinder(r1=3, r2=0, h=height);