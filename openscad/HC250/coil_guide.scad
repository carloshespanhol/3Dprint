$fn=100;
cl=0.25;
height=5;
diam=7.9+cl; // diametro interno
thick=1;
m3=3.6+cl;

difference(){
    cylinder(h=height, d=diam+thick*2);
    
    translate([0,0,thick])
    cylinder(h=height, d=diam);
    // M3 screw
    translate([0,0,-0.1])
    cylinder(h=height, d=m3);    
}    