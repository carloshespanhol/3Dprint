include <config.scad>
use <parts.scad>
use <part_duct_v5.scad>
use <../lib.scad>
$fs=0.2;
t=thick;
tm=thick_min+.5;
w=car_width;
bt=belt_thick;
bs=belt_size;
bd=belt_distance;
bw=bush_width;
/*
difference(){
    union(){
        translate([3,-38,4.5])
        mirror([0,1,0])
        end();
    }
    
    // cut bottom
    translate([-50,-50,-100])
    cube([100,100,67.5]);
    // Cut hotend 
    translate([-10, -55, -40])
    cube([20,30,20]);
}

/**
#translate([-50,-100,-36])
cube([100,100,5]);
/**/

translate([30,-55,-13])
rotate([0,0,60]){
    rotate([-68,0,180])
    blower();
    /* Flow */
    translate([-6,-20,-12.5])
    rotate([-22,0,0])
    #cube([ 13, 65, 18]);
    /**/
}


module blower4010(){
    color("silver")
    translate([0,-20,40])     
    rotate([0,90,0])
    rotate([180,0,90])
import("/home/hespanhol/OneDrive/openscad/HC235/stl/4010.stl");
}
module blower4020(){
    color("silver")
    translate([-10,5,20.5])     
    rotate([0,90,0])
    rotate([0,0,90])
    import("/home/hespanhol/OneDrive/openscad/HC235/stl/FAN_BLOWER_4020.stl");
}

module blower(){
    
    color("grey")
    translate([-8.5,-5,25.5])
    rotate([90,0,90])
    cylinder(d=40, h=.5);
    
    color("silver")
    translate([-33,-0,0])
    rotate([0,0,90])
    import("stl/50_mm_blower_fan_placeholder.stl"); 
}


/*
part_fan2();

translate([-20,-dax-6, 45])
rotate([-30,0,0])
fan_4020();
/**/

voron_xcarriage();
translate([0,-dax-13/2-15.5,2]){
    hotend_base();
    hotend_fan();
    hotend_e3d(1);
}
//translate([-20,-20,-37]) scube(40,40,.2);
/**/
translate([-20.5,-56.25,-17])
rotate([90,0,0])
fan_4020();
/**/

/*
    38mm - area = 1130
*/
module part_fan(){
    difference(){
        union(){
            /* Fan support */
            hull(){
                translate([-20, 13, dax+bw/2+3])
                rotate([60,0,0])
#                vrcube(40,.5,40,4);

                translate([-10, 5.5, dax+bw/2-1.5])
                rotate([90,0,0])
                cube([20, .5, 20]);
            }
            
            /* Upper */
            hull(){
                translate([-10, 5.5, dax+bw/2])
                rotate([90,0,0])
                cube([20, .5, 20]);

                translate([-10, 6.5, -9])
                rotate([90,0,0])
                cube([20, .5, 12]);
            }
            /**/
            hull(){
                translate([-10, 6.5, -9])
                rotate([90,0,0])
                cube([20, .5, 12]);

                translate([-15, 0, -dax-5-bw/2-.5])
                rotate([45,0,0])
                cube([30, .5, 8]);
            }

            // Right
            hull(){
                mirror([1,0,0])
                translate([-18, -33, -dax-5-bw/2 - 7])
                rotate([45,0,50])
                cube([15, 1, 7]);
                    
                translate([-15, 0, -dax-5-bw/2-.5])
                rotate([45,0,0])
                cube([30, .1, 8]);
            }
            // Left
            hull(){
                translate([-18, -33, -dax-5-bw/2 - 7])
                rotate([45,0,50])
                cube([15, 1, 7]);

                translate([-15, 0, -dax-5-bw/2-.5])
                rotate([45,0,0])
                cube([30, .1, 8]);
            }
            /* Center */
            hull(){
                translate([-9, -dax-7, -dax-5-bw/2 - 7])
                rotate([45,0,0])
                cube([18, .5, 7]);

                translate([-15, 0, -dax-5-bw/2-.5])
                rotate([45,0,0])
                cube([30, .5, 8]);
            }
            /**/
        }
        
        //------------------------------------
        // Cut
        translate([-w, -dax*3+7.5, -dax-5-bw/2 - 13])
        cube([w*2, dax*4+2, 7]);
    }
}

