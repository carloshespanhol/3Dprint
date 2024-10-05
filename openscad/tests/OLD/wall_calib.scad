use <../lib.scad>
$fn=200;

lw=0.44;

s=40;
h=10;
d=s-12;

difference(){
    scube(s,s,h);

    translate([s/2,s/2,-.1])
    cylinder(d=d, h=s+1);
    
    translate([s/2-d/2,-1,-.1])
    scube(d/4*3,s/2+1,s+1);
    // holes
    translate([-1,1.5,h/4-h/12])
    scube(s+2,4,h/6);    
    // top
    translate([-lw*4,-d/4,h/2])
    scube(s,s*2,h);    
}    