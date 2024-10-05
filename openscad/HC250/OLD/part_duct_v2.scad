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


//part_duct();
//input_duct();

module part_shroud(){
    difference(){
        shroud();
        
        translate([0,-6,-40])
        difference(){
            hull(){
                translate([-(w-ds)/2,4,t])
                cylinder(d=ds-t, h=hs-t*2);
                
                translate([(w-ds)/2,4,t])
                cylinder(d=ds-t, h=hs-t*2);
                
                translate([-(bhl+t*2)/2+t, -17, t])
                rotate([48,0,0])
                cube([bhl, bhw-1.5, .1]);
            }
            
            translate([-(iw+t*2)/2,-1.5-t,-.1])
            rcube(iw+t*2,30,15,5);

        }
    }
}

/*
translate([0, 0, -50])
rotate([70.5,0,0])
%cube([1,2,50]);
/**   
translate([33,-40,-10]) 
rotate([0,45,-90])      
%blower();
/**
translate([0,0,-4.25]){  
    // E3d V6 
    translate([0,0,6])
    color("silver")
    translate([0,0,23]) 
    rotate([0,180,0])
    e3d_volcano();  
}
/**/
        
module shroud(){

    /**
    %translate([-265.25,105,-40]){
        rotate([0,0,180])
        import("stl/fan-shroud.stl");
    }
    /**/
    translate([0,-6,-40])
    difference(){
        hull(){
            translate([-(w-ds)/2,4,0])
            cylinder(d=ds, h=hs);
            
            translate([(w-ds)/2,4,0])
            cylinder(d=ds, h=hs);
            
            translate([-(bhl+t*2)/2, -17, 0])
            rotate([48,0,0])
            cube([bhl+t*2, bhw+t*2-1.5, .1]);
        }
        
        translate([-iw/2,-1.5,-.1])
        rcube(iw,30,15,5);

        translate([-iw/4,-9,-.1])
        rcube(iw/2,30,6,2);
    }
}        
module input_duct(){
    difference(){
        translate([0, -49, -27])
        rotate([48,0,0])
        translate([0,0.5,10-.1])
        rotate([-3,0,0])
        translate([10,28,24]){       
            rotate([-45,0,0])
            difference(){
                union(){
                    sphere(sd/2);                    
                    cylinder(d=sd, h=8);
                    
                    hull(){
                        translate([0.1,-30.5,-4])
                        rotate([0,90,0])
                        cylinder(d=10, h=t);

                        translate([0.1,0,-4])
                        rotate([0,90,0])
                        cylinder(d=32, h=t*6);
                    }
                } 
 
                difference(){
                    union(){
                        sphere((sd-t*2)/2);
                        cylinder(d=sd-t*2, h=30);
                    }
                    translate([19,-20,-20])
                    cube([20,50,50]);
                }
                translate([-5,-30,5])
                cube([50,60,20]);
                
                translate([0,-30.5,-4])
                rotate([0,90,0])
                cylinder(d=4, h=bhw);

                translate([2.3,-30.5,-4])
                rotate([0,90,0])
                Mscrew();
            }
        }

        // cut left
        translate([-20+.5-bhw/2,-100, -10])
        cube([20+bhw,100,100]);
        
        // cut top
      //  translate([0,-100, 27]) cube([50,100,20]);
    }
}

module part_duct(){
    shroud();

    difference(){
        union(){
            blower_duct();
        }
        /* Cut Bottom */
        translate([-50, -50, -20-40])
        cube([100,100,20]);
    }    
}

module blower_duct(){    
    translate([-9, -50, -30])
    rotate([48,0,0]){
        
    /* Support */
    translate([0,0.5,10-.1])
    rotate([-3,0,0])
    difference(){
        hull(){
            cube([bhw+t*2, 25, .1]);
            
            translate([0,6.5,44])
            rotate([0,90,0])
            cylinder(d=10, h=bhw+t*2);
        }
        
        translate([t,-5,-.1])
        cube([bhw, bhl*2, 60]);

        translate([-1,6.5,44])
        rotate([0,90,0])
        cylinder(d=4, h=bhw+t*3);

        translate([t*2,31.5,25.5])
        rotate([0,90,0])
        cylinder(d=45, h=bhw+t*3);
    }
    
    difference(){
        union(){
            /* Blower conect */
            rotate([-3,0,0])
            cube([bhw+t*2, 25, 10]);
            
            /* Duct */
            hull(){
                cube([bhw+t*2, 25, .1]);
                
                translate([( (bhw+t*2) -25 )/2+1.5, 11.25, -27])
                cube([23.35, bhw+t*2-1.5, .1]);
            }
            
        }
        /**********************************/
        
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
    }
    
    }
}

/********/  
module blower(){
    //color("gray")
   // translate([40,0,0]) 
   // rotate([0,0,90])
   // mirror([0,1,0])
    import("stl/50_mm_blower_fan_placeholder.stl");    
}
module PrusaShroud(){
    translate([-265,105,-40]){
        rotate([0,0,180])
        import("stl/fan-shroud.stl");
    }
}
module PrusaShroud(){
    translate([-265,105,-40]){
        rotate([0,0,180])
        import("stl/fan-shroud.stl");
    }
}