include <config.scad>
use <parts.scad>
use <linear_bearing.scad>
use <../lib.scad>
use <../timing_belts.scad>
$fs=0.2;
$fn=200;

t=thick;
tm=thick_min+.5;
w=car_width;
bt=belt_thick;
bs=belt_size;
bd=belt_distance;
//bw=bush_width;
eh=14; //extruder height

m2=2.5;

//Belt Support Height
bsh =belt_distance+belt_size*2+thick+1.2;  
// Belt Support Width
bsw =10;           
mw=23.5;
ts=1.5;

reccess=1.5;
ba=36; // bush angle
s=10;
lh=0.2;


print=0;

/*----------------------------------*/
// distance from nozle
//#translate([30,-3,-50]) scube(1,3,80);

if(print == 1){
    *adxl();
    *fan_support();
    *mirror([1,0,0])
    fan_duct();
    *klicky();
    *5020_fan(fd);
    //translate([0,0,12.5]) rotate([0,-90,45]) 
    *front_face();
    *back_face();
    *top_mgn9();
    
    //translate([0,-tbd/2-31,18.7])    
    //rotate([90+75,0,-90])
    *v6_face_4020();

    /* Hotend *
   translate([0,-tbd/2-18,64.9-hotend_height])
        hotend_e3d(1);
    /**/
}else{
    eva_xcarriage();
    carriage_parts();
    *HX_extruder();

    fan_support();
    
    *translate([-fd/2+(fd-45)/2,7,-45.3+7.5+1])
    klicky();
    translate([-fd/2+(fd-45)/2, 18.5, -35])
    adxl();
    
    *rotate([0,0,0]){
        fan_duct();    
        %5020_fan(fd);
    }

    mirror([1,0,0])
    rotate([0,3,0]){
        #fan_duct();    
        %5020_fan(fd);
    }  
    *belts_vz(60,60);
    *gantry();
}

//#translate([-40,-50,-21-24]) cube([80,100,.3]);

fd=75;
module template(){
    difference(){
        union(){
        }
        //-------------------------
    }
}
//=========================================================
module fan_duct(){
    t=1.8;
    // Suporte
    //support(x,y,z,lineWidth=0.4,m=0,c=0)
    translate([-51.5, -39.9, -31+.32])
    rotate([0,0,-20])
    support(6,t,4-.32*2, 0.7);            
   
    translate([-fd/2-4,-41,-39])
    rotate([0,0,-30])
    {
        // Duct
        difference(){
            union(){
                // top                
                translate([0,-2.5,-2])
                rotate([0,0,20])
                cube([10,29.5,25]);                
             
                // front
                translate([-30,-8.9,t])
                rotate([0,0,12])
                hull(){
                    translate([5,0,0])
                    cube([26,t,16]);
                    translate([0,0,3.5])
                    cube([31,t,16-3.5]);
                }
                // fix
                translate([-30,-10.6,2+3])
                cylinder(d=7, h=16-3);

                // Duct
                hull(){
                    translate([9.2,.8,-2])
                    rotate([0,0,20])
                    cube([.3,29.5,24+1]);
                   
                    translate([27,11,-2])
                    rotate([0,0,20])
                    cube([.1,21,4.2+1]);
                }
            }
            //-------------------------
            // Duct
            translate([-.7,-.8,0])
            rotate([0,0,20])
            cube([9.8,25.5,21]);
           
            hull(){
                translate([8.5,2.3,0])
                rotate([0,0,20])
                cube([.1,25.7,20]);
               
                translate([26.5,12.5,-2])
                rotate([0,0,20])
                cube([.1,18,1.81]);
            }
            hull(){
                translate([19,8.3,-2.1])
                rotate([0,0,20])
                cube([.1,21.1,2]);
                translate([26.5,12.5,-2.1])
                rotate([0,0,20])
                cube([.2,18,2]);
            }
           
            // air in
            translate([-26,30,-4])
            cylinder(d=46.2, h=30);
            // screw
            translate([-45.1,3.5,19])
            cylinder(d=4.5, h=4);
            translate([-30,-10.6,1])
            cylinder(d=4, h=20);
            // slot
            *translate([-10.1,-3,8])
            cube([7,t*2,4]);            
        }
    }
}

