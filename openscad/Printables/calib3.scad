use <../lib.scad>
$fn=200;

s=20;
h=4;
r=7;
d=h/3;

p=4;
p1=p+p*d;
dp=8;
dist=s-dp*2;

// Bridge
translate([s/2,s/2,h-.8])
cylinder(d=s/2, h=.2);

difference(){
    union(){
        translate([s/2,s/16,0])
        cylinder(d=s/2, h=h);

        hull(){
            rcube(s,s,.1,r);
            
            translate([-d,-d,h-.1])
            rcube(s+2*d,s+2*d,.1,r);
        }
    }

    translate([s/2,s/2,-.1])
    cylinder(d=s/2, h=h*2);
    /*  
    translate([s/2,s/16,-.1])
    cylinder(d=s/2+.1, h=h/2);
    /**/
}