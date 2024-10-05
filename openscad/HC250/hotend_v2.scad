use <parts.scad>
use <../lib.scad>
include <config.scad>
include <x_carriage_v9.scad>
include <part_duct_v2.scad>

$fn=100;

line_width = 0.56;

vpos=5;     //Hotend Vertical Position
bhl  = 20;//18;     // Blower hole length
bhw = 15.8;//13;   // Blower hole width 

ad = axis_distance;


/**/
hotend();

/**
translate([41.5,-45,-5]) 
rotate([0,45,-90])      
%blower();
/**
translate([8.5,0,0])
part_duct();


/* Clamp */
translate([9, 0, 13])
//rotate([-90,0,180])
rotate([0,0,-90])
E3Dclamp();

/**
X_Carriage();

/* E3d V6 */
translate([3,0,6])
            color("silver")
            translate([6, 0, 23]) 
            rotate([0,180,0])
            e3d_volcano();

color("blue")
translate([-20, -15, -17])
scube(10,30,30);
/*----------------------------------*/
module hotend(){
    difference(){
        union(){
            //cable holder
            translate([-car_width/2+11, ad/2-3, 9])
            difference(){
                rotate([0,0,90])
                vrcube(8,6,19,2);
                
                translate([5,4,15])
                rotate([0,-90,0])
                cylinder(d=3.2, 15);
                translate([5,4,8])
                rotate([0,-90,0])
                cylinder(d=3.2, 15);
            }
            
            // reinforce
            hull(){                
                translate([19.8,9,23.9])
                rotate([90,0,0])
                cylinder(d=1.25,h=18);
                
                translate([17,-9,12.5])
                cube([16,18,.1]);
            }
            
            // blower support
            difference(){
                hull(){
                    translate([-5, -ad/2-4, 18])
                    rotate([0,90,0])
                    cylinder(d=10, h=28);

                    translate([-5, -ad/2, 10])
                    rotate([0,90,0])
                    cylinder(d=10, h=28);
                }
                /************************/
                translate([1.25,-45,-5])            cube([15.5,30,30]);
            }
            
            // front
            translate([-car_width/2+5, -ad/2, 6.5])
            rotate([0,90,0])
            cylinder(d=16, h=car_width-10);
            
            // back
            translate([-car_width/2+5, ad/2, 6.5])
            rotate([0,90,0])
            cylinder(d=16, h=car_width-10);
            
            // left
            hull(){
                // front
                translate([-car_width/2+5, -ad/2+2.5, 6.5])
                rotate([0,90,0])
                cylinder(d=16.5, h=6);
                // back
                translate([-car_width/2+5, ad/2-2.5, 6.5])
                rotate([0,90,0])
                cylinder(d=16.5, h=6);
            }

            // right
            hull(){
                // front
                translate([car_width/2-5-6, -ad/2+2.5, 6.5])
                rotate([0,90,0])
                cylinder(d=16.5, h=6);
                // back
                translate([car_width/2-5-6, ad/2-2.5, 6.5])
                rotate([0,90,0])
                cylinder(d=16.5, h=6);
            }

            /* sacrifice bridge
            translate([11, -ad/2, 12])
            scube(9, ad, .2);
            /**/
            color("orange")
            translate([9, 0, 13])
            rotate([0,0,-90])
            difference(){
                translate([0,2,0])
                hull(){
                    translate([-ad/2, 0, 0])
                    rotate([-90,0,0])
                    cylinder(d=2, h=9);
                    translate([ad/2, 0, 0])
                    rotate([-90,0,0])
                    cylinder(d=2, h=9);

                    translate([-ad/4-2, 0,10.5])
                    rotate([-90,0,0])
                    cylinder(d=2, h=9);
                    translate([ad/4+2, 0, 10.5])
                    rotate([-90,0,0])
                    cylinder(d=2, h=9);
                }
                
                E3Dholes(1);
            }
        }

        /*******************************/
        
            translate([9, 0, 13])
            rotate([0,0,-90])
                        E3Dholes(1);

        // front reccess
        hull(){
            translate([-car_width/2, -ad/2-3.5, 8.5])
            scube(car_width, 7, .2);
            translate([-car_width/2, -ad/2-7, 8.5-3.5])
            scube(car_width, 14, .2);
        }
        // back reccess
        hull(){
            translate([-car_width/2, ad/2-3.5, 8.5])
            scube(car_width, 7, .2);
            translate([-car_width/2, ad/2-7, 8.5-3.5])
            scube(car_width, 14, .2);
        }
        
        // Blower support  fixing
        translate([22, -ad/2-4, 18])
        rotate([0,90,0]){
            Mscrew(28);
            translate([0,0,-37.5])
            Mnut();
        }
        
        /* Carriage */
        X_Carriage(tol*2);

        translate([-car_width/2-9,-ad/4-2, car_width/3])
        rotate([0,60,0])
        cube([car_width, ad/2+4, 5]);

        mirror([1,0,0])
        translate([-car_width/2-9,-ad/4-2, car_width/3])
        rotate([0,60,0])
        cube([car_width, ad/2+4, 5]);
        /**/
        translate([-car_width/2,-ad, -15])
        cube([car_width, ad*2, 20]);
        
        belt_support(tol);
        mirror([1,0,0])
        belt_support(tol);
               
        /* X Bushing */
        translate([-car_width/2-.2,-27.5,0]) 
        rotate([0, 90, 0]) 
        cylinder(h=car_width+1,d=bush_width+1);        
        translate([-car_width/2-.2,27.5,0]) 
        rotate([0, 90, 0]) 
        cylinder(h=car_width+1,d=bush_width+1);
        /**/
    }
}


