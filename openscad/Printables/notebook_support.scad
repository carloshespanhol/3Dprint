use <../lib.scad>
$fn=200;

w=200;
l=120;
h=12;
t=6;
pa=21;
d=5;

difference(){
    union(){
        roundCube(w,l,h,5);
    }

    translate([pa+t*2,h+t,-.1])
    roundCube(w,l-pa-h-t*3,h+1,5);
    
    // Profile
    translate([t,l-t-pa,t/2])
    nccube(pa,pa,pa*2);
    translate([w-t-pa,l-t-pa,t/2])
    nccube(pa,pa,pa*2);
    
    // Holes
    translate([t+pa/2,l-t-pa/2,-.1])
    zcylinder(d=d,h=h);
    translate([w-t-pa/2,l-t-pa/2,-.1])
    zcylinder(d=d,h=h);
}    