module part_fan2(){
    difference(){
        union(){
            /* Fan support */
            hull(){
                translate([-20, 13, dax+bw/2+3])
                rotate([60,0,0])
                vrcube(40,.5,40,4);

                translate([-20, 13, dax+bw/2])
                rotate([60,0,0])
                vrcube(40,.5,40,4);
            }
            // Right
            hull(){
                translate([-0, 13, dax+bw/2])
                rotate([60,0,0])
                vrcube(20,.5,40,4);

                translate([15, -2, dax])
                rotate([56,-30,15])
                cube([10, .5, 20]);
            }
            // Left
            mirror([1,0,0])
            hull(){
                translate([-0, 13, dax+bw/2])
                rotate([60,0,0])
                vrcube(20,.5,40,4);

                translate([15, -2, dax])
                rotate([56,-30,15])
                cube([10, .5, 20]);
            }

            hull(){
                translate([15, -2, dax])
                rotate([56,-30,15])
                cube([10, .5, 20]);

                translate([23, -10, dax-4])
                rotate([56,-20,15])
                cube([10, .5, 20]);
            }
            hull(){
                translate([23, -10, dax-4])
                rotate([56,-20,15])
                cube([10, .5, 20]);

                translate([23, -25, dax-20])
                rotate([56,0,0])
                cube([10, .5, 20]);
            }

            hull(){
                translate([23, -25, dax-20])
                rotate([56,0,0])
                cube([10, .5, 20]);

                translate([23, -25, dax-40])
                rotate([90,0,0])
                cube([10, .5, 15]);
            }

            /* Right */
            hull(){
                mirror([1,0,0])
                translate([-25, -40, -dax-5-bw/2 - 7])
                rotate([45,0,80])
                cube([15, 1, 7]);
                    
            }
            /**/
        }
        
        //------------------------------------
        // Cut
        translate([-w, -dax*3+7.5, -dax-5-bw/2 - 13])
        cube([w*2, dax*4+2, 7]);
        
        translate([-w, -dax*4+7.5, -dax-5-bw/2 - 13])
        cube([w*2, dax*4+2, 7]);
    }
}

module fan_4020(){
    color("grey")
    translate([-16.5,-15.5,-93.5])
    import("/home/hespanhol/OneDrive/openscad/HC235/stl/sunon4020.STL");
}

module hotend_e3d(detail=0){
    translate([0,0,-36.75])
    rotate([0,0,180])
    e3d(detail,1.5);
}

module hotend_base(){    
    color("grey")
    difference(){
        hull(){
            translate([-22.5,0.1,-18.9])
            vrcube(45,12.9,38.9,3);
        }
        
        hotend_e3d();
        
        // vent
        x=25;
        z=27.5;
        translate([-x/2,0,-z/2-4])
        vrcube(x,30,z,2);
    }
}

module hotend_fan(){
    color("brown")
    difference(){
        union(){
            hull(){
                translate([-20,-19,-18.9])
                vrcube(40,.5,40,4);

                translate([-22.5,-9,-18.9])
                vrcube(45,9,38.9,3);
            }
            /**/
        }
        hotend_e3d();
        
       
        // vent
        x=25;
        z=27.5;
        hull(){
            translate([-x/2,-9,-z/2-4])
            vrcube(x,9.5,z,2);
            
            translate([0,-25,0])
            rotate([90,0,0])
            cylinder(d=32, h=1);
        }
    }
}    

