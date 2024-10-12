include <config.scad>
use <../lib.scad>
use <endcap.scad>
use <Z_Carriage_v7.scad>
use <x_carriage_EVA_v3.scad>
$fn=200;
print=0;

// Inner cube
x=400;
y=320;
z=350;
t=20;
zs=440;

if(print==1){
    wiper_support();
    *y_endstop();
    *t_brace();
    *corner_frame();    
    // Motor Mount
    *mirror([1,0,0]) // left
    right_brace(); 
    *mirror([1,0,0]) // right
    MM_top(); 
    *mirror([1,0,0]) // right
    MM_middle();
    *MM_bottom();
    
    //Pulley
    *pulley_top();
    *pulley_bottom();
    
    *pulley_right_top();
    *pulley_right_bottom();
    
}else if(print==0){   

    translate([0,0,-t])
    framex();
    translate([0,-y-t*2-20,-t])
    color("silver") 
    translate([-t,0,z+t]) 
    cube([x+t*2,t,t]);

    translate([-t,0,-t])
    framey();
    translate([x,0,-t])
    framey();

    translate([x/2,0,0])
    zcarriage(z);

    // Pulley 
    translate([0,-t,0]){
        translate([0,-145-191.5,z+5])
        pulley_top();
        translate([0,-145-191.5,z+5])
        pulley_bottom();

        translate([x,-145-191.5,z+5])
        pulley_right_top();
        translate([x,-145-191.5,z-15])
        pulley_right_bottom();
    }
    
    // Motor Mount 
    translate([0,0,z-35])
    MM_top();
    translate([0,0,z-35])
    MM_middle();
    translate([0,0,z-36])
    MM_bottom();

    // Tensioner
    translate([x-245,0,z-35])
    right_brace();

    translate([245,-285,z-35])
    import("./stl/motor_mount_tension/top left rear fram brace for tensioner.stl");

    translate([245,-279,z+15])
    import("./stl/motor_mount_tension/knob.stl");


    translate([x-245,-285,z-35])
    import("./stl/Y-Right_MotorMount_Top.stl");
    translate([x-245,-285,z-35])
    import("./stl/Y-Right_MotorMount_Bottom.stl");

    ypos=115+210-2;//-14;
    /* Gantry */
    translate([65.2,-ypos-26,0])
    x_stop();

    translate([245,-ypos,z-35]){
    import("./stl/Y-Gantry_Top.stl");
    import("./stl/Y-Gantry_Bottom.stl");
    }

    translate([155,-ypos,z-35])
    mirror([1,0,0]){
    import("./stl/Y-Gantry_Top.stl");
    import("./stl/Y-Gantry_Bottom.stl");
    }  

    // X Carriage
    // pulley + belt diameter: 13.6
    // pulley + belt diameter: 14.4
    // belt width: 1.4


    // tube
    color("grey") 
    translate([20,-ypos+35,z]) 
    cube([360,t,t]);
    // rail
    color("silver") 
    translate([20+22+8,-ypos+40.5,z+20]) 
    cube([300,t-11,5]);

    // carriage 
    translate([70+10,-ypos+45,z+4.5]){        
        color("silver")
        translate([0,0,10]) 
        rotate([90,0,-90])
        import("./stl/mgn9h.stl");
        
        eva_xcarriage();        
        //xcarriage();
        *duct_eva_volcano();
        *HX_extruder();
        
        *color("silver")
        5020_fan();
        *color("silver")
        mirror([1,0,0])
        5020_fan();    
        
    }


    // Linear rail
    *color("silver") 
    translate([0,-y+30,z+2.5]) 
    cube([5,y-70,t-5]);
    echo(y-70); //250

    *color("silver")
    translate([0,-ypos+45,z+10]) 
    rotate([0,90,-90])
    import("./stl/mgn12h.stl");
}    
    
/*=====================================*/
module wiper_support(){
    bd=20;
    w=10;
    t=6;
    r=2;
    c=6;
    
    difference(){
        union(){
            translate([2,10-c/2,-4])
            rcube(10,c,4);

            rcube(w+20,20,t,r);
            
            translate([w,20,t])
            rotate([-90,0,0])
            fillet(5,t);
            
            rcube(w,bd+20,t,r);
        }
        //----------------------------------
        translate([w+10,10,5])
        Mscrew(d=5.2,b=1);

        translate([w/2,bd+20-8,-.1])
        cylinder(d=1,h=t+1);

    }
}
module y_stop(){
    y=9;
    x=12;
    t=6;
    r=2;
    rw=12;
    
