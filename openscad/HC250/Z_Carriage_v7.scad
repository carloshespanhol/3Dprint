// www.thingiverse.com/thing:2756180 recreated in openscad.
// quick and dirty 3d trace, lots of hard coded variables all over the place.
// designed so you can change the bearing cutout and rod cutout sizes easily.  
/*
LM12LUU
Inside Diameter: 12mm
Outside Diameter: 21mm
Length: 57mm
*/
include <config.scad>
include <parts.scad>
use <bearing-holder.scad>
//use <purge_bucket_v6.scad>
use <bed_support_v6.scad>
use <../lib.scad>
$fn=150;
print=0;

w_framebed=310;

l=60;
w=100;
t=15;
x=57.5;
t2=5.6;
tm=5;
nw=nema17_width;
motor_offset = 6;
motor_sup_len=20;
z=350;

zcarriage(z);

/* PRINT */
*rotate([180,0,0]) nut_mount();
*rotate([180,0,0]) z_motor();
*rotate([90,0,90]) zfixl();
rotate([90,0,90]) zfixlup();    
*front_support();

/**
translate([-68,0,50])
rotate([0,0,-90])
bucket();
/**/


/**/
module  zcarriage(z=268){
    
    /* Nema 17 */
    *z_motor();
    
    translate([0,-nw/2-motor_offset,0]) 
    rotate([0,0,180])
    nema17_leadscrew();
    
    translate([0,0,z-82]){
    /* Nut mount */
    nut_mount();

    /* left */
    translate([-107.5,8,14])
    rotate_z(15,[-12, -12, 0])
    left_bholder(); 

    /* right */
    translate([107.5,8,14])
    rotate_z(-15,[12, -12, 0])
    right_bholder(); 
        
    /* bed */
   # translate([0,-125 -44 -4,47 -6]){ 
        bed250();
        //bed_support();
    }
    %translate([0,-125 -44 -4,34]){ 
        rcube(100,120,5.5);
    }
    // screw
    color("lightgrey")
    %translate([105,-68,48.5 -6])
    Mscrew(40,3);
    //wheel
    color("lightgrey")
    %translate([190,81,-60])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/stl_files/Wheel.stl");

    
    /* bed frame */    
    %translate([0, 0,14]) 
    {
        translate([-110,-300,0])
        rotate_z(15,[0, 310, 0])
        cube([20,310,20]);
        
        mirror([1,0,0])
        translate([-110,-300,0])
        rotate_z(15,[0, 310, 0])
        cube([20,310,20]);
    }

    /* Bed support */
    rotate([0,180,0])    
    translate([-90,-74,-38.5])
    rotate_z(15,[-12, -12, 0])
    hotbed_support();

    mirror([1,0,0])
    rotate([0,180,0])    
    translate([-90,-74,-38.5])
    rotate_z(15,[-12, -12, 0])
    hotbed_support();
    
    /**/
    translate([0,-292,38.5])
    rotate([0,180,0])
    front_support();  
        
    }
    
    /* z axis */
    translate([121.5,-6.6,-20])
    %cylinder(d=12, h=z+40);
    translate([-121.5,-6.6,-20])
    %cylinder(d=12, h=z+40);

    /* frame */
    *color("grey") 
    translate([-200,0,-20]) 
    cube([400,20,20]);
    
    translate([-200,0,-20]) 
    rotate([90,0,90]) zfixl();    
    mirror([1,0,0])
    translate([-200,0,-20]) 
    rotate([90,0,90]) zfixl();    

    translate([-200,0,z]) 
    rotate([90,0,90]) zfixlup();    
    mirror([1,0,0])
    translate([-200,0,z]) 
    rotate([90,0,90]) zfixlup();    

}

/* Z axis fixing */
//400- 243 = 157 / 2 = 78.5
module zfixl(){
    rod=12;
    ch=0;
    x=56;
    g=.3;   // support gap
    
