include <config.scad>
use <../lib.scad>
use <Z_Carriage_v7.scad>
use <x_carriage_EVA_v2.scad>
$fn=200;
print=1;

// Inner cube
x=400;
y=320;
z=350;
t=20;
zs=440;

if(print==1){
    t_brace();
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
    translate([0,-y-t*2,-t])
    color("silver") 
    translate([-t,0,z+t]) 
    cube([x+t*2,t,t]);

    translate([-t,0,-t])
    framey();
    translate([x,0,-t])
    framey();

    *translate([x/2,0,0])
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
    import("/home/hespanhol/3D Print/openscad/HC230/stl/motor_mount_tension/top left rear fram brace for tensioner.stl");

    translate([245,-279,z+15])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/motor_mount_tension/knob.stl");


    translate([x-245,-285,z-35])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Right_MotorMount_Top.stl");
    translate([x-245,-285,z-35])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Right_MotorMount_Bottom.stl");



ypos=115+210-2;//-14;
/* Gantry */
translate([65.2,-ypos-26,0])
x_stop();

translate([245,-ypos,z-35]){
import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Top.stl");
import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Bottom.stl");

}

translate([155,-ypos,z-35])
mirror([1,0,0]){
import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Top.stl");
import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Bottom.stl");
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
/* */


    // carriage 
    translate([70+10,-ypos+45,z+4.5]){        
        color("silver")
        translate([0,0,10]) 
        rotate([90,0,-90])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/mgn9h.stl");
        
        eva_xcarriage();        
        //xcarriage();
        *duct_eva_volcano();
        *HX_extruder();
        
        color("silver")
        5020_fan();
        color("silver")
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
    import("/home/hespanhol/3D Print/openscad/HC230/stl/mgn12h.stl");
}    
    
/*=====================================*/
module t_brace(){
    difference(){
        union(){
            rcube(60,20,5,2);
            translate([20,00,0])
            rcube(20,40,5,2);
        }    
        //--------------------------
        translate([10,10,-.1])
        Mscrew();
        translate([30,10,-.1])
        Mscrew();
        translate([50,10,-.1])
        Mscrew();

        translate([30,30,-.1])
        Mscrew();
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
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Pulley_Gantry_RightTop.stl");
        
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
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Pulley_Gantry_RightBottom.stl");

        
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
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Pulley_Gantry_LeftTop.stl");
        
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
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Pulley_Gantry_LeftBottom.stl");
        
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
        import("/home/hespanhol/3D Print/openscad/HC230/stl/motor_mount_tension/Left motor mount Top.stl");   
        
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
        import("/home/hespanhol/3D Print/openscad/HC230/stl/motor_mount_tension/Left motor mount middle.stl");   
        
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
        import("/home/hespanhol/3D Print/openscad/HC230/stl/motor_mount_tension/Left motor mount bottom2.stl");   
        
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
            import("/home/hespanhol/3D Print/openscad/HC230/stl/motor_mount_tension/top right rear fram brace for tensioner.stl");
            
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
