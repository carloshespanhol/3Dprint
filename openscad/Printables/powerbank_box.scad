$fn=200;
use <../lib.scad>

/*teste
ix=20;
iy=20;
ih=12;
z=5;
r=1;
bl=16;
vh=6;
/**/
fit=.3;
lw=0.88;
t=lw*2;

ix=105;
iy=74;
ih=32;
z=23+t;
r=2;
bl=60;    // board length
vh=8;     // voltimeter height

x=ix+t*2;
y=iy+t*2;
h=ih+t*2;

//Bottom
*difference(){
    union(){
        translate([0,0,r])
        mirror([0,0,1])
        round_plane(x,y,r);
        translate([0,0,r])
        rcube(x,y,z-r,r);
    }
    
    translate([t,t,t])
    rcube(x-t*2,y-t*2,h,r-t);
}    

// Top
difference(){
    union(){
        translate([0,0,h-r])
        round_plane(x,y,r);
        translate([0,0,z])
        rcube(x,y,h-z-r,r);

        translate([t+fit/2,t+fit/2,z-t])
        rcube(x-t*2-fit,y-t*2-fit,h-z,r);
    }
    
    translate([t*2,t*2,t])
    rcube(bl,y-t*4,ih-r,r);
    
    translate([bl+t*4,t*2,t])
    rcube(ix-bl-t*4,y-t*4,h-vh,r);
    
    // connector cut
    ycp=5+t+fit;
    ycs=10+fit;
    zcs=6+t+fit;
    translate([-.1,ycp,z-t-.1])
    cube([t*3,ycs,zcs]);
    // wire cut
    ywp=50+t;
    wd=4.5+fit;
    translate([-.1,ywp,z-t-.1])
    cube([10,wd,wd/2+t]);
    translate([-.1,ywp+wd/2,z+wd/2-.1])
    rotate([0,90,0])
    cylinder(d=wd,h=10);
    // voltimeter cut
    vxs=20+fit;
    vys=31.3+fit;
    translate([bl+15,(y-vys)/2, 1])
    cube([vxs,vys,h]);
}