    // chanel
    translate([0, 10+fc/2, 5])
    rotate([90,0,0]){
        scube(5,25,fc);
        // support
        translate([1.5, 0, fc+g]) 
        support(3.5,25,10-fc/2-g,0.4);
    }
    translate([0, 10+fc/2, 50])
    rotate([90,0,0]){
        scube(5,20,fc);
        // support
        translate([1.5, 0, fc+g]) 
        support(3.5,20,10-fc/2-g,0.4);
    }

    translate([-5, 10+fc/2, -5])
    rotate([90,-90,0]){
        scube(5,25,fc);
        // support
        translate([0, 0, fc+g]) 
        support(3.5,25,10-fc/2-g,0.4);
    }
    
    difference(){
        union(){
            rotate([0,-90,0]){
                zfix();                
                rcube(60,20,rod,2);
            }
            
            translate([-rod,0,0])
            cube([rod,20,rod]);
            
            hull(){
                translate([-x,0,0])
                rcube(x,20,rod/2+2,2);

                translate([-x+10,ch,rod])
                rcube(x-10,20-ch*2,.1,2);
                
            }
            
            translate([-12,ch,12])
            rotate([0,-90,0])
            fillet(23,20-ch*2);
        }
        //-----------------------------
        
        // screws
            translate([-40,10,4])
            Mscrew(20,5.5);

            translate([-5,10,40])
            rotate([0,-90,0])
            Mscrew(20,5.5);
        //
            rotate([0,-90,0])
            translate([40,10,4])
            Mscrew(10,5.5);
    }
    
}    


/* Z axis fixing */
//400- 243 = 157 / 2 = 78.5
module zfixlup(){
    rod=12;
    ch=0;
    x=56;
    g=.3;   // support gap
    
    // chanel
    translate([0, 10+fc/2, 50])
    rotate([90,0,0]){
        translate([-1, 14, 0]) 
        scube(5,8,fc);
        // support
        translate([1.5, 14, fc+g]) 
        support(3.5,8,10-fc/2-g,0.4);
    }
    
    difference(){
        union(){
            rotate([0,-90,0])
            zfix();
            
        }
        //-----------------------------
        
        // screws
        translate([-4,10,56])
        rotate([0,-90,0])
        Mscrew(10,5.5);
        
    }    
}    

module nut_mount(){
    /* sacrifice bridge */
    if(print == 1){
        translate([0, -motor_offset-nw/2, 14+20-6])
        cylinder(d= 30, h=.2);
    }
    
    difference(){
        union(){
            // fixing
            translate([-x,-48-l,14])
            rotate([0,0,15])
            translate([0,-25,0]){
                scube(5,l+55,20);
                translate([-5, 20, 10-fc/2])
                scube(5,l,fc);
                // support
                translate([-5, 20, 10+fc/2+.3]) 
                support(3.5,l,10-fc/2-.6,0.4);
            }
            mirror([1,0,0])
            translate([-x,-48-l,14])
            rotate([0,0,15])
            translate([0,-25,0]){
                scube(5,l+55,20);
                translate([-5, 20, 10-fc/2])
                scube(5,l,fc);
                // support
                translate([-5, 20, 10+fc/2+.3]) 
                support(3.5,l,10-fc/2-.6,0.4);
            }
            
            // Nut support
            hull(){
                translate([0, -motor_offset-nw/2, 14+20-t])
                cylinder(d= 32, h=t);
                
                translate([-w/2, -50, 14+20-t]) 
                scube(w,8,t);
            }

            hull(){
                translate([-x,-48-l,14])
                rotate([0,0,15])
                scube(5,8,20);
                mirror([1,0,0])
                translate([-x,-48-l,14])
                rotate([0,0,15])
                scube(5,8,20);
            }
            
            hull(){
                translate([-l*sin(15),l*cos(15),0])
                translate([-x,-48-l,19])
                rotate([0,0,15])
                scube(5,8,15);
                mirror([1,0,0])
                
                translate([-l*sin(15),l*cos(15),0])
                translate([-x,-48-l,19])
                rotate([0,0,15])
                scube(5,8,15);
            }
           
            inner_fill();
            mirror([1,0,0])
            inner_fill();
            
        }
        
        /*******************************************/
        /* Nut reccess */
        //translate([0, -motor_offset, 14+20-5])
        translate([0, -motor_offset-nw/2, 14+20-t*2+5])
        cylinder(d= 26, h=t);
        /* Screws reccess */
        translate([-nw/2, -nw-5, 14+20-t-.1])
        rcube(nw,10,5, 2);
        
        /* Nut holes */
        translate([0, -motor_offset-nw/2,15]){
            cylinder(d=11, h=30);
           
            translate([-5.65,-5.65,-1])
            cylinder(d=m3, h=30);
            translate([-5.65,5.65,-1])
            cylinder(d=m3, h=30);
            translate([5.65,5.65,-1])
            cylinder(d=m3, h=30);
            translate([5.65,-5.65,-1])
            cylinder(d=m3, h=30);
        }
        
        // Fixing Holes
        translate([-x,-25,24])
        rotate([0,180,-75])
        vcylinder(d=m5, h=40);
        
        translate([-x/2,-57-l,24])
        rotate([0,180,-75])
        vcylinder(d=m5, h=40);

        mirror([1,0,0]){
            translate([-x,-25,24])
            rotate([0,180,-75])
            vcylinder(d=m5, h=40);
            
            translate([-x/2,-57-l,24])
            rotate([0,180,-75])
            vcylinder(d=m5, h=40);
        }
    }   
    

}

