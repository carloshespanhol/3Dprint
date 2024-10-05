$fn=200;

s=9;
is=3.5;
t=.75;

difference(){
    cylinder(d=s, h=t);
    
    translate([0,0,-.1])
    cylinder(d=is, h=t*2);
}    