    difference(){
        union(){
            //spacer
            cube([x/2,y,20+t]);
            rcube(x,y,20+t,r);
            
            // fixer
            translate([-20,-20+y,0])
            rcube(20+2,20,t+(20-rw)/2,r);

            translate([2,0,0])
            rotate([90,0,0])
            fillet(r,t+(20-rw)/2);
        }
        //-------------------------------------
        // frame cut
        translate([-21,-20,t])
        cube([21,40,21]);
        // screw
        translate([-10,-10+y,t-5])
        rotate([180,0,0])
        Mscrew(20,5.4,v=1);
    }
}
module y_endstop(){
    y=9;
    x=12;
    t=5;
    r=2;
    rw=12;
    
    mirror([1,0,0])
    difference(){
        union(){
            //spacer
            translate([0,0,t]){
                cube([x/2,y,20]);
                rcube(x,y,20,r);
            }
            translate([0,0,t]){
                rcube(t,20,t,r);
            }
            // fixer
            translate([-20,15,0])
            rcube(20+t,10,t*2,r);
            translate([0,-20+y,t])
            rcube(2,20,(20-rw)/2,1);
            
            translate([t,y,t])
            rotate([90,0,90])
            fillet(r,t);

            translate([t,y,t*2])
            rotate([0,0,90])
            fillet(r,t);
            
            translate([t,y,t*2])
            rotate([-90,-90,0])
            fillet_90(r);
        }
        //-------------------------------------
        // frame cut
        translate([-21,-20,t])
        cube([21,60,21]);
        // screw
        translate([-10,15+5,t-3])
        rotate([180,0,0])
        Mscrew(20,3.2,v=0,b=1);
    }
}
module corner_frame(){
  difference(){
        union(){
            corner(10,20,30,30);
            
            translate([-20,0,0])
            rcube(22,20,10,.2);
        }
        //----------------------
        translate([-10,10,5])
        Mscrew(20,5.4,v=1);
    }
}
module t_brace(){
    r=3;
    t=6;
    ts=5; // screw thickness
    difference(){
        union(){
            translate([10,10,4])
            mirror([0,0,1])
            endcap(r=3);
            
            rcube(80,20,t,r);
            translate([30,-30,0])
            rcube(20,40,t,r);
           
            translate([30,0,t])
            rotate([-90,0,180])
            fillet(30-r,t);
            translate([50,0,t])
            rotate([-90,0,-90])
            fillet(30-r,t);
        }    
        //--------------------------
        translate([10,10,ts])
        Mscrew(10,5,1);
        translate([40,10,ts])
        Mscrew(10,5,1);
        translate([70,10,ts])
        Mscrew(10,5,1);

        translate([40,-20,ts])
        Mscrew(10,5,1);
    }
}
module t_brace_old(){
    r=1;
    t=8;
    ts=5; // screw thickness
    difference(){
        union(){
            translate([10,10,4])
            mirror([0,0,1])
            endcap();
            rcube(60,20,t,r);
            translate([20,-20,0])
            rcube(20,40,t,r);
            
            translate([20,0,t])
            rotate([-90,0,180])
            fillet(20-r,t);
            translate([40,0,t])
            rotate([-90,0,-90])
            fillet(20-r,t);
        }    
        //--------------------------
        translate([10,10,ts])
        Mscrew(10,5,1);
        translate([30,10,ts])
        Mscrew(10,5,1);
        translate([50,10,ts])
        Mscrew(10,5,1);

        translate([30,-10,ts])
        Mscrew(10,5,1);
    }
}
module x_stop(){
    rotate([0,0,180])
    difference(){
        union(){
            translate([18,-76,z+24])
            rcube(23,10,5,2);
            difference(){
                translate([23.2-7.7,-76,z+24-3])
                rcube(8,10,8,1);
                
                translate([29,-77,z+24-3])
                rotate([0,-45,0])
                rcube(8,10+2,15,.1);

                translate([19,-77,z+20])
                rotate([0,45,0])
                rcube(8,10+2,15,.1);
            }
            translate([25+13.8,-76,z+24])
            vrcube(5,10,20-2-1,.5);
            
            translate([25+15.6+3.2,-76,z+24+2])
            rotate([0,0,90])
            vrcube(10,5,20-2-1,2);
            
            translate([25+14,-76,z+24+5])
            mirror([1,0,0])
            fillet(8,10);
        }
        //---------------------------
        translate([25+4.4,-76+5,z+24+3.5])
        Mscrew(d=3);
        translate([25+4.4+6.4,-76+5,z+24+3.5])
        Mscrew(d=3,l=3.6);

    }
}
module pulley_right_top(){
    difference(){
        translate([-245,191.5,-40])
        import("./stl/Pulley_Gantry_RightTop.stl");
        
        if(print==1){
            mirror([1,0,0]){
                translate([10,6.5,0]) 
                cylinder(d=5.5, h=30);
                translate([35,6.5,0]) 
                cylinder(d=5.5, h=30);

                translate([-10,34.5,0]) 
                cylinder(d=5.5, h=30);
            }
        }
    }
}
module pulley_right_bottom(){
    difference(){
        translate([-245,191.5,-20])
        import("./stl/Pulley_Gantry_RightBottom.stl");

        
        if(print==1){
            mirror([1,0,0]){
                translate([10,6.5,0]) 
                cylinder(d=5.5, h=30);
                translate([35,6.5,0]) 
                cylinder(d=5.5, h=30);
            }
        }
    }
}
module pulley_top(){
    difference(){
        translate([245,191.5,-40])
        import("./stl/Pulley_Gantry_LeftTop.stl");
        
        if(print==1){
            translate([10,6.5,0]) 
            cylinder(d=5.5, h=30);
            translate([35,6.5,0]) 
            cylinder(d=5.5, h=30);

            translate([-10,34.5,0]) 
            cylinder(d=5.5, h=30);        
        }
    }
}

