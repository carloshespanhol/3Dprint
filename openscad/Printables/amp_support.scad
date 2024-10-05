$fn=200;
fit=.3;
use <../lib.scad>

asdx=47; // amp screw dist x
asdy=39;

ax=54+5;
ay=46+2;
az=15;
r=4;

plate2();


module plate2(){
sdx=73.5;
sdy=61.5;
x=107;
y=71;
z=4;
t=3;
rx=ax+t*2;
ry=ay+t*2;
rz=az+t;

    difference(){
        union(){
            translate([0,0,0])
            rcube(x,y,z,r);
            
            translate([x/2-rx/2, y/2-ry/2, z-rz])
            rcube(rx,ry,rz,r);
        }
        //---------------------------------
        translate([x/2-sdx/2,y/2-sdy/2,0])
        for( i = [0:1] ){
            for( j = [0:1] ){
                translate([i*sdx, j*sdy, -.1])
                cylinder(h=z+1,d=4.5);
            }
        }
        
        translate([x/2-ax/2, y/2-ay/2, z-az+.1])
        rcube(ax,ay,az,1);
        // board screw
        translate([x/2-asdx/2,y/2-asdy/2,z-az-t])
        for( i = [0:1] ){
            for( j = [0:1] ){
                translate([i*asdx, j*asdy, -.2])
                cylinder(h=t,d=2.5);
            }
        }
        
        // wire pass
        translate([x/2-ax/2, y/2, -5])
        rcube(8,y,az,1);
        translate([x/2+ax/2-20, -5, z-1.5])
        rcube(20,y/2,z,1);
    }    
}
module plate1(){
sdx=70;
sdy=24;
x=80;
y=47;
z=8;
    difference(){
        translate([0,0,0])
        rcube(x,y,z,r);
        
        //---------------------------------
        translate([x/2-45/2,y/2-10,-.1])
        cube([45,20,6]);
        
        translate([x/2-asdx/2,y/2-asdy/2,0])
        for( i = [0:1] ){
            for( j = [0:1] ){
                translate([i*asdx, j*asdy, -.1])
                cylinder(h=z+1,d=3);
            }
        }

        translate([x/2-sdx/2,y/2-sdy/2,0])
        for( i = [0:1] ){
            for( j = [0:1] ){
                translate([i*sdx, j*sdy, -.1])
                cylinder(h=z+1,d=4);
            }
        }
    }    
}