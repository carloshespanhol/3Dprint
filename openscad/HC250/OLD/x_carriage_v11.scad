include <config.scad>
use <parts.scad>
use <part_duct_v5.scad>
use <../lib.scad>
use <../timing_belts.scad>
$fs=0.2;
$fn=10;

t=thick;
tm=thick_min+.5;
w=car_width;
bt=belt_thick;
bs=belt_size;
bd=belt_distance;
bw=bush_width;

print=1;


m2=2.5;

//Belt Support Height
bsh =belt_distance+belt_size*2+thick+1.2;  
// Belt Support Width
bsw =10;           
mw=23.5;
ts=1.5;
/*----------------------------------*/
// distance from nozle
//#translate([30,-3,-50]) scube(1,3,80);

if(print == 1){
//    translate([0,0,14]) rotate([90,0,0]) hotend_fan();
//    translate([0,0,12.5]) rotate([-90,0,0]) hotend_base();
    
    //translate([0,0,12.5]) rotate([0,-90,45]) 
    voron_xcarriage();
    
   
}else{
    voron_xcarriage();
    //xcarriage();
}


module xcarriage(){
    /**/
    voron_xcarriage();
    
    /* Hotend */
    translate([0,-2,-6.5])
    rotate([0,0,180])
    {
        hotend_base();
        hotend_fan();
        hotend_e3d(1);
        /**/
        translate([-20.5,-14.5,-19])
        rotate([90,0,0])
        fan_4020();   
        /**/
    }
    
    
    /* Blowers *
    translate([0,-41,-18.5]){
        // Left 
        translate([-15,0,0])
        rotate([-52,0,180])
        blower();
        // Right
        translate([14,0,0])
        rotate([-52,0,180])
        blower();
    }
    /* bottom */
    translate([0,-35,-20])
    hull(){
        translate([-23.5-ts,0,-19])
        cube([ 47+ts*2, .1, 1]);
        translate([-19-ts,12,-19])
        cube([ 38+ts*2, .1, 1]);
    }
    
    /**/
    translate([0,-35,-20])
    difference(){
        union(){
            hull(){
                translate([-16.5-ts,19,-25])
                rotate([-20,0,0])
                cube([ 34+ts*2, 1, 7+ts]);

                translate([-mw-ts,-1.5,-19])
                rotate([-20,0,0])
                cube([ mw*2+ts*2, 1, 7+ts*2]);
            }
            
            // bottom
            translate([-23.5-ts,-18,-19])
            cube([ 47+ts*2, 17, 3]);
            
            // Right 
            translate([14.7,-5,3])
            blower_duct();
            middle();
            
            // Left 
            mirror([1,0,0]){
                translate([14.7,-5,3])
                blower_duct();
                middle();
            }
        }
        
        //-------------------------------
 
        hull(){
            translate([-mw,-4,-16])
            rotate([-20,0,0])
            cube([ mw*2, .1, 6.5]);
            
            translate([-16+.5,-4,-14])
            rotate([-20,0,0])
            cube([ 32, 35, 5]);
        }
     
        translate([-50,-20,-27])
        cube([ 100, 100, 8]);
    
    }
        /**/
}

reccess=1.5;
ba=36; // bush angle
s=10;
lh=0.2;

module voron_xcarriage(){
    /* support */
    //if(print == 1)
    {
        translate([-w/2+t-reccess+lh, 0, bs+bd/2]) 
        rotate([0,90,0])
        support(bs*2+bd, 15, w-t*2+reccess*2-lh*2,  0.4);        
    }
    