module voron_xcarriage(){
    /* Voron Carriage *
    translate([-20,66.2,99.3])
    rotate([-90,0,0])
    rotate([0,90,0])
    import("/home/hespanhol/OneDrive/3D Printing/VORON1.6/Gantry/X Carriage/x_carriage_frame_a.stl");

    translate([20,128,-78])
    rotate([-90,180,0])
    rotate([0,90,0])
    import("/home/hespanhol/OneDrive/3D Printing/VORON1.6/Gantry/X Carriage/x_carriage_frame_b.stl");
    /**/
    difference(){
        union(){
            // Left
            hull(){
                translate([-w/2,-dax,-dax])
                rotate([0,90,0])
                rpol(d=bw+tm*2, h=t);
                translate([-w/2,dax,dax])
                rotate([0,90,0])
                rpol(d=bw+tm*2, h=t);
            }
            // Right
            hull(){
                translate([w/2-t,-dax,-dax])
                rotate([0,90,0])
                rpol(d=bush_width+tm*2, h=t);
                translate([w/2-t,dax,dax])
                rotate([0,90,0])
                rpol(d=bush_width+tm*2, h=t);
            }
            
            translate([-w/2,-dax, -dax]) 
            rotate([0, 90, 0]) 
            rpol(h=w,d=bw+tm*2);        
            translate([-w/2, dax, dax]) 
            rotate([0, 90, 0]) 
            rpol(h=w,d=bw+tm*2);
        }
        
        /****************************/
        translate([-w/2-t/2, 0, -bs-bd/2]) 
        cube([t*2, bt, bs*2+bd]);

        /* X Bushing */
        translate([-w/2-.2,-dax, -dax]) 
        rotate([0, 90, 0]) 
        rpol(h=car_width+1,d=bush_width);        
        translate([-w/2-.2, dax, dax]) 
        rotate([0, 90, 0]) 
        rpol(h=car_width+1,d=bush_width);
        
        /* Cut */
        translate([-w, -dax*4, -dax-9-bw/2])
        cube([w*2, dax*4, 9]);
        /**/
    }    
}



m2=2.5;

bsh =belt_distance+belt_size*2+thick+1.2;    //Belt Support Height
bsw =10;           // Belt Support Width
/*----------------------------------*/

//translate([0,0,car_width/2]) rotate([0,-90,0])
//X_Carriage();

//rotate([0,-90,0]) servo_arm();

//rotate([0,90,0]) servo_mount();

module servo_arm(){
translate([-car_width/2+.5,-axis_distance/2-16, -19])
rotate([-90,0,90]){
    difference(){
        union(){
            servo_standard(18.5, 1);
            /**
            //color("silver")
            %translate([0,20, 1])
            import("stl/microswitch.stl");
            /**/
            translate([0,18.7, 5])
            rccube(13,6,2);

            translate([-6.5,14.1, 2])
            rcube(13,3,4);
        }
        
        translate([-3.25,18.65,-5])
        cylinder(d=2,h=20);   
        translate([3.25,18.65,-5])
        cylinder(d=2,h=20);   
    }
}
}    


module servo_mount(){
    translate([-car_width/4+15, -axis_distance/2-22, -13]){
        /* Servo */
        translate([-6.5,0,0])
        rotate([0,0,-90])
        color("blue")
        %sg90();
        /**/
        
        color("silver")
        difference(){
            union(){
                hull(){
                    translate([-22.3,30,-12])
                    rotate([0,0,-90])
                    vrcube(36,4,15,5);

                    translate([-22.5,18.5,3])
                    rotate([0,0,-90])
                    vrcube(14,4.2,4,2);
                }
                translate([-35,18.5,3])
                rotate([0,0,-90])
                vrcube(14,16.7,5,2);
            }
            
            /* servo */
            translate([-25,23.1,-13])
            rotate([0,0,-90])
            scube(23.25,10,13.25);
            
            translate([-34.25,21.75,1])
            rotate([0,0,-90])
            scube(14,8.5,5);
            
            /* screws */
            translate([-30,12,7.5])
            Mscrew(10,2);

            translate([-24,25.5,-6])
            rotate([0,-90,0])
            Mscrew(10,1.5);
            translate([-24,-2.75,-6])
            rotate([0,-90,0])
            Mscrew(10,1.5);
        }
    }
}