module inner_fill(){
    h=15;
    z=19;
    y=-30-t;
    
    hull(){
        translate([-x,-48-l,z])
        scube(t2,t2,h);
        translate([-x/3*2,y,z])
        scube(t2,t2,h);
    }
    hull(){
        translate([-x/3*2,y,z])
        scube(t2,t2,h);
        translate([-x/3,-48-l,z])
        scube(t2,t2,h);
    }
    hull(){
        translate([-t/4,y,z])
        scube(t2,t2,h);
        translate([-x/3,-48-l,z])
        scube(t2,t2,h);
    }
}    


module bed250(){
    difference(){
        rccube(250,250,3);

        translate([-105,105,-5]) cylinder(d=3,h=10);
        translate([105,105,-5]) cylinder(d=3,h=10);

        translate([0,-125+14,-5]) cylinder(d=3,h=10);
        /*
        translate([-105,-105,-5]) cylinder(d=3,h=10);
        translate([105,-105,-5]) cylinder(d=3,h=10);
        /**/
    }    
}


module z_motor(){
    t=tm;
    o = motor_offset; // offset
    
    difference(){
        union(){
            // fixing
            translate([-nw, -t,0])
            rcube(nw*2, 20+t, t, 2);

            translate([-nw, -t,-20])
            scube(nw/2, t, 20+t);
            translate([nw/2, -t,-20])
            scube(nw/2, t, 20+t);
            
            translate([nw/2+t, -t,0])
            rotate([90,0,0])
            fillet(10, t);
            translate([-nw/2-t, -t,0])
            rotate([90,0,-90])
            fillet(10, t);

            // top
            hull(){
                translate([-nw/2-t,-nw-o,0])
                rcube(t, nw+20, t, 2);
                translate([nw/2,-nw-o,0])
                rcube(t, nw+20, t, 2);
            }
            //left
            hull(){
                translate([-nw/2-t,-nw-o,0])
                rcube(t, nw+o, t, 2);
                translate([-nw/2-t,-t,-motor_sup_len])
                scube(t, t, motor_sup_len);
            }
            //right
            hull(){
                translate([nw/2,-nw-o,0])
                rcube(t, nw+o, t, 2);
                translate([nw/2,-t,-motor_sup_len])
                scube(t, t, motor_sup_len);
            }
            // offset
            hull(){
                translate([-nw/2,-o+1,-motor_sup_len])
                scube(t, o-1, motor_sup_len);
                translate([nw/2-t,-o+1,-motor_sup_len])
                scube(t, o-1, motor_sup_len);
            }
            
        }
        
        //--------------------------------
        translate([0,-nw/2-o,0])
        nema17_holes();
        
        // frontal holes
        translate([-nw/4*3.5, 1, -10]){
            rotate([0, 180,0])
            vcylinder(d=m5, h=nw);
            
            translate([-nw/4, -nw/4, -m5/2])
            scube(nw/4, nw, m5);
        }
        translate([nw/4*3.5, 1, -10]){
            rotate([0, 180,0])
            vcylinder(d=m5, h=nw);
            
            translate([0, -nw/4, -m5/2])
            scube(nw/4, nw, m5);
        }
        
        // top holes
        translate([-nw/2, 10, -.1])
        cylinder(d=m5,h=10);
        translate([nw/2, 10, -.1])
        cylinder(d=m5,h=10);
        
        // center mark
        translate([0, 20, -1])
        cylinder(d=.4,h=10);
        
    }
    
