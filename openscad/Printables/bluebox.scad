$fn=200;
t=4;
dw=11;
ds=52;
x=85;
y=ds+dw*4+t*6;
z=65;
echo(y);

*translate([0,20,0])
translate([0,55,48])
rotate([0,90,0])
mirror([0,1,0])
import("stl/box-body.stl");

%mirror([0,1,0])
//translate([0,55,48])
translate([55,1,48])
rotate([0,90,90])
mirror([0,1,0])
import("stl/box-body.stl");

difference(){
    rcube(x,y, z, 4);
    //----------------------
    // speaker
    translate([(x-dw-t)/2,t*2,z/2+t/2])
    rotate([90,0,0])
    #cylinder(d=55, h=t*3);
    
    translate([x-dw-t,-10, t])
    rcube(dw,120, z, 2);
    translate([x-dw*2-t*2-t/2,ds-t, t])
    rcube(dw+t/2,dw*4, z, 2);

    translate([t,t, t])
    rcube(x-dw-t*3,ds, z, 8);
    
    translate([t,ds+t*2, t])
    rcube(x-dw-t*3,t+dw*2, z, 8);

    translate([t,ds+dw*2+t*4, t])
    rcube(x-t*2,t+dw*2, z, 8);
}
translate([0,ds+t,0])
difference(){
    rcube(x-t-dw,y-ds-t*2-dw, z, 8);
    //------------------------------
    translate([t,t*2, t])
    rcube(dw+t/2,dw*4, z, 2);
    
    translate([t,-dw, t])
    rcube(x-dw-t*3,t+dw*2, z, 8);
    translate([t,dw+t*2, t])
    rcube(x-dw-t*3,t+dw*2, z, 8);    
}

// round edges
translate([0,ds+t,0]){
    translate([x-dw*2-t*2-t/2,t/2, 0])
    cylinder(d=t,h=z);
    translate([x-dw*2-t*2-t/2,dw*2+t*2+t/2, 0])
    cylinder(d=t,h=z);

    translate([dw+t+t/2,dw+t+t/2, 0])
    cylinder(d=t,h=z);
    translate([dw+t+t/2,dw*3+t*3+t/2, 0])
    cylinder(d=t,h=z);
}

//------------------------------------
module rcube(length,width,height,radius=.5,chamfer=0){    
    l=length-2*radius;
    w=width-2*radius;    
    difference(){
        translate([radius,radius,0])
        hull(){
            cylinder(r=radius,h=height);    
            translate([0,w,0])
            cylinder(r=radius,h=height);    
            translate([l,0,0])
            cylinder(r=radius,h=height);    
            translate([l,w,0])
            cylinder(r=radius,h=height);    
        }
        /*******************************/
        difference(){
            translate([-.1,-.1,-.1])
                cube([length+.2,width+.2,chamfer]);
            /*******************************/
            hull(){
                translate([-.1,-.1,chamfer])
                cube([length+.2,width+.2,.1]);
                translate([chamfer,chamfer-.1])
                cube([length-chamfer*2,width-chamfer*2,.1]);
            }
        }
    }
}

