u=8;
t=2;
h=u/3*2;

// base
difference(){
    cube([4*u,3*u,u/2]);

    translate([0,-.1,-u])
    rotate([0,-45,0])
    cube([u,50,u]);

    translate([4*u,-.1,-u])
    rotate([0,-45,0])
    cube([u,50,u]);
}

// upper
translate ([0,0,u/2])
difference(){
    cube([4*u,3*u,h]);

    // X
    translate([-.1,t*2,0])
    cube([5*u,3*u-4*t,h-t]);
    // Y
    translate([t*2,-.1,0])
    cube([4*u-4*t,4*u,h-t]);
    // Inner
    translate([t,t,0])
    cube([4*u-2*t,3*u-2*t,h-t]);    
}

