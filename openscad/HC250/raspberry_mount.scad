// Raspberry Pi mount
use <../sc.scad>
use <../lib.scad>
use <../honeycomb.scad>
$fn=64;

// pin dist 49 and 58
len=85;
width=54;
thick=4;
pin=2.8;
pin_height=12;
space=3;
sphere_radius=5.5;
t=0;  // tolerance


//base();
//translate([20,width,0]) washer();
//translate([100,0,0]) camera();
//translate([30,width,6]) rotate([180,0,0]) camera_support();
pi_support();

module pi_support(){
x=70;
y=30;
t=5;
pos=20;

    rcube(x,y,t,2);
    rcube(x/2,y,t);

    Tx(pos)
    Ry(-90)
    rcube(20,y,t,2);
    
    T(pos-t,0,t)
    Mx()
    fillet(10,y);
    
    Tz(t)
    Ry(180-45)
    rcube(20,y,t);
    
}

module camera(){
/*
    #translate([14,55,5.1])
    rotate([0,-90,0])
    mirror([0,1,0])
    import("C:/Users/carlos.hespanhol/Desktop/Desktop/abc/OpenSCAD/hevo250/stl/raspi_camera_holder.stl");
*/
    flat_w=17;
    flat_t=2;
    thick=2;
    cam_w=26;
    cam_l=28;
    cam_t=10;
    mid=cam_l/2+thick;
    echo(sphere_radius);
    
    
    /* bridge horizontal */
    translate([(cam_l +thick*2)- 2,thick,cam_t+thick- .5])
    cube([2,cam_w,thick]);
    translate([cam_l/3+thick,thick,cam_t+thick- .5])
    cube([1,cam_w,thick]);
    translate([cam_l/3*2+thick,thick,cam_t+thick- .5])
    cube([1,cam_w,thick]);
    /* bridge vertical *
    translate([thick,cam_w/3+thick,cam_t+thick-.5])
    cube([cam_l+thick,1,thick]);
    translate([thick,cam_w/3*2+thick,cam_t+thick- .5])
    cube([cam_l+thick,1,thick]);
    /**/
    difference(){
        union(){
            cube([cam_l+thick*2,cam_w+thick*2,cam_t+thick*2]);
            
            translate([mid-4,cam_l,0])
            rotate([0,0,90])
            rtriangle(12,10,cam_t,30);
            
            translate([mid+4,cam_l,0])
            mirror([1,0,0])
            rotate([0,0,90])
            rtriangle(12,10,cam_t,30);            
        }

        // sphere
        translate([mid,cam_w+thick+7,sphere_radius-1])
        sphere(sphere_radius-t);
        //camera slot
        translate([thick,thick,thick])
        cube([100,cam_w,cam_t]);
        // lens slot
        translate([cam_w/2,(cam_w-4)/2,-0.01])
        oblong(28,8,3);
        // flat slot
        translate([-0.01,(cam_w-flat_w)/2,(cam_t-flat_t)/2+thick*2])
        cube([26,20,flat_t]);
    }
}
module camera_support(){
    translate([100,-28,0])
    sphere(sphere_radius);
    
    translate([97.5,-33,-thick*.5]) cube ([5,22.5,thick*2]);
    
    difference() {    
        translate([72,-20.5,0]) cube ([30.5,10,thick*1.5]);

        translate([75,-30.1,-0.1]) cube ([10,22,thick]);
        
        translate([80,-15.5,-0.1]) cylinder (d=3.5, h=thick*3);
    }
}
module washer(){
    for(i=[0:3]){
    difference(){
        translate([2.5+i*10,40,0])cylinder(d=6,h=2.5);
        translate([2.5+i*10,40,-0.1])cylinder(d=pin,h=pin_height+4);
    }
    }
}
module base(){
    // Body    
    difference() {
        union(){
            cube ([len,width,pin_height-space]);
                        
            translate([63,50,0])
            rotate([0,0,-45])
            cube ([6,22,thick]);
            
            translate([0,52,0])
            rotate([0,0,-45])
            cube ([6,22,thick]);
            
            translate([75,-8,0]) 
            rotate([0,0,45])
            cube ([10,20,thick]);

        }
        translate([thick,thick,-0.1]) cube ([len-thick*2,width-thick*2,pin_height]);
    }

    // Honeycomb fill
    linear_extrude(2) {
        honeycomb(len, width, 6, 1);
    }

    // Pins
    ph=6;
    translate([82.5,51.5,0])cylinder(d=5,h=pin_height);
    translate([82.5,2.5,0])cylinder(d=5,h=pin_height);

    translate([2.5,2.5,0])cylinder(d=5,h=pin_height-1);
    translate([2.5,2.5,0])cylinder(d=pin,h=pin_height+ph);
    translate([2.5,2.5,pin_height-1])cylinder(d2=pin,d1=5,h=2);
       
    translate([2.5,51.5,0])cylinder(d=5,h=pin_height-1);
    translate([2.5,51.5,0])cylinder(d=pin,h=pin_height+ph);
    translate([2.5,51.5,pin_height-1])cylinder(d2=pin,d1=5,h=2);

    translate([60.5,2.5,0])cylinder(d=5,h=pin_height-1);
    translate([60.5,2.5,0])cylinder(d=pin,h=pin_height+ph);
    translate([60.5,2.5,pin_height-1])cylinder(d2=pin,d1=5,h=2);
     
    translate([60.5,51.5,0])cylinder(d=5,h=pin_height-1);
    translate([60.5,51.5,0])cylinder(d=pin,h=pin_height+ph);
    translate([60.5,51.5,pin_height-1])cylinder(d2=pin,d1=5,h=2);


    // Supports
    difference() {    
        translate([75,-20,0]) cube ([10,20,thick]);
        translate([80,-15,-0.1]) cylinder (d=3.5, h=thick+1);
    }
    difference() {
        translate([75,54,0]) cube ([10,25,thick]);
        translate([80,71,-0.1]) cylinder (d=5.7, h=thick+1);
    }
    difference() {
        translate([10,54,0]) cube ([10,25,thick]);
        translate([15,71,-0.1]) cylinder (d=5.7, h=thick+1);
    }
}