    // Supports
    translate([nw-6, -t, -t-7.5]) 
    support(6,t,m5-.5,0.4);
    translate([-nw, -t, -t-7.5]) 
    support(6,t,m5-.5,0.4);
}

rod_cutout_diameter = 13; //12 is the default
bearing_cutout_diameter = 21; //16 is the default
bearing_cuttout_length = 57; //25.6 is the default
//w=bearing_cutout_diameter+12;
//l=bearing_cuttout_length+3;
h=bearing_cutout_diameter/2 + 1.5;
bd=bearing_cutout_diameter;
clamp_height=10;
clamp_width=w;
clamp_depth=13;
shorten=0.3;
m3=3.3;

module left_bholder(){
    mirror([1,0,0])
    right_bholder();
}

module right_bholder(){
    difference(){
        union(){
            translate([-6,-25,7])
            rcube(6,20,6);
            translate([-6,-55,7])
            rcube(6,10,6);

            hull(){
                translate([0,-57,0])
                rcube(6,30,28,.1);
                translate([0,-25,0])
                rcube(16,20,50,.1);
            }

            // horizontal
            translate([-20,-57,20])
            rcube(24,57.5,8,.1);
        
            translate([0,-14,26])
            rotate([90,0,90])
            bholder();
        }
        // upper screws
        translate([-10,-7,25])
        Mscrew(20,5);
        translate([-10,-7,24])
        cylinder(d=12,h=40);
        
        translate([-10,-50,25])
        Mscrew(20,5);
        translate([-10,-50,24])
        cylinder(d=12,h=40);

        
        // lateral screw
        translate([-1,-41,6.75])
        rcube(10,10,6.5,.1);
        
        translate([4,-36,10])
        rotate([0,90,0])
        cylinder(d=14,h=40);
        
        
        // bearing
        translate([14.5,-14,-20])
        cylinder(d=21, h=100);
        
    }
}


module zfix(sup=0){
    rod=12;
    d=rod+.5;
    ap=78.5; 
    s=1.1;
    ch=0;
    x=ap+rod*3;
    
    if(sup==1){
        /* support */
        translate([ap+rod/2+.1,0,0])
        support(x-ap-rod/2,20, s-.2,0.4,0,1);
        /* sacrifice bridge */
        translate([ap+d/2,0,s])
        rcube(x-ap-d/2, 20, .3, 2);
    }
    
    difference(){
        union(){
            translate([42.5,0,0])
            rcube(x-42.5,20,rod/2+2,2);
            
            hull(){

                translate([42.5,ch,rod*1.5-10])
                rcube(x-42.5,20-ch*2,.1,2);

                translate([ap-rod,ch,rod*1.5])
                rcube(rod*2.25,20-ch*2,1,2);
            }
        }
        
        // axis
        translate([ap,21,rod/2-1 ]){
            vcylinder(d=d,h=30);
            
            translate([-d/2,-30,-10])
            scube(d,30,10);
        }

        // screws
        translate([ap+rod*2,10,4])
        Mscrew(10,5.5);
        
        // slack
        translate([ap,-1,-.1])
        scube(x/2,30,s+.1);
    }
}    