module pulley_bottom(){
    difference(){
        translate([245,191.5,-40])
        import("./stl/Pulley_Gantry_LeftBottom.stl");
        
        if(print==1){
            translate([10,6.5,0]) 
            cylinder(d=5.5, h=30);
            translate([35,6.5,0]) 
            cylinder(d=5.5, h=30);
        }
    }
}

module MM_top(){
    difference(){
        translate([245,-285,0])
        import("./stl/motor_mount_tension/Left motor mount Top.stl");   
        
        if(print==1){
            translate([-10,-28.7,0]) 
            cylinder(d=5.5, h=70);

            translate([8,10,0]) 
            cylinder(d=5.5, h=70);
            translate([36,10,0]) 
            cylinder(d=5.5, h=70);
        }
    }
}
module MM_middle(){
    difference(){
        translate([245,-285,0])
        import("./stl/motor_mount_tension/Left motor mount middle.stl");   
        
        if(print==1){
            translate([-10,-28.7,0]) 
            cylinder(d=5.5, h=70);

            translate([5.7,10,0]) 
            cylinder(d=5.5, h=70);
            translate([36.7,10,0]) 
            cylinder(d=5.5, h=70);

            translate([48.35,10,0]) 
            cylinder(d=5.5, h=70);
        }
    }
}
module MM_bottom(){
    difference(){
        translate([245,-285,-30])
        import("./stl/motor_mount_tension/Left motor mount bottom2.stl");   
        
        *translate([48.35,2.5,0]) 
        cylinder(d=5.5, h=70);

        *translate([48.35,12.5,0]) 
        cylinder(d=5.5, h=70);
    }
}
module right_brace(){
    difference(){
        union(){
            translate([0,-285,0])
            rotate([0,180,0])
            import("./stl/motor_mount_tension/top right rear fram brace for tensioner.stl");
            
            translate([215,20,45])
            rotate([-90,0,0])
            cylinder(d=10,h=5);
            translate([235,20,45])
            rotate([-90,0,0])
            cylinder(d=10,h=5);
            
            translate([255,20,30])
            rotate([-90,0,0])
            cylinder(d=10,h=5);
            translate([255,20,15])
            rotate([-90,0,0])
            cylinder(d=10,h=5);
        }    
        
        translate([215,25,45])
        rotate([-90,0,0])
        Mscrew(d=5);
        translate([235,25,45])
        rotate([-90,0,0])
        Mscrew(d=5);
        
        translate([255,25,30])
        rotate([-90,0,0])
        Mscrew(d=5);
        translate([255,25,15])
        rotate([-90,0,0])
        Mscrew(d=5);
    }
    
}    
module framex(){
    color("silver") 
    translate([0,0,0]) 
    cube([x,t,t]);
    
    color("silver") 
    translate([-t,0,z+t]) 
    cube([x+t*2,t,t]);
}
module framey(){
    color("grey") 
    translate([0,-y-t,z-zs+t*2]) 
    cube([t,t,zs]);
    
    color("silver") 
    translate([0,0,z-zs+t*2]) 
    cube([t,t,zs]);
    
    color("silver") 
    translate([0,-y,0]) 
    cube([t,y,t]);
    
    color("silver") 
    translate([0,-y,z+t]) 
    cube([t,y,t]);   
}
