$fn=100;

d=5;
w=40;
l=30;
bt=0.6; // blade thickness
bi=5;
t=0.6;

difference(){
    hull(){
        cylinder(d=d, h=w);
        
        translate([l,-t-bt/2,0])
        cube([.1,t*2+bt,w]);
    }

    translate([l-bi,-bt/2,-.1])
    cube([bi*2,bt,w+1]);
}

%    translate([l-bi,-bt/2,0])
    cube([12,bt,w]);
