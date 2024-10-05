use <../../lib.scad>
$fn=100;
s=40;
h=5;
l=2;
r=5;
is=30;

difference(){
    union(){
        translate([-s/2,-s/2,0])
        rcube(s,s,h,r);
        
    }
    //---------------------------
    
        translate([-is/2,-l/2,-.1])
        scube(is,l,h+1);
        translate([-l/2, -is/2,-.1])
        scube(l,is,h+1);
    
        translate([0,0,-.1])
        cylinder(d=is-l, h=h+1);
}