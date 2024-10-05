$fn=100;
use <../lib.scad>
pressfit=0.4;
x=25;
y=25;
z=4;
a=70;

test3();

    
module test3(){
    difference(){
            translate([0,0,0])
            roundcube(x,y,z, 1);

            // axis
            translate([x/2, y/2, -.1])
            rpol(d=8+pressfit, h=z+1);
    }    
}
module test2(){
   // x2=x+x*sin(a);
   // y2=y+y*sin(a);
    y2=30;
    x2=30;
    co=z-1;
    ca=(x2-x)/2;
    echo(atan(co/ca));
    
    difference(){
        union(){
            translate([-x/2,-y/2,0])
            rcube(x,y,z/2, 1);
            translate([-x2/2,-y2/2,z])
            rcube(x2,y2,.5, 1);
            hull(){
                translate([-x/2,-y/2,0.5])
                rcube(x,y,z/2, 1);

                translate([-x2/2,-y2/2,z])
                rcube(x2,y2,.1, 1);
            }
        }

        // axis
        translate([0,0, z/2])
        rpol(d=8+pressfit, h=14);

        //
        translate([0, -y2/2, 0])
        cylinder(d=3, h=z*2);
    }    
}

module test1(){
rotate([-90,0,0])
difference(){
        translate([20,0,-10])
        vrcube(17,10,25, 1);


        // axis
        translate([20+7.5, -4-3, 0])
        rotate([-90, 0, 0])
        rpol(d=8+pressfit, h=14);
}    
}