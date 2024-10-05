use <../lib.scad>
//include <config.scad>
use <parts.scad>
$fn=64;

bhl = 20;     // Blower hole length
bhw = 15.8;   // Blower hole width 
t = 1.6;
lw=1;
/********
translate([0, 0, -39])
rotate([82,0,0])
%cube([1,2,50]);
/**   
translate([33,-40,-10]) 
rotate([0,45,-90])      
%blower();
/**/

/* E3d V6 */
%translate([0,0,0]) 
e3d();  
/**/

translate([0,0,41])
part_duct();


/**/
module blower(){
    //color("gray")
   // translate([40,0,0]) 
   // rotate([0,0,90])
   // mirror([0,1,0])
    import("stl/50_mm_blower_fan_placeholder.stl");    
}

module part_duct(){
    //silicone cap: 1.5
    difference(){
        translate([0,0,5])
        union(){
            /**/
            blower_duct();
                
            middle();
            
            end();
            mirror([1,0,0])
            end();
            /**/
        }
        
        /* Cut Bottom */
        translate([-50, -50, -20-41+2])
        cube([100,100,20]);
        /**/
    }    
}


module sarc(l,w,r,a){
    rotate([-90,0,0])
    difference(){
        translate([r,0,0])
        cylinder(d=r*2, h=l);

        //======================
        translate([r,0,-.1])
        cylinder(r=r-w, h=l+1);
        
        /* Cut top */
        translate([-5, -r*3, -.1])
        cube([r*3,r*3,l+1]);
        /* Cut arc */
        translate([r, 0, -.1])
        rotate([0,0,90-a]){
            translate([0, -.1, 0])
            cube([r*2,r*2,l+1]);
            
            mirror([0,1,0])
            cube([r*2,r*2,l+1]);
        }
    }
}    

module end(){
    di=7;
    do=12;
    t=1;
    translate([-18,8,-35])
    difference(){
        union(){
            
            /* end */
            rotate([90,0,0])
            hull(){
                cylinder(d=do,h=.1);
                
                translate([0,0,22])
                //rotate([0,45,30])
                cylinder(d=do,h=.1);
            }
            
            //shroud
            translate([0,-18,-2.5])
            rotate([0,-20,0])
            sarc(18,4,17,60);
        }
        //------------------------
        
        //end duct
        translate([t,-17+t,-2.5])
        rotate([0,-20,0])
        sarc(16-t*2,4-t*2,15,60);
        
        /* joint duct */
        translate([0,-20-(do-di)/2,-di/2])
        rotate([90,0,0])
        scube(30,di,di);
        
        // duct
        rotate([90,0,0])
        hull(){
            translate([0,0,2])
            cylinder(d=di,h=.1);
            
            translate([0,0,23])
            cylinder(d=di+2,h=do);
        }
    }
}
module middle(){
    di=10;
    do=12;
    di_end=7;
    /**/
    difference(){
        union(){
            /* joint */
            translate([-24,-14,-41])
            rotate([90,0,0])
            rcube(48,do,do+t,do/2);

    translate([0,-25,-27])
    rotate([60,0,0])
    hull(){   
        translate([0,-2,5])
        hull(){
            translate([-10,-1,-15])
            cylinder(d=do,h=1);
            translate([10,-1,-15])
            cylinder(d=do,h=1);
        }   
        
        translate([-bhw/2-1.5,-12-3,22])
        rotate([-10,0,0])
        cube([bhw+3,bhl+5,2]);
    }
}
    //**********************

    /* joint duct */
    translate([-24+t,-14-t,-41+t])
    rotate([90,0,0])
    rcube(48-t*2,di,di,di/2);

    translate([-24+t+di_end/2,-14+t*2+di_end/2,-40+t+di_end/2])
    rotate([90,0,0])
    cylinder(d=di_end, h=di);

    mirror([1,0,0])
    translate([-24+t+di_end/2,-14+t*2+di_end/2,-40+t+di_end/2])
    rotate([90,0,0])
    cylinder(d=di_end, h=di);

    //
    translate([0,-25,-27])
    rotate([60,0,0])
    hull(){
        translate([0,-2.5,5])
        hull(){
            translate([-10,0.4,-15.5])
            cylinder(d=di-.5,h=.1);    
            translate([10,0.4,-15.5])
            cylinder(d=di-.5,h=.1);    
        }

        translate([-bhw/2+1,-12, 25])
        rotate([-10,0,0])
        cube([bhw-2,bhl,.1]);
        
    }
    }
    /**/
}

module middle_end(){
    di=13;
    do=18;
    
    difference(){
    translate([0,-25,-27])
    rotate([60,0,0])
    union(){
        //left
        hull(){ 
            translate([0,-2,5])  
            hull(){
                translate([-10,0,0])
                cylinder(d=do,h=1);
                translate([0,0,0])
                cylinder(d=do,h=1);
            }   
            /**/
            translate([-17,-2,-10.5])
            rotate([30,0,0])
            cylinder(d=14,h=.1);
            /**/
        }
        // right
        hull(){   
            translate([0,-2,5])  
            hull(){
                translate([0,0,0])
                cylinder(d=do,h=1);
                translate([10,0,0])
                cylinder(d=do,h=1);
            }   
            /**/            
            mirror([1,0,0])
            translate([-24,-2,-10.5])
            rotate([0,38,-5])
            cylinder(d=14,h=.1);
            /**/
        }
    }
    
    //************************
    translate([0,-25,-27])
    rotate([60,0,0])
    union(){
        // left flux
        hull(){
            translate([0,-2,3])  
            hull(){
                translate([-10,0,0])
                cylinder(d=di,h=3.5);    
                translate([-2,0,0])
                cylinder(d=di,h=3.5);    
            }

            translate([-18.5,-2,-13])
            rotate([0,38,-5])
            cylinder(d=7.5,h=2);            
        }
        //right flux
        hull(){
            translate([0,-2,5])  
            hull(){
                translate([9,0,-.5])
                cylinder(d=di,h=3.5);    
                translate([0,0,-.5])
                cylinder(d=di,h=3.5);    
            }

            mirror([1,0,0])
            translate([-25.5,-2,-12])
            rotate([0,38,-5])
            cylinder(d=8,h=2);
        }
    }
    }
}


module blower_duct(){    
    translate([-9.5, -50, -30])
    rotate([55,0,0]){
        
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

        translate([10,10,80])
        rotate([0,90,0])
        cube([50,20,15]);
    }
    
    difference(){
        union(){
            /* Blower conect */
            translate([0,0,2])
            rotate([-3,0,0])
            cube([bhw+t*2, 25, 8]);            
        }
        /**********************************/
        translate([t,20,6])
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
