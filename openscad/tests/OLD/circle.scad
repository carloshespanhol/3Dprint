$fn=200;

s=100;
lw=0.8;

difference(){
    cylinder(d=s, h=3); 
 
    translate([0,0,-.1])
    cylinder(d=s-lw*2, h=6);
}    