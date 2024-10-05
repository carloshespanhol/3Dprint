use <../lib.scad>
$fn=200;

thick=0.4;
h=10;
//d=97; 
d=168;
//172; // diametro interno


difference(){
    cylinder(d=d+6,h=h);
    
    translate([0,0,thick])
    cylinder(r1=d/2+1.5,r2=d/2,h=h);
}    