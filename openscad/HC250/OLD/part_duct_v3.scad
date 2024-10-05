use <../lib.scad>
use <parts.scad>
include <config.scad>
$fn=200;


bhl = 20;     // Blower hole length
bhw = 15.8;   // Blower hole width 
t = 1.6;
lw=1;
sd=45;
    ds=20;
    hs=4;
    w=35;
    iw=22;
/********/ 


part_duct();


/**/
translate([0, 0, -39])
rotate([82,0,0])
%cube([1,2,50]);
/**   
translate([33,-40,-10]) 
rotate([0,45,-90])      
%blower();
/**/
%translate([0,0,-4.25]){  
    // E3d V6 
    translate([0,0,6])
    color("silver")
    translate([0,0,23]) 
    rotate([0,180,0])
    e3d_volcano();  
}
/**/
module part_duct(){
    difference(){
        union(){
            blower_duct();
            
                
            middle();
            
            middle_end();
            
            end();
            mirror([1,0,0])
            end();
          /*  mid_duct();
            mirror([1,0,0])
            mid_duct();
            /**/
        }
        /* Cut Bottom */
        translate([-50, -50, -20-37])
        cube([100,100,20]);
        /*
        translate([-50, -75, -10.5-36])
        rotate([-8,0,0])
        cube([100,100,20]);
        /**/
    }    
}

module end(){
translate([-15,10,-32])
rotate([90,0,0])
difference(){   
    cylinder(d=10,h=20);
    
    translate([0,0,2])
    cylinder(d=6,h=30);
    
    translate([0,-3,2])
    rotate([0,0,-25])
    cube([20,3, 15]);
}
}
module middle(){
    difference(){
    translate([0,-25,-27])
    rotate([60,0,0])
    hull(){   
        hull(){
            translate([-4,0,0])
            cylinder(d=12,h=1);
            translate([4,0,0])
            cylinder(d=12,h=1);
        }   
        
        translate([-bhw/2-1.5,-12-3,20])
        rotate([-15,0,0])
        cube([bhw+3,bhl+5,2]);
    }

    translate([0,-25,-28])
    rotate([60,0,0])
    hull(){

        hull(){
            translate([-4,0,-.5])
            cylinder(d=8,h=3);    
            translate([4,0,-.5])
            cylinder(d=8,h=3);    
        }

        translate([-bhw/2,-12.3,19.5])
        rotate([-15,0,0])
        cube([bhw,bhl,10]);
        
    }
}
}

module middle_end(){
    difference(){
    translate([0,-25,-27])
    rotate([60,0,0])
    union(){
        hull(){   
            hull(){
                translate([-4,0,0])
                cylinder(d=12,h=1);
                translate([4,0,0])
                cylinder(d=12,h=1);
            }   
            
            translate([-15,3.5,-16])
            rotate([30,0,0])
            cylinder(d=10,h=.5);

        }
        hull(){   
            hull(){
                translate([-4,0,0])
                cylinder(d=12,h=1);
                translate([4,0,0])
                cylinder(d=12,h=1);
            }   
            
            mirror([1,0,0])
            translate([-15,3.5,-16])
            rotate([30,0,0])
            cylinder(d=10,h=.5);

        }
    }
    translate([0,-25,-27])
    rotate([60,0,0])
    union(){
        hull(){

            hull(){
                translate([-4,0,-.5])
                cylinder(d=8,h=3);    
                translate([4,0,-.5])
                cylinder(d=8,h=3);    
            }

            translate([-15,3.5,-16.5])
            rotate([30,0,0])
            cylinder(d=8,h=2);
            
        }
        hull(){

            hull(){
                translate([-4,0,-.5])
                cylinder(d=8,h=3);    
                translate([4,0,-.5])
                cylinder(d=8,h=3);    
            }

            mirror([1,0,0])
            translate([-15,3.5,-16.5])
            rotate([30,0,0])
            cylinder(d=8,h=2);
            
        }
    }
    }
}

module mduct(w=0){
    /* Duct */
    hull(){
        translate([w*2,0,w])
        cube([(bhw+t*2)/2-w*3, 25-w, .1]);
        
        translate([w*2-20,bhl/2+9+w*2.5-2,-25-w])
        rotate([0,-20,-15])
        cube([18-w*5, (bhw+t*2-1.5)/2-w*5+2, .1]);

        translate([w*2-20, bhl/2+9+w*2.5-2,-25-w])
        rotate([0,-20,0])
        cube([20-w*5, (bhw+t*2-1.5)/2-w*5+1, .1]);
        /**/
    }
    /**/
    hull(){
        translate([w*2-20,bhl/2+9+w*2.5-2,-25-w])
        rotate([0,-20,0])
        cube([20-w*5, (bhw+t*2-1.5)/2-w*5+1, .1]);

        translate([w*2-20,bhl/2+9+w*2-2,-25+w])
        rotate([0,-20,-15])
        cube([18-w*5, (bhw+t*2-1.5)/2-w*5+2, .1]);
        
        translate([w*5-12,bhl/2+18+w*2,-42-w])
        rotate([0,-45,-35])
        cube([18-w*5, (bhw+t*2-1.5)/2-w*5, .1]);
    }
    /**/
}

module mid_duct(){
    translate([-9, -50, -30])
    rotate([48,0,0])
    difference(){
        mduct();
        
        mduct(1);
    }
}


module blower_duct(){    
    translate([-9.5, -50, -30])
    rotate([48,0,0]){
        
    /* Support */
    translate([0,0.5,10-.1])
    rotate([-3,0,0])
    difference(){
        hull(){
            cube([bhw+t*2, 25, .1]);
            
            translate([0-1,6.5,40])
            rotate([0,90,0])
            cylinder(d=10, h=bhw+t*2+2);
        }
        

        translate([t,-5,-.1])
        cube([bhw, bhl*2, 60]);

        translate([-t-1,6.5,40])
        rotate([0,90,0])
        cylinder(d=4, h=bhw+t*6);

        translate([t*2,31.5,25.5])
        rotate([0,90,0])
        cylinder(d=45, h=bhw+t*3);
    }
    
    difference(){
        union(){
            /* Blower conect */
            rotate([-3,0,0])
            cube([bhw+t*2, 25, 10]);
            
            /* Duct *
            hull(){
                cube([bhw+t*2, 25, .1]);
                
                translate([( (bhw+t*2) -25 )/2+1.5, 11.25, -27])
                cube([23.35, bhw+t*2-1.5, .1]);
            }
            /**/
        }
        /**********************************/
        translate([t,20,4])
        cube([bhw, 10, 5]);
        
        /* Blower conect */
        rotate([-3,0,0]){
            translate([t,lw*2,.1])
            cube([bhw,bhl,20]);
            /* Slot */
            translate([t+bhw/2-2, -bhl/2,5])
            cube([4,bhl,7]);
        }
        
        /* Duct */
        hull(){
            translate([t,lw*2,.1])
            cube([bhw,bhl,.1]);
            
            translate([-.5,lw*2+11.5,-30])
            cube([bhl, bhw-1, .1]);            
        }
        /**/
    }
    
    
    
    }
}

/********/  
module blower4020(){
    //color("gray")
   // translate([40,0,0]) 
   // rotate([0,0,90])
   // mirror([0,1,0])
    import("/home/hespanhol/OneDrive/openscad/HC235/stl/FAN_BLOWER_4020.stl");
    
}
module blower(){
    //color("gray")
   // translate([40,0,0]) 
   // rotate([0,0,90])
   // mirror([0,1,0])
    import("stl/50_mm_blower_fan_placeholder.stl");    
}
