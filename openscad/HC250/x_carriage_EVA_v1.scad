include <config.scad>
use <parts.scad>
use <linear_bearing.scad>
use <../lib.scad>
use <../timing_belts.scad>
$fs=0.2;
$fn=100;

t=thick;
tm=thick_min+.5;
w=car_width;
bt=belt_thick;
bs=belt_size;
bd=belt_distance;
bw=bush_width;
eh=14; //extruder height

print=0;


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



/*----------------------------------*/
// distance from nozle
//#translate([30,-3,-50]) scube(1,3,80);

if(print == 1){
    //translate([0,0,12.5]) rotate([0,-90,45]) 
    *eva_xcarriage();
    
    // Bottom
    difference(){
        translate([0,0, tbw/2]) 
        rotate([0,-90,0]) 
        bottom();
        
        translate([0, tbd/2, -.1]) bushing(tbw+.2);
        
        *translate([-10,-10,10])
        cube([50,50,50]);
    }
  
    *rotate([-90,0,0]) extruder_support();
    
    //rotate([0,-90,0]) 
    *top();
    
    *rotate([-90,0,0]) duct();
  
}else{
    *xcarriage();
    eva_xcarriage();
          
    *duct_eva_volcano();
       
    HX_extruder();
    
    belts(60,60);
    
}
/*=======================================*/
module top(){
    color("grey")
    translate([34.05,9.5+4,14])
    rotate([0,-90,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/top_mgn12.stl");
    
}    
module bottom(){
    color("grey")
    translate([0,27.1+4,-38.75])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/bottom_mgn12_short_duct.stl");
}
    

module bush(l){
    color("lime"){
        rotate([0, 90, 0])
        difference(){
            cylinder(d=15.01, h=l);
            
            translate([0,0,-.1])
            cylinder(d=8, h=l+1);
        }
    }
}    
module duct_eva_volcano(){
    translate([0,tbd,-27])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/TriHorn Duct UHF.stl");


    *translate([14.9,tbd,-29.9])
    import("/home/hespanhol/3D Print/openscad/HC230/EVA_stl/[Duct] v2 Volcano Configurable - Duct v2 Volcano Straight Risen.stl");
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
    translate([0,5,0]){
    /* nema 14 */
    color("silver")
    translate([-.5,7.6,57.5])
    rotate([0,-9,0])
    nema14();

    color("green")
    translate([0,-33.5,-20])
    rotate([90,0,0])    
    import("/home/hespanhol/3D Print/openscad/HC230/HX_EVA/HX-EVA_Extruder_Face_V6-Dragon.stl");

    translate([0,-23,25])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/HX_EVA/HX-EVA_Backplate.stl");

    translate([0,-23,25])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/HX_EVA/HX_Body.stl");
    }
} 
module duct(){
    t=4.5;
    
    translate([15,18+6,-30])
    difference(){
        union(){
            translate([-27,-6-t,-3.9])
            vrcube(24,t,13.8, 2.5);

            hull(){
                translate([-27,-6-t,-3.9])
                vrcube(24,.1,13.8, 2.5);

                translate([-27-2,-25,-3.9])
                rotate([50,0,0])
                vrcube(24+4,.1,6, 1);
            }
            
            difference(){
                hull(){
                    translate([-30,-6-t,0.1])
                    rotate([-90,0,0])
                    cylinder(d=8, h=t);
                    translate([0,-6-t,0.1])
                    rotate([-90,0,0])
                    cylinder(d=8, h=t);
                }
                // Mnut
                translate([-30,-6-t+2,0.1])
                rotate([90,30,0])
                Mnut(b=0);

                translate([0,-6-t+2,0.1])
                rotate([90,30,0])
                Mnut(b=0);
            }

        }
        
        hull(){
            translate([-25,-6.1-t,-2.41])
            vrcube(20,t+1,10.6,1.5);
            
            translate([-25-2.75,-25.9,-4.1])
            rotate([50,0,0])
            vrcube(20+5.5,.1,4.5);
        }
        

        *translate([-40,-6,-10])
        cube([50,20,25]);
    }
}

module xcarriage(){
    translate([0,-9,18.8])
    import("EVA_stl/v6_face_clamp.stl");
    
    /* Hotend */
    translate([0,-18.9,64.9-hotend_height])
    hotend_e3d(1);
    
    /* Blower */
    translate([-8,49,-11])
    rotate([-25,0,-90])
    blower();
}


module top_rod(){
    y=10;
    z=20.9+6;

    color("grey")
    translate([-22,0,24.1])
    difference(){
        union(){
            // bushing support
            translate([0, 23+y, 26.9]) 
            rotate([0, 90, 0])
            difference(){
                cylinder(d=23, h=tbw);
                
                // cut bottom
                translate([15/2+1.7,-15/2-1,-.1])
                rotate([0,0,-5])
                scube(20,20,tbw+1);
            }

            scube(tbw,tbd,14);

            //reinforce left
            translate([0, 0, 13]) 
            scube(11,tbd,1);
            hull(){
                translate([0, tbd+y, z+1]) 
                rotate([0, 90, 0])
                cylinder(d=21, h=10);
                
                translate([0, 10, 14]) 
                scube(10,tbd-10,.1);
            }
            //reinforce right
            hull(){
                translate([tbw-10, tbd+y, z]) 
                rotate([0, 90, 0])
                cylinder(d=19, h=10);
                
                translate([tbw-10, 10, 14]) 
                scube(10,tbd-10,.1);
            }
        }

        //-----------------------------------------
        // cut top
        translate([-.1,20,35])
        rotate([11,0,0])
        scube(tbw+1,30,10);
        
        // cut back
        translate([-.1,23+y,15])
        scube(tbw+1,30,30);
        
        // bushing
        translate([2, 23+y, z]) 
        rotate([0, 90, 0])
        cylinder(d=15.1, h=tbw-4);

        translate([-.1, 23+y, z]) 
        rotate([0, 90, 0])
        cylinder(d=15-4, h=tbw+1);
              
        // screw access
        translate([0,3,0]){
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
                
    }
}
    
module eva_xcarriage(){
    color("lime")
    translate([0,tbd+5,8.6])
    import("EVA_stl/back_corexy.stl");
    
    top();
    bottom();
    
    /* endstop */
    color("lime")
    translate([-8,(tbd-10)/2 + 5+3,24.1])
    import("EVA_stl/top_endstop_openbuilds.stl");
}

module extruder_support(){
    t=5;
    t2=17;
    r=1;
    color("grey")
    difference(){
        difference(){
            union(){
                hull(){
                    vrcube(47,t,12.5+eh,r);
                    vrcube(20,t,41.5+eh,r);
                }
                translate([0,-t2+t,0])
                vrcube(47,t2,eh,r);
            }
            //-------------------
            translate([0,2,4])
            rotate([90,0,0]){
                translate([8,0,0])
                Mscrew(20);
                translate([42,0,0])
                Mscrew(20);
            }
            
            // cut
            translate([12,-5,35+eh])
            cube([20,15,20]);
            
            // extruder screws
            translate([5.25,18,36.5+eh])
            rotate([90,0,0])
            Mnut(b=0);
            translate([5.25,12+t-1,5.5+eh])
            rotate([90,0,0])
            Mnut(b=1);
            translate([36.25,12+t-1,5.5+eh])
            rotate([90,0,0])
            Mnut(b=1);
            
            translate([25,-4.5,-30.5])
            translate([-2.5,22-0.01,30.5+23+eh])
            nema14();
        }
        //------------------------
        translate([40,1,9.5+eh])
        rotate([90,0,0])
        cylinder(d=5, h=t);        
    }
}

module extruder(){
    
    /**/    
    color("grey")
    translate([-4.25,4.5,59])
    rotate([90,0,0])
    import("/home/hespanhol/OneDrive/openscad/HC235/stl/Bondtech BMG Extruder RH.stl");

    translate([0,-18,-50])
    cylinder(d=1, h=150);

    /* nema 14 */
    color("silver")
    translate([-2.5,22,38+23])
    nema14();
}    

module nema14(){    
    t=3.2;
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

module eva_xcarriage_orig(){
    
    /* belts inner distance
    #translate([-25,-10, -1.35])
    scube(50,60,2.6);
    /**/
    
    /**/
    color("lime"){
        translate([0,0,8.6])
        import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/universal_face.stl");
        
        translate([0,32,8.6])
        import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/back_corexy.stl");
    }
    
    color("grey"){
        /* Top */
        tbd=27; //top bottom depth
        tbw=44;
        translate([-22,0,24.1])
        difference(){
            scube(tbw,tbd,13);

            translate([-1,8.5,-.1])
            scube(tbw+2, 10, 5 +.1);
            
            hull(){
                translate([tbw/3,tbd/2, 8])
                cylinder(d=5.6,h=10);

                translate([tbw/3*2,tbd/2, 8])
                cylinder(d=5.6,h=10);
            }
            hull(){
                translate([tbw/3,tbd/2, 0])
                cylinder(d=3,h=20);

                translate([tbw/3*2,tbd/2, 0])
                cylinder(d=3,h=20);
            }
        }
/*
        translate([0,0,-15.8])
        import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/bottom_mgn12_short_duct.stl");
        /* Bottom */
        bh=8.2;
        translate([-22,0,-19.9])
        difference(){
            scube(tbw,tbd,bh);
            // left
            translate([-1, 4, 4])
            scube(2,4,3);
            translate([-.5, tbd-4-4, 4])
            scube(2,4,3);
            // right
            translate([tbw-1, 4, 4])
            scube(2,4,3);
            translate([tbw-1, tbd-4-4, 4])
            scube(2,4,3);
        }
    }
    
    /* belt grabber
    translate([0,0,8.6])
    import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/face_belt_grabber.stl");
    
    rotate([0,180,0])
    translate([0,0,8.6])
    import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/face_belt_grabber.stl");

    /* Tension slider M3 *
    translate([-12,42,-8.3])
    rotate([90,180,0])
    import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/tension_slider_6mm_belt_M3s.stl");
    /* M5 *
    translate([-12,42,-6.3])
    rotate([90,180,0])
    import("/home/hespanhol/Downloads/EVA stls/tension_slider_9mm_belt_M5.stl");
    /**/
    
    /* endstop */
    translate([-8,13.5,24.1])
    import("/home/hespanhol/Downloads/EVA stls/top_endstop_openbuilds.stl");
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

module bottom_rod(){
    bh=8.2;
    y=tbd/2;
    
    color("grey")
    translate([-22,0,-19.9])
    difference(){
        union(){
            scube(tbw,tbd,bh);

            hull(){
                translate([0, y, 19.9]) 
                rotate([0, 90, 0])
                cylinder(d=15, h=44);
                
                translate([0, 0, bh/2]) 
                scube(tbw, tbd,5);
            }
        }
        //-------------------------------
        // axis
        translate([-.1, y, 19.9]) 
        rotate([0, 90, 0])
        cylinder(d=8, h=50);
        
        /* tie hole *
        // left
        translate([-0, tbd/2-2, 0])
        rotate([-90,0,0])
        ring(7,4,4);
        // right
        translate([tbw, tbd/2-2, 0])
        rotate([-90,0,0])
        ring(7,4,4);
        
        /* belt tie */
        translate([tbw-5.5, -.1, -.1]) 
        scube(10,2,20);
        
        // screws
        translate([9,-10, 4])
        rotate([-90,0,0])
        cylinder(d=3.25,h=50);

        translate([tbw-9,-10, 4])
        rotate([-90,0,0])
        cylinder(d=3.25,h=50);

        // chamfer
        translate([0, -10, -12.3])
        rotate([0,-45,0])
        scube(10,50,20);

        translate([tbw, -10, -12.3])
        mirror([1,0,0])
        rotate([0,-45,0])
        scube(10,50,20);
    }
}
    