    difference(){
        union(){
            /* Left */
            hull(){
                translate([-w/2,-dax,-dax])
                rotate([ba, 0, 0]) //
                rotate([0,90,0])
                rpol(d=bw+tm*2, h=t, s=s);
                translate([-w/2,dax,dax])
                rotate([ba, 0, 0]) //
                rotate([0,90,0])
                rpol(d=bw+tm*2, h=t, s=s);
            }
            translate([-w/2, 0, -bs-bd/2-bt-2]) 
            cube([t, 12, bs+bd]);
            translate([-w/2, 0, -bs-bd/2-bt-5.5]) 
            cube([t, 12, 15]);
            translate([-w/2, -12, -bs-bd/2-bt-14.5]) 
            cube([t, 18, 15]);
            
            // hotend slot
            color("orange")
            translate([-21,12.25,14])
            scube(6,3,4);
            difference(){
                translate([-w/2,1,14])
                scube(w,8,5);
                
                translate([-13, 0, 10]) 
                cube([26, 15, 10]);
            }

            /* Right */
            hull(){
                translate([w/2-t,-dax,-dax])
                rotate([ba, 0, 0]) //
                rotate([0,90,0])
                rpol(d=bush_width+tm*2, h=t, s=s);
                translate([w/2-t,dax,dax])
                rotate([ba, 0, 0]) //
                rotate([0,90,0])
                rpol(d=bush_width+tm*2, h=t, s=s);
            }
            translate([w/2-t, 0, -bs-bd/2-bt-5.5]) 
            cube([t, 12, 15]);
            translate([w/2-t, -12, -bs-bd/2-bt-14.5]) 
            cube([t, 18, 15]);
            
            color("orange"){
                translate([15,12.25,14])
                scube(6,3,5);
                translate([15,1,14])
                scube(6,8,5);
            }
            
            /* Bushing */
            translate([-w/2,-dax, -dax]) 
            rotate([ba, 0, 0]) //
            rotate([0, 90, 0]) 
            rpol(h=w,d=bw+tm*2,s=10);        
            translate([-w/2, dax, dax]) 
            rotate([ba, 0, 0]) //
            rotate([0, 90, 0]) 
            rpol(h=w,d=bw+tm*2,s=10);
            /**/
        }
        
        //------------------------------------
        // endstop switch
        translate([-w/2-t, 10, 16.5]) 
        rotate([60,0,0]){
            cube([w, 20, 6]);
            cube([w, 5, 6]);
        }
        
        // cable tie
        translate([15,10,21])
        rotate([-45,0,0])
        scube(20,2,4);
        
        translate([-w/2-1,-24,-13])
        rotate([-45,0,0])
        scube(w+4,2,4);
        
        // nut
        translate([23.5,2,-20.5])
        rotate([90,90,0])
        MnutPocket(10);
        translate([-23.5,2,-20.5])
        rotate([90,-90,0])
        MnutPocket(30);
        
        // upper cut
        rotate([45,0,0])
        translate([-50, -20, 9.25]) 
        cube([100, 40, 20]);
        
        /* Belt slot */
        translate([-w/2-t/2, -bt/2, -bs-bd/2]) 
        cube([t+w, bt, bs*2+bd]);
        
        if(print == 1){
            // belt fixer holes
            translate([-w/2-t/2, bt*2, -bt/2]) 
            cube([t+w, bt*2, bt]);
            translate([-w/2-t/2, bt*2, bs+bd/2]) 
            cube([t+w, bt*2, bt]);
            translate([-w/2-t/2, bt*2, -bs-bd/2-bt]) 
            cube([t+w, bt*2, bt]);
            // belt reccess
            translate([-w/2+t-reccess, 0, -bs-bd/2-.1]) 
            cube([t, 30, bs*2+bd+.2]);        
            translate([w/2-t*2+reccess, 0, -bs-bd/2-.1]) 
            cube([t, 30, bs*2+bd+.2]);
            // belt grip
            translate([-w/2+t-reccess, 0, -bs+1.5])
            rotate([0,0,90])
            belt_len(profile = 0, belt_width = 8, len = 13);
            translate([-w/2+t-reccess, 0, bd-.5])
            rotate([0,0,90])
            belt_len(profile = 0, belt_width = 8, len = 30);
            mirror([1,0,0]){
                translate([-w/2+t-reccess, 0, -bs+1.5])
                rotate([0,0,90])
                belt_len(profile = 0, belt_width = 8, len = 13);
                translate([-w/2+t-reccess, 0, bd-.5])
                rotate([0,0,90])
                belt_len(profile = 0, belt_width = 8, len = 30);
            }
        }
        
        /* X Bushing */
        translate([-w/2-.2,-dax, -dax]) 
        rotate([ba, 0, 0]) //
        rotate([0, 90, 0]) 
        rpol(h=w+1,d=bush_width,s=10);        
        translate([-w/2-.2, dax, dax]) 
        rotate([ba, 0, 0]) //
        rotate([0, 90, 0]) 
        rpol(h=w+1,d=bush_width,s=10);
        
        /* Cut */
        translate([-w, -dax*4, -dax-8-bw/2])
        cube([w*2, dax*4, 9]);
        /**/
    }    
}