module E3Dclamp(nut=0){  
    w=12;
    difference(){
        union(){
            translate([0,1,0])
            rotate([0,0,-90])
            hull(){
                translate([0,-ad/4, 0])
                rotate([0,90,0])
                cylinder(d=2, h=w);
                translate([0,-ad/4-2, 5])
                rotate([0,90,0])
                cylinder(d=2, h=w);
                translate([0,-ad/4-2, 10.5])
                rotate([0,90,0])
                cylinder(d=2, h=w);

                translate([0,ad/4, 0])
                rotate([0,90,0])
                cylinder(d=2, h=w);
                translate([0,ad/4+2, 5])
                rotate([0,90,0])
                cylinder(d=2, h=w);
                translate([0,ad/4+2, 10.5])
                rotate([0,90,0])
                cylinder(d=2, h=w);
            }
        }

        /*******************************/
        E3Dholes(0);
        
    }    
}

module E3Dholes(nut=0){      
    di=12;
    do=16;
    hi=5.5;
    ho=4;
        
    if(nut==1){
        /* Mounting */
        translate([0, 0, -ho/2]) 
        cylinder(d=do, h=ho);
        translate([0, 0, ho/2+.2]) 
        cylinder(d=di, h=hi);
        translate([0, 0, ho/2+hi]) 
        cylinder(d=do, h=ho+1);

        /* Nuts */
        translate([-11, 5, ho/2+hi/2]) 
        rotate([-90,180,0]) 
        MnutPocket(40);
        translate([11, 5, ho/2+hi/2]) 
        rotate([-90,180,0]) 
        MnutPocket(40);
    }else{
        /* Chamfer */
        translate([-25,-16,0])
        rotate([45,0,0])
        cube([50,25,10]);
        
        /* Mounting clip */
        translate([0, 0, -ho/2]) {
            cylinder(d=do, h=ho);
            translate([-do/2, 0, 0])
            cube([do, do, ho]);
        }
        
        translate([0, 0, ho/2-.1]){ 
            cylinder(d=di, h=hi*2); 
            translate([-di/2, 0, 0])
            cube([di, di, hi+1]);
        }
        
        translate([0, 0, ho/2+hi]){ 
            cylinder(d=do+1, h=ho+1);
            translate([-do/2-.5, 0, 0])
            cube([do+1, do, ho+1]);
        }

        /* Screws */
        translate([-11, -5, ho/2+hi/2]) 
        rotate([-90,0,180]) 
        Mscrew(18);
        translate([11, -5, ho/2+hi/2]) 
        rotate([-90,0,180]) 
        Mscrew(18);
    }
}