module eva_xcarriage(){
    /* V6 face */
    *translate([0,-tbd/2-17,.6])
    //rotate([90,0,180])
    v6_face_4020();
    
    *color("grey")
    translate([-36.8,48.7,-33.9])
    rotate([90,0,0])
    import("stl/sunon4020.stl");
    
    translate([0,0,-1]){

    /* front face */
    color("lime")
    translate([0,-tbd/2,8.5])
    rotate([90,0,0])        
    front_face();

    /* V6 clamp */
    color("lime")
    translate([0,-tbd/2-8,18.7])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/v6_face_clamp.stl");

    /* V6 support */
    translate([0,-tbd/2-52,-53.4])
    rotate([0,180,180])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/v6_support.stl");

    /* top */
    color("grey")
    translate([0,0,24]) 
    top_mgn9();
    
    // bottom
    color("grey")
    translate([0,17.6,-38.75])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/bottom_mgn12_short_duct.stl");

    /* back face */
    *color("lime")
    translate([-22.5,tbd/2,-43.4])
    rotate([-90,0,0])
    back_face();
    
    /* endstop */
    *color("lime")
    translate([-8,(tbd-10)/2 + 7,24.1])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/X_endstop_mount_VZboT.stl");
    }
}
module adxl(){
    x=45;
    t=5;
    r=4;
    difference(){
        union(){
            vrcube(8,t,15,r);
            hull(){
                vrcube(8,t,15,r);
                translate([0,t,12])
                vrcube(8,.1,5,r);
            }
            hull(){
                translate([37,0,0])
                vrcube(8,t,15,r);
                translate([37,t,12])
                vrcube(8,.1,5,r);
            }
            xl=58;
            translate([(x-xl)/2,5,14])
            vrcube(xl,5,16,3);   
   
            translate([8,5,14])
            rotate([-90,90,0])
            fillet(5,8);
            translate([x,5,14])
            rotate([-90,90,0])
            fillet(5,8);
        }
        //-------------------------
        *translate([(x-7.5)/2,-18+3.7,-.1])
        rcube(7.5,11,15,r);
        *translate([(x-11.5)/2,-18.1,t])
        rcube(11.5,11+3.8,15,r);
        
        translate([5,-t+1.5,4.5])
        rotate([90,30,0])
        Mnut(0);
        translate([x-5,-t+1.5,4.5])
        rotate([90,30,0])
        Mnut(0);

        xd=47.5;
        translate([8,8.1,13])
        vrcube(29,2,18,.5);
        // Nuts
        translate([-1,5+2,22])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut(0);
        translate([xd-1,5+2,22])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut(0);        
    }
}
module v6_face_4020(){
    w=40;
    //color("brown")
    difference(){
        union(){
            hull(){
                translate([-w/2,-14,-19])
                vrcube(w,.5,40,4);

                translate([-w/2,-9.25,-19])
                vrcube(w,3.5,40,3);
            }
            hull(){
                translate([-w/2,-14,10])
                vrcube(w,.5,11,4);
                // clamp
                translate([-w/2,-1.2,10])
                vrcube(w,.1,14,2); 
            }
            translate([-w/2+6,-6,-11.9])
            vrcube(w-12,5,25,1);            
        }
       
        //----------------------------------
        // hotend
        translate([0,-1,-8.7])
        hotend_e3d();
       
        // vent
        x=22;
        z=30;
        hull(){
            translate([-x/2,-5,-z/2-4])
            vrcube(x,5,z,5);
           
            translate([0,-15,0])
            rotate([90,0,0])
            cylinder(d=32, h=.1);
        }

        // clamp screws
        translate([11,-10,17.5])
        rotate([90,0,0])
        Mscrew(l=30,b=1);
        translate([-11,-10,17.5])
        rotate([90,0,0])
        Mscrew(l=30,b=1);
       
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
        translate([16,8,17])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut();
        translate([-16,8,17])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut();      
    }
}    
module v6_face_3010(){
    t=2;
    difference(){
        union(){
            // adxl
            xl=52;
            translate([-xl/2,-5,0])
            rcube(xl,16,5,8);

            hull(){
                translate([-20.5,-35.9,0])
                rcube(41,7,t,2.5);
               
                translate([-15,0,t/2])
                rotate([0,90,0])
                cylinder(d=t, h=30);
            }
           
            hull(){
                translate([-15,-6.8,5])
                rcube(30,13.9,8,5);

                translate([-16,-7,0])
                rcube(32,1,t);
               
                translate([-15.5,0,3])
                rotate([0,90,0])
                cylinder(d=6, h=31);
            }
           
            translate([-20.5,-36.25,0])
            rcube(41,8,8.2,2.5);

            translate([-14,-29,0])
            rcube(28,26,13,2.5);
           
        }
       
        //--------------------------
        //adxl
        translate([-30.5, 7.1,-.1])
        rcube(60,16.5,20,2);
        translate([16.3, 11.5,-.1])
        cylinder(d=11, h=20);

        translate([-14.5,-5,-.1])
        rcube(29,16.5,3,2);
        translate([-23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
        translate([23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
       
        translate([0,-25.8,11+2])
        rotate([-90,0,0])
        hotend_e3d();
       
        // vent
        x=22.3;
        hull(){
            translate([0,-21,-.1])
            cylinder(d=26,h=1);
           
            translate([-x/2,-35,10])
            rcube(x,28,.1,1);
        }
        translate([-x/2,-35,10])
        rcube(x,28,4,1);

        // Fan screws
        translate([0,-12+3.5,0]){
            translate([-12,-24,-.1])
            cylinder(d=2,h=6);
            translate([12,-24,-.1])
            cylinder(d=2,h=6);

            translate([-12,0,-.1])
            cylinder(d=2.5,h=5);
            translate([12,0,-.1])
            cylinder(d=2.5,h=5);
        }
        // Clamp screws
        translate([-10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        // Support screws
        translate([-16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
    }
}

module klicky(){
    x=45;
    t=5;
    r=1;
    difference(){
        union(){
            rotate([90,0,0])
            rcube(x,14,t,r);
            translate([(x-18)/2,-18,0])
            hull(){
                translate([0,18-t,0])
                cube([18,t,14]);
                rcube(18,18,t,r);
            }
        }
        //-------------------------
        translate([(x-7.5)/2,-18+3.7,-.1])
        rcube(7.5,11,15,r);
        translate([(x-11.5)/2,-18.1,t])
        rcube(11.5,11+3.8,15,r);
        
        translate([5,-t+1.5,6.4])
        rotate([90,30,0])
        Mnut(0);
        translate([x-5,-t+1.5,6.4])
        rotate([90,30,0])
        Mnut(0);
    }
}

module fan_support(){
    i=3;    //inclination
    difference(){
        union(){
            translate([-fd/2,7,-45.3+7.5])
            cube([fd,3.5,15]);

            translate([-fd/2, 6.5-8,-45.3+16-1.5])
            cube([12.5,12,14]);
            
            mirror([1,0,0])
            translate([-fd/2, 6.5-8,-45.3+16-1.5])
            cube([12.5,12,14]);
        }
        //--------------------------
        // left
        translate([-17.5, 9, -30.4])
        rotate([90,0,0])
        Mnut(b=0);
        
        translate([0,0,-2])
        rotate([0,i,0]){
            5020_fan(fd);
            //cut
            translate([-fd/2-8, 6.5-12,-45.3+13])
            cube([11.8,12,13.3]);
            translate([-fd/2+5.75, 4.9, -40.5])
            cylinder(d=7.6, h=21.6);
            // screw
            translate([-fd/2+5.8,4.9,-45])
            cylinder(d=4.5, h=30);
        }
               
        // right
        mirror([1,0,0]){
            translate([-17.5, 9, -30.4])
            rotate([90,0,0])
            Mnut(b=0);
            
            translate([0,0,-2])
            rotate([0,i,0]){
                5020_fan(fd);
                //cut
                translate([-fd/2-8, 6.5-12,-45.3+13])
                cube([11.8,12,13.3]);
                translate([-fd/2+5.75, 4.9, -40.5])
                cylinder(d=7.6, h=21.6);
                // screw
                translate([-fd/2+5.8,4.9,-45])
                cylinder(d=4.5, h=30);
            }
        }
    }
}

module 5020_fan(fd=70){   
    //color("grey")
    translate([-fd/2-4,-41,-39])
    rotate([0,0,-20])
    {
        rotate([0,-90,0])
        rotate([0,0,90])
        translate([-23.5,0,-35.5])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/50x20blower.stl");
        
        translate([-6.5,46.5,-1])
        rotate([180,0,0])
        Mscrew(l=28,d=4,hh=2, he=false);
    }
}


/*=======================================*/
module front_face(){
    // Sacrifice Bridge
    translate([-10,18,2.3])
    cube([20,5,.3]);

    difference(){
        union(){
            rotate([-90,0,0])
            import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/universal_face.stl");
            
            translate([-7,-10,0])
            cube([1.6,11,5]);
            translate([5.5,-16,0])
            cube([1.6,11,5]);
        }
        
        //---------------------------------
        if(print==1){
            // tie holes
            translate([-17,1.5,-1])
            cube([3.5,2,10]);
            translate([-17,-9,-1])
            cube([3.5,2,10]);

            translate([13.5,-7.5,-1])
            cube([3.5,2,10]);
            translate([13.5,-18,-1])
            cube([3.5,2,10]);
            
            /* Corrections */
            translate([18.5,-2.8,-1])
            cylinder(d=3.5,h=3.3);
            
        }
    }
}    

module back_face(){
    d=4;
    
    translate([9.5,-45,d/2])
    hull(){
        rotate([-90,0,0])
        cylinder(d=d, h=10);
        
        translate([0,0,4.5-d])
        rotate([-90,0,0])
        cylinder(d=d, h=10);
    }
    translate([35.5,-45-9,d/2])
    hull(){
        rotate([-90,0,0])
        cylinder(d=d, h=10);
        
        translate([0,0,4.5-d])
        rotate([-90,0,0])
        cylinder(d=d, h=10);
    }

    difference(){
        union(){
            translate([-3.5,-52,70])
            rotate([90,0,0])
            translate([25.9,-65,0])
            import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/Back plate without tensioner EVA 2.4.stl");    

            translate([0.5,-48,0])
            rcube(16.5,13.5,5,2);

            translate([28.2,-45-10.8,0])
            rcube(16.2,12.5,5,2);
        }
        //------------------------------
        if(print==1)
        {
        translate([4+27,-44.5-9,-1])
        rcube(10,8.5,10,1);
        translate([39,-44.5-9,4.5])
        scube(7,8.5,1);
        
        translate([4,-44.5,-1])
        rcube(10,8.5,30,1);
        translate([0,-44.5,4.5])
        scube(5,8.5,1);
        }
    }
}    
module top_mgn9(){
    difference(){
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/Top-MGN9-HextrudORT.stl");
        
        if(print==1){
            translate([-30,-tbd/2-10-2,-25])
            cube([60,10,80]);
        }
    }
}    
module gantry(){
    // Idlers    
    translate([-50.25,-25.25,-8.6]){
    translate([0,0,9.1])
    gt2_idler(b=5);

    translate([0,50.25,0])
    gt2_idler(b=5);
    }
    // Y-Gantry
    translate([160,-45,-44.8]){
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Top.stl");
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Bottom.stl");
    }
    /* tube */
    color("grey") 
    translate([-65,-10,-10]) 
    cube([100,20,20]);

    // carriage 
    color("silver")
    translate([0,0,10]) 
    rotate([90,0,-90])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/mgn9h.stl");
    /**/
}    
module belts_vz(dy=40,dx=40){   
    bt=belt_thick;
    
    /**
    translate([-10,33,-8.1])
    rotate([90,180,0])
import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/tension_slider_6mm_belt_M3s.stl");

    /* Y Belt *
    color("black")
    translate([20+16,0,0])
    rotate([0,0,90])
    union(){
        translate([-dy-2,-5,belt_distance/2 ])
        cube([dy*2+10,2,6]);        

        //
        translate([-dy-2,-16.5,belt_distance/2 ])
        cube([dy-10,2,6]);        

        translate([12,-16.5,-belt_size-belt_distance/2 ])
        cube([dy,2,6]);        
        
        // Stepper belt 
        *translate([dy+2.6,-16.5,belt_distance/2 ])
        cube([53,2,6]);        
    }

    /* X Belt */
    color("black")
    translate([-dx,-19.5,0.2])
    union(){
        // Left
        translate([0,0,belt_distance/2])
        cube([dx,bt,6]);
        
        translate([0,37.4,-belt_size-belt_distance/2])
        cube([dx,bt,6]);

        // Right
        translate([dx,37.4,belt_distance/2])
        cube([dx,bt,6]);
        
        translate([dx,0,-belt_size-belt_distance/2])
        cube([dx,bt,6]);
    }

    /* Back Belt *
    color("black")
    translate([-dx,dy,0])
    union(){
        translate([0,0,belt_distance/2])
        cube([dx*2,2,6]);
        
        translate([0,0,-belt_size-belt_distance/2])
        cube([dx*2,2,6]);
    }
    /**/
}

module bottom(){
    //color("grey")
    translate([0,17.6,-38.75])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/bottom_mgn12_short_duct.stl");
}
    

   
module duct_eva_volcano(){
    color("grey")
    translate([0,10.5,-27.9])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/TriHorn Duct UHF.stl");
}

module plate(){
    w=44;
    t=5;
    h=57;
    
    // left
    translate([-w/2,13,3])
    belt_clamp();
    // right
    translate([w/2,13,-10])
    mirror([1,0,0])
    belt_clamp();
       
    translate([0,13,0])
    difference(){
        union(){
            translate([-22,0,-19.9])
            vrcube(w,t,h,2);
            
        }
        
        translate([1,1.5,-belt_distance/2-belt_size])
        cube([w+10,t+1, 13]);
        
        translate([-w/2-5,1.5,belt_distance/2])
        cube([w/2+4,t+1,13]);
        
        // lower holes
        translate([-w/2+9, -.1, -15.9])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
        translate([w/2-9, -.1, -15.9])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
        // higher holes
        translate([-w/2+5, -.1, 32.1])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
        translate([w/2-5, -.1, 32.1])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
    }
}    
module HX_extruder(){
    color("silver")
    // nema 14 
    translate([0,-1,56])
    rotate([0,-9,0])
    nema14();

    color("lime")
    translate([-.6,0,0]){
        
        translate([0,-22.5,54])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_BACKPLATE.stl");
            
        translate([0,-22.5,54])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_BODY_NOVA NEW.stl");

        translate([0,-22.6,54])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_COVER.stl");

        translate([.1,-22.5,55.5])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_TENSION_ARM.stl");
    }
} 
module carriage_parts(){
    translate([0,0,-1]){
        /* Hotend */
        translate([0,-tbd/2-18,64.9-hotend_height])
        hotend_e3d(1);
        
        /* Blower */
        *translate([-8,27,-11])
        rotate([-25,0,-90])
        blower();
    }
}
module hotend_e3d(detail=0){
    translate([0,0,-37.1])
    rotate([0,0,180])
    e3d(detail,1.5);

    translate([0,0,-36.75])
    rotate([0,0,180])
    e3d(detail,1.5);
    
    *translate([0,0,35])
    rotate([0,180,0])    
    e3d_volcano();
}
module v6_face(){
    t=2;
    difference(){
        union(){ 
            // adxl
            xl=52;
            translate([-xl/2,4,0])
            rcube(xl,16,5,8);

            *hull(){
                translate([-20.5,-35.9,0])
                rcube(41,7,t,2.5);
                
                translate([-15,0,t/2])
                rotate([0,90,0])
                cylinder(d=t, h=30);
            }
            
            hull(){
                translate([-15,-6.8,5])
                rcube(30,13.9,8,5);

                translate([-16,-7,0])
                rcube(32,1,t);
                
                *translate([-15.5,0,3])
                rotate([0,90,0])
                cylinder(d=6, h=31);
            }
            
            *translate([-20.5,-36.25,0])
            rcube(8.2,41,8,2.5);
            *translate([12,-36.25,0])
            rcube(8.2,41,8,2.5);

            translate([-20.5,-36.25,0])
            rcube(41, 43, 5,2.5);
            translate([-20.5,-36.25,0])
            rcube(41, 8,8.2,2.5);

            translate([-14,-29,0])
            rcube(28,26,13,2.5);
            
        }
        
        //--------------------------
        //adxl
        *translate([-30.5, 7.1,-.1])
        rcube(60,16.5,20,2);
        translate([16.3, 11.5,6])
        sphere(d=11);

        translate([-14.5,4,-.1])
        rcube(29,16.5,2,2);
        translate([-23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
        translate([23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
        
        translate([0,-25.8,11+2])
        rotate([-90,0,0])
        hotend_e3d();
        
        // vent
        x=22.3;
        hull(){
            translate([0,-16,-.1])
            cylinder(d=37,h=1);
            
            #translate([-x/2,-35,11])
            rcube(x,28,.1,1);
        }
        translate([-x/2,-35,10])
        rcube(x,28,4,1);

        // Fan screws
        *translate([0,-12+3.5,0]){
            translate([-12,-24,-.1])
            cylinder(d=2,h=6);
            translate([12,-24,-.1])
            cylinder(d=2,h=6);

            translate([-12,0,-.1])
            cylinder(d=2.5,h=5);
            translate([12,0,-.1])
            cylinder(d=2.5,h=5);
        }
        // Clamp screws 
        translate([-10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        
        // Support screws 
        translate([-16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
        
        translate([-16,0,-1])
        rotate([0,180,0])
        Mscrew();
        translate([16,0,-1])
        rotate([0,180,0])
        Mscrew();
    }
}


module nema14(){    
    t=3;
    rotate([90,0,0]){
        cylinder(d=37.5, h=17.5);
        
        rotate([0,0,-38])
        translate([0,0,17.5-t])
        difference(){
            hull(){
                translate([-21.9,0,0])
                cylinder(d=7.5, h=t);
                translate([21.9,0,0])
                cylinder(d=7.5, h=t);
                
                cylinder(d=25, h=t);
            }
            //----------------------
            translate([-21.9,0,-1])
            cylinder(d=2, h=10);
            translate([21.9,0,-1])
            cylinder(d=2, h=10);
        }
    }
    /**/
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
/////////////////////
module top(){
    *translate([34.05,9.5+4,14])
    rotate([0,-90,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/top_mgn12.stl");
    
    *color("silver")
    translate([0,13.5,14-10]) 
    rotate([90,0,-90])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/mgn9h.stl"); 
 
    y=10;
    z=20.9+6;

    color("grey")
    translate([-tbw/2,-tbd/2,24.05])
    difference(){
        union(){
            scube(tbw,tbd,13);

        }

        //-----------------------------------
        *translate([-5,-10,11])
        cube([50,50,30]);
        // screw access
        translate([0,0,0]){
            translate([-1,(tbd-10)/2,-.1])
            scube(tbw+2, 10, 5 +.1);
           
            hull(){
                translate([tbw/3,tbd/2, 8])
                cylinder(d=5.6,h=6.1);

                translate([tbw/3*2,tbd/2, 8])
                cylinder(d=5.6,h=6.1);
            }
            hull(){
                translate([tbw/3,tbd/2, 0])
                cylinder(d=3,h=10);

                translate([tbw/3*2,tbd/2, 0])
                cylinder(d=3,h=10);
            }
        }
    
        // screws
        translate([4.95,-10, 8])
        rotate([-90,0,0])
        cylinder(d=3.25,h=50);

        translate([tbw-4.95,-10, 8])
        rotate([-90,0,0])
        cylinder(d=3.25,h=50);
                
        // MGN9
        translate([12,6, -5])
        mgn_screw();
        translate([29.5,6, -5])
        mgn_screw();
        translate([12,21, -5])
        mgn_screw();
        translate([29.5,21, -5])
        mgn_screw();
    }
}    
module mgn_screw(){
    hull(){
        cylinder(d=3.25,h=30);

        translate([2.5,0,0])
        cylinder(d=3.25,h=30);
    }    
    translate([0,0,15])
    hull(){
        cylinder(d=5.6,h=30);

        translate([2.5,0,0])
        cylinder(d=5.6,h=30);
    }    
}    