module middle(){
    difference(){
        union(){
            hull(){
                translate([0,-13-1-5,-17-ts+3])
                rotate([-37,0,0])
                cube([bhw+ts*2+6.4, 1, 20+ts*2+2]);
                
                translate([-ts,-4-1.9,-16-ts-.5])
                rotate([-20,0,0])
                cube([ mw+ts*2, 5, 7+ts*2]);
            }
            
            translate([mw+2.75-t,-t,0])
            rotate([-45,0,0])
            cube([t-1,t,25]);
        }
        //---------------------------------
        translate([-w/2-1,5,13])
        rotate([-45,0,0])
        scube(w+4,2.5,4);
        
        hull(){
            translate([6.5,-13-5,-17+3])
            rotate([-37,0,0])
            cube([bhw, .1,20]);
            
            translate([6.5,-12,-15])
            rotate([-37,0,0])
            cube([bhw, .1,8]);
        }
        /**/
        hull(){
            translate([6.5,-12,-15])
            rotate([-37,0,0])
            cube([bhw, .1,8]);
            
            translate([0,-4,-16])
            rotate([-20,0,0])
            cube([ mw, .1, 7]);
        }
    }
}
        
bhl = 19.5;     // Blower hole length
bhw = 15.8;   // Blower hole width 
lw=1;

di=8;
do=13;
d_end=22;
xd=do/2+d_end;
tol=0.6;

module blower_duct(){    
t=1.4;
    translate([-9.5, -12, -20])
    rotate([55,0,0]){
        
    /* Support */
    translate([0,0.5,10-.1])
    rotate([-3,0,0])
    difference(){
        hull(){
            translate([t*2,0,0])
            cube([bhw+t, 25, .1]);
            
            translate([t*2,6.5,40])
            rotate([0,90,0])
            cylinder(d=10, h=bhw+t);
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
            translate([-t,0,2])
            rotate([-3,0,0])
            cube([bhw+t*4, 25, 8]);            
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
    w=40;
    color("grey")
    difference(){
        hull(){
            translate([-w/2,-0.1,-18.75])
            vrcube(w,1,38.6,3);
            
            translate([-w/2, 7.5,-18.75])
            rotate([4,0,0])
            vrcube(w,5.5,38.6,3);
        }

        //-------------------------------
        hotend_e3d();
        
        // cable 
        translate([-w/2-.1,-0.2,-w/2])
        scube(4,6,50);        
        translate([w/2+.1-4,-0.2,-w/2])
        scube(4,6,50);        
        
        // vent
        x=25;
        z=29;
        hull(){
            translate([-x/2,13,-z/2-2])
            vrcube(x,1,z-1,2);

            translate([-x/2,0,-z/2-3])
            vrcube(x,1,z,2);
        }
        
        translate([10,9,16.5])
        rotate([-90,0,0])
        Mscrew(15, b=1);
        translate([-10,9,16.5])
        rotate([-90,0,0])
        Mscrew(15, b=1);
        
    }
}

module hotend_fan(){
    w=40;
    
    color("brown")
    difference(){
        union(){
            translate([-w/2-6.5,-14,-18.5])
            scube(w+13,6,9);

            hull(){
                translate([-20,-14,-18.75])
                vrcube(w,.5,39.5,.5);

                translate([-w/2,-9.25,-18.75])
                vrcube(w,9,38.6,3);
            }
            /**/
            translate([-20,-14,15])
            scube(5,3,8);
            translate([15,-14,15])
            scube(5,3,8);
        }
        
        //----------------------------------
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

        // nuts
        translate([10,-6,16.5])
        rotate([90,0,0])
        MnutPocket(s=30,b=true);
        translate([-10,-6,16.5])
        rotate([90,0,0])
        MnutPocket(s=30,b=true);
        
        // screws
        translate([23.5,-12,-14])
        rotate([90,0,0])
        Mscrew(b=1);
        translate([-23.5,-12,-14])
        rotate([90,0,0])
        Mscrew(b=1);
        
        // fan screws
        translate([16,-35,17])
        rotate([90,0,0])
        Mscrew(40);
        translate([-16,-35,17])
        rotate([90,0,0])
        Mscrew(40);

        translate([16,-35,-15])
        rotate([90,0,0])
        Mscrew(40);
        translate([-16,-35,-15])
        rotate([90,0,0])
        Mscrew(40);
        
        // fan nuts
        translate([16,9,17])
        rotate([90,0,0])
        Mnut();
        translate([-16,9,17])
        rotate([90,0,0])
        Mnut();

        translate([16,9,-15])
        rotate([90,0,0])
        Mnut();
        translate([-16,9,-15])
        rotate([90,0,0])
        Mnut();
        
    }
}    

