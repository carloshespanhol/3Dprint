// Raspberry Pi mount
use <../lib.scad>
$fn=100;

// pin dist 49 and 58
len=85;
width=54;
thick=4;
pin=2.8;
pin_height=12;
space=3;
sphere_radius=6;
tol=-0.5;  // tolerance


//base();
//translate([20,width,0]) washer();
translate([50,0,0]) 
rotate([0,0,90]) 
camera();
//translate([30,width,6])
translate([0,5,0]) 
rotate([0,0,90]) 
camera_support();

module camera(){
/*
    #translate([14,55,5.1])
    rotate([0,-90,0])
    mirror([0,1,0])
    import("C:/Users/carlos.hespanhol/Desktop/Desktop/abc/OpenSCAD/hevo250/stl/raspi_camera_holder.stl");
*/
    flat_w=17;
    flat_t=2;
    thick=1.5;
    cam_w=26;
    cam_l=28;
    cam_t=8;
    mid=cam_l/2+thick;
    echo(sphere_radius);
    
    
    translate([(cam_l/2 +thick),thick,cam_t+thick-.3])
    cube([2,cam_w,thick]);
    /* bridge horizontal *
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
    /**********************************/
    difference(){
        union(){
            cube([cam_l+thick*2,cam_w+thick*2,cam_t+thick*2]);
            
            hull(){
               translate([5,0,0])
                cube([cam_l+thick*2-10,.1,cam_t+thick*2]);
                
               translate([cam_l/2+thick-7,-9,0])
                cube([14,.1,cam_t+thick*2]);
            }
        }
        
        translate([cam_l/2+thick-5,-15,-.1])
        cube([10,15,cam_t+thick*2+1]);
    
        // sphere
        translate([mid, -5, (cam_t+thick*2)/2])
        sphere(sphere_radius+tol);
        //camera slot
        translate([thick,thick,thick])
        cube([100,cam_w,cam_t]);
        // lens slot
        translate([cam_w/2,(cam_w-4)/2,-0.01])
        oblong(28,8,3);
        // flat slot
        translate([-0.01,(cam_w-flat_w)/2, cam_t/2+thick+1])
        cube([26,20,flat_t]);
    }
}
module camera_support(){
    translate([0,0,15+sphere_radius-1])
    sphere(sphere_radius);
    
    cylinder(r1=sphere_radius,r2=sphere_radius-2,h=15+sphere_radius);
        
    difference() {    
        translate([-sphere_radius,-10,0]) 
        rcube (30,20,thick,1);
        
        translate([15,0,-0.1]) 
        cylinder (d=5.5, h=thick*3);
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
