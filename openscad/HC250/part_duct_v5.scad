use <../lib.scad>
//include <config.scad>
use <parts.scad>
$fn=64;

bhl = 19.5;     // Blower hole length
bhw = 15.8;   // Blower hole width 
lw=1;

di=8;
do=13;
d_end=22;
xd=do/2+d_end;
t=1.4;
tol=0.6;

/********
translate([0, 0, -39])
rotate([82,0,0])
%cube([1,2,50]);
/**   
translate([33,-40,-10]) 
rotate([0,45,-90])      
%blower();
/**
mirror([1,0,0])
print_end();
/* E3d V6 */
%translate([0,0,7]) 
e3d(1, 1.5);  
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

module print_end(){
    difference(){
        end();
        
        translate([0,0,25.2])
        mirror([0,1,0])
        rotate([180,0,180])
        connector(tol);
    }    
}


module part_duct(){
    //silicone cap: 1.5
    difference(){
        translate([0,0,5])
        union(){
            /**/
            blower_duct();
                
            middle();
            
            translate([d_end,-14,-28])
            rotate([-90,0,0])
            connector();

            mirror([1,0,0])
            translate([d_end,-14,-28])
            rotate([-90,0,0])
            connector();
            
            /**/
            translate([-d_end,8,-28])
            rotate([90,0,0])            
            end();
            
            mirror([1,0,0])
            translate([-d_end,8,-28])
            rotate([90,0,0])            
            end();
            /**/
        }
        
        /* Cut Bottom */
        translate([-50, -50, -20-41+9])
        cube([100,100,20]);
        /* Cut hotend *
        translate([-10, -13, -40])
        cube([20,30,20]);
        /**/
    }    
}



module end(){
    difference(){
        union(){            
            /* end */
            hull(){
                cylinder(d=do+1,h=.1);
                
                translate([0,0,25])
                cylinder(d=do+1,h=.1);
            }
            
            //shroud
            rotate([-90,0,0])
            translate([1,-22,-3])
            rotate([0,-35,0])
            sarc(22,5,19,60);
        }
        //------------------------
        
        //end duct
        rotate([-90,0,0])
        translate([t,-21+t,2.5])
        rotate([0,-15,0])
        sarc(20-t*2,2,19,80);
        
        // duct
        hull(){
            translate([0,0,2])
            cylinder(d=di,h=.1);
            
            translate([0,0,23])
            cylinder(d=di+2,h=do);
        }

        /* Cut Bottom */
        translate([0, -10-9, -1])
        cube([30,10,30]);
        /* Cut Top */
        translate([-15, do/2-.7, -1])
        cube([30,10,30]);
        /* Cut End */
        translate([12, -15, -1])
        cube([10,30,30]);
        /**/
    }
}

module connector(tol=0){
    h=16;
    ch= do-di-t;
    
    translate([0,0,-3])
    difference(){
        union(){
            cylinder(d=di+t*2+tol,h=h);

            cylinder(d1=do+tol, d2=di+t*2+tol, h=ch);
            
            hull(){
                translate([di/2+t+tol,-t-tol/2,0])
                cube([t,t*2+tol,ch*2]);
                
                translate([di/2+tol,-t-tol/2,ch*2])
                cube([.1,t*2+tol,ch]);
            }
        }
        
        
        translate([0,0,-.1])
        cylinder(d=di,h=h+1);

        translate([2,t*4-tol/2-2,ch-.2])
        rotate([0,0,150])
        cube([do*2,di-tol,h]);
    }    
}

module middle(){
    di_end=8;

    difference(){
        union(){
            difference(){
                translate([0,-3,-.5])
                hull(){
                    translate([0,-26,-27])
                    rotate([60,0,0])
                    translate([0,-6+t,-3])
                    scube(.1,do-t/2,.1);

                    translate([-xd/4*2.5,-14-3,-34])
                    rotate([60,0,0])
                    scube( xd/4*5,do+t,.1);
                }
                //---------------------------
                // front duct 
                translate([-7,-38,-27.5])
                rotate([-20,0,0])
                scube(14,40,2);
            }
            
            // divisor
            translate([0,-28,-27.5])
            rotate([60,0,0])
            hull(){
                translate([-.5,-3.5,-3])
                scube(1,di,.1);

                translate([-.5,-10, 19.5])
                rotate([-8,0,0])
                cube([1,bhl-1.5,.1]);            
            }
        }

        translate([0,-3,-.5])
        translate([-xd,-14+do,-34])
        rotate([90,0,0])
        scube( xd*2,do+t*2,do);
    }
    
    difference(){
        union(){
            /* joint */
            translate([-xd,-17,-34.5])
            rotate([90,0,0])
            rcube( xd*2,do,do+t,do/2);

            /**/
            translate([0,-28,-27.5])
            rotate([60,0,0])
            hull(){   
                translate([-xd+1,-7.5,-1])
                rcube(xd*2-2,do+1,.1,do/2);

                translate([-bhw/2-1.5,-13,18])
                rotate([-8,0,0])
                cube([bhw+3,bhl+5,2]);
            }
            /**/    
        }
        //**********************

        // front duct 
        translate([-7,-38,-27.5])
        rotate([-20,0,0])
        scube(14,40,2);
        
        /* joint duct */
        translate([-xd+do/2-di/2,-20,-32.1])
        rotate([90,0,0])
        rcube(xd*2-do+di,di,di,di/2);

        //end duct
        translate([-xd+do/2,-14+t*2+di_end/2,-36+t+do/2])
        rotate([90,0,0])
        cylinder(d=di, h=di*2);

        mirror([1,0,0])
        translate([-xd+do/2,-14+t*2+di_end/2,-36+t+do/2])
        rotate([90,0,0])
        cylinder(d=di, h=di*2);

        //blower connector
        translate([0,-28,-27.5])
        rotate([60,0,0])
        hull(){
            translate([-20+t*1.5,-3.5,-3])
            rcube(40-t*3,di,.1,di/2-t);

            translate([-bhw/2+1.3,-10.2, 21])
            rotate([-8,0,0])
            cube([bhw-3,bhl-1.5,.1]);            
        }
    }

    /**/
}



module blower_duct(){    
    translate([-9.5, -50, -30])
    rotate([55,0,0]){
        
    /* Support */
    translate([0,0.5,10-.1])
    rotate([-3,0,0])
    difference(){
        hull(){
            translate([-t/2,0,0])
            cube([bhw+t*3, 25, .1]);
            
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
            translate([-t/2,0,2])
            rotate([-3,0,0])
            cube([bhw+t*3, 25, 8]);            
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
