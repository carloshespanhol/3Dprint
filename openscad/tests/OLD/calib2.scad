use <../lib.scad>
$fn=100;

s=40;
h=3;
r=10;
d=h/3;

p=4;
p1=p+p*d;
dp=8;
dist=s-dp*2;

difference(){
    hull(){
        rcube(s,s,.1,r);
        
        translate([-d,-d,h])
        rcube(s+2*d,s+2*d,.1,r);
    }
    
    translate([s/2,s/2,-.1])
    cylinder(d=s/2.5, h=h*2);
    
    // Parafusos
    translate([dp,dp,-.1])
    cylinder(d1=p1, d2=p, h=h+.3);        
    translate([dp,dp+dist,-.1])
    cylinder(d1=p1, d2=p, h=h+.3);        
    translate([dp+dist,dp,-.1])
    cylinder(d1=p1, d2=p, h=h+.3);        
    translate([dp+dist,dp+dist,-.1])
    cylinder(d1=p1, d2=p, h=h+.3);        
}