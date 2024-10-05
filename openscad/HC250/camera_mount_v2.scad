// Raspberry Pi mount
use <../lib.scad>
$fn=100;


width=54;
t=4;

flat_w=17;
flat_t=2;
cam_w=26;
cam_l=28;
cam_t=8;
cam_h=50;



//translate([-17, cam_t, cam_h-cam_l/2-2]) rotate([0,-90,90]) 
camera();

//camera_support();

module camera(){    
    thick=1.5;
    mid=cam_l/2+thick;

    difference(){
        union(){
            cube([cam_l+thick*2,cam_w+thick*2,cam_t+thick*2]);
            
            hull(){
               translate([8,0,0])
                cube([cam_l+thick*2-16,.1,cam_t+thick*2]);
                
               translate([cam_l/2+thick-5,-5,0])
                cube([cam_t,.1,cam_t]);
            }
        }
        
        translate([cam_l/2+thick,-.5,cam_t/2])
        rotate([90,0,0])
        MnutPocket(show_screw=1);
        
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
    difference() {    
        union(){
            hull(){
                cylinder (d=20, h=t);
                
                translate([-10,1,0])
                cube([3,8,t]);
            }
            
            translate([-10,1,0])
            cube([3,8,cam_h]);

            translate([-10,5,cam_h])
            rotate([0,90,0])
            cylinder (d=8, h=3);
        }
        
        translate([0,0,-.1])
        cylinder (d=5.5, h=t*3);
        
        // Screw
        translate([-15,5,cam_h])
        rotate([0,90,0])
        cylinder (d=3.5, h=20);
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