/*----------------------------------*/
module microswitch(){
    /* Microswitch */
    translate([-car_width/2,9,-25])
    difference(){
        union(){
            /*
            %translate([13,-.1,22.7])
            rotate([0,90,90])
            import("stl/microswitch.stl");
            /**/
            translate([0,thick_min+6,0])
            rotate([0,0,-90])
            vrcube(thick_min,10,25);
        }
        
        // Holes
        translate([6.5,10,5]){
            vcylinder(d=m2, h=10);
            translate([0,0,10.4])
            vcylinder(d=m2, h=10);
        }
    }
    
    /* BLtouch *
    %translate([-car_width/2,-48,-48+vpos]) 
    rotate([0,0,0])
    import("stl/BL-touch.STL");
    */
}


// Belt support left            
module belt_support(clearance=0){
    hull(){
        translate([-car_width/2,-axis_distance/2+bush_width/2+thick_min+6,-bsh/2]) 
        cube([thick+clearance,.1, bsh]);
        
        translate([-car_width/2,axis_distance/2-bush_width/2-thick_min-6,-bsh/2]) 
        cube([thick+clearance,.1, bsh]);
    }
}

module left(clearance=0){
    // belt divider
    translate([-car_width/2,-55/2,-belt_distance/2])
    cube([thick, 55, belt_distance]);            
        
    /* Left Arm */
    dist = axis_distance - bush_width/2;
    difference(){
        union(){
            // corner reinforce 
            hull()
            {
                translate([-car_width/2,-axis_distance/2+bush_width/2+thick_min+6,-bsh/2]) 
                cube([thick+clearance,.1, bsh]);
                translate([-car_width/2,-axis_distance/2,0]) 
                        rotate([0, 90, 0]) 
                        cylinder(h=thick+15,d=bush_width+thick_min*2+clearance);
            }
            
            hull()
            {
                translate([-car_width/2,axis_distance/2-bush_width/2-thick_min-6,-bsh/2]) 
                cube([thick+clearance,.1, bsh]);
                translate([-car_width/2,axis_distance/2,0]) 
                        rotate([0, 90, 0]) 
                        cylinder(h=thick+15,d=bush_width+thick_min*2+clearance);
            }
            
            // Belt support left            
            hull(){
                translate([-car_width/2,-axis_distance/2+bush_width/2+thick_min+6,-bsh/2]) 
                cube([thick+clearance,.1, bsh]);
                
                translate([-car_width/2,axis_distance/2-bush_width/2-thick_min-6,-bsh/2]) 
                cube([thick+clearance,.1, bsh]);
            }
            
        }
        /******************************/
        translate([-car_width/2+thick-belt_thick,-bsw/2-.1,-belt_distance/2-belt_size])
        cube([thick,bsw+.2,belt_distance+belt_size*2]);
  
        // belt path left
        translate([-car_width/2-belt_thick,0,-belt_distance/2-belt_size]){
            translate([-.1,-bsw/2-.1,0])
            cube([thick+.2,belt_thick+.2,belt_distance+belt_size*2]);
            translate([-.1,bsw/2-belt_thick,0])
            cube([thick+.2,belt_thick+.2,belt_distance+belt_size*2]);
             difference(){
                translate([-.1,-bsw/2-.1,0])
                cube([thick+.2,bsw+.2,belt_distance+belt_size*2]);
                        
                translate([1,0,-.1])
                cylinder(r=thick-.5, h=50);
            }
        }
        
        /** press bushing remove **/
        translate([-car_width/2-1, -axis_distance/2-1.5, -bush_width/2-10])
        cube([car_width+2, 3, 20]);            
        mirror([0,1,0])
        translate([-car_width/2-1, -axis_distance/2-1.5, -bush_width/2-10])
        cube([car_width+2, 3, 20]);            
      
    }
}

module front(clearance=0){
    pbs=8; //press bushing support
    difference(){
        union(){    
            /** press bushing **
//             translate([-car_width/2+pbs/2+car_width/4, -axis_distance/2-4, -bush_width/2])
            translate([-car_width/2+pbs*2+2, -axis_distance/2-4, -bush_width/2])
            rotate([180,0,180])
            vcube45(pbs, pbs+2, pbs);  
            
            translate([car_width/2+pbs/2-car_width/4, -axis_distance/2-4, -bush_width/2])
            rotate([180,0,180])
            vcube45(pbs, pbs+2, pbs);            
         
            /* bushing housing */
            translate([-car_width/2,-axis_distance/2,0]) 
            rotate([0, 90, 0]) 
            cylinder(h=car_width+.2,d=bush_width+thick_min*2+clearance);            
        }
        
        /** press bushing remove **/
        translate([-car_width/2-1, -axis_distance/2-1.5, -bush_width/2-10])
        cube([car_width+2, 3, 20]);            
        
        // screws        
        //translate([-car_width/2+car_width/4, -axis_distance/2-6, -bush_width/2-4])
        translate([-car_width/2+car_width/5-1, -axis_distance/2-6, -bush_width/2-4])
        rotate([-90,0,0])
        cylinder(d=m3, h=bush_width);
        translate([car_width/2-car_width/4, -axis_distance/2-6, -bush_width/2-4])
        rotate([-90,0,0])
        cylinder(d=m3, h=bush_width);
        
        // Nuts
        //translate([-car_width/2+car_width/4, -axis_distance/2-1.5, -bush_width/2-4])
        translate([-car_width/2+car_width/5-1, -axis_distance/2-1.5, -bush_width/2-4])
        rotate([-90,0,0])
        Mnut();
        translate([car_width/2-car_width/4, -axis_distance/2-1.5, -bush_width/2-4])
        rotate([-90,0,0])
        Mnut();
    }
}

module X_Carriage(clearance=0){ 
    /* Sacrifice Bridge */
    hull(){
        translate([car_width/2-thick,-axis_distance/2+bush_width/2+thick_min+6,-bsh/2]) 
        cube([layer_height,.1, bsh]);
        
        translate([car_width/2-thick,axis_distance/2-bush_width/2-thick_min-6,-bsh/2]) 
        cube([layer_height,.1, bsh]);
    }
    
    /* Touch support */
    difference(){
        union(){
        translate([-car_width/2,-axis_distance/2-14,-bsh/2]) 
        cube([thick+2, axis_distance/2-1, 3]);
        
        hull(){
            translate([-car_width/2,-axis_distance/2-6,-bsh/2]) 
            cube([thick+2, axis_distance/2-7.5, 2.5]);
            translate([-car_width/2,-axis_distance/4,-bsh/2-thick/2]) 
          #  cube([thick+2, .1, .1]);
        }
        }
        /***********************/
        
        //screw
         translate([-car_width/2+4,-axis_distance/2-10,-bsh/2-5]) 
        cylinder(d=3.5,h=20);
    }

    /*** Carriage ***/
    color("gray")
    difference(){
        union(){
            difference(){
                left(clearance);
                
                endstop();
            }
            rotate([0,0,180]) left(clearance);

            front(clearance);
            mirror([0,1,0]) front(clearance);
 
            microswitch();           
        }

        //===========================
        translate([-car_width/2-1,9,-26])
            scube(12,thick_min+4,22);
        
        /* X Bushing */
        translate([-car_width/2-.2,-27.5,0]) 
        rotate([0, 90, 0]) 
        cylinder(h=car_width+1,d=bush_width+clearance);        
        translate([-car_width/2-.2,27.5,0]) 
        rotate([0, 90, 0]) 
        cylinder(h=car_width+1,d=bush_width+clearance);
    }
}
