/*
 * 360 x 440 x 440/420  d w h
 */
use <../lib.scad>
include <config.scad>
include <parts.scad>

/*
use <x_carriage_v11.scad>
use <Z_Carriage_v7.scad>
use <idler_v4.scad>
use <xy_joiner_v6.scad>
use <2color_v2.scad>
//use <part_duct_v2.scad>
//use <hotend_v2.scad>
//use <zprobe_v4.scad>

/* Configuration */
$fs= 0.2;
main_color = "LightSkyBlue";
/*=======================*/
// References
//#translate([30-.3,0,0]) cube([.6,200,10]);
/**
translate([19.98, 110, -20]) 
%scube(.2, 50, 50);
//#translate([-8, 120, 0]) cube([43,5,5]);
/*****/
dy=80;//160; //160; //51;
dx=400;
ax=320; // x axis size
    ud = upper_distance;

/*
translate([28.8,dy+41,-14])
rotate([0,0,180])
stepper_support();
/**

//strong_idler(dy);

// Joiner
translate([41,0,0])
{
    xy_joiner();
    %pulley();
}


axis_y(dy);
belts(dy);
belt_path();

translate([78,0,0])
xcarriage();

/**
translate([148+72.5,dy,-90])
zcarriage();

//translate([72,9,0]) endstop();

/**
translate([32,-dy+15,-26])
#cube([1,53,52]);
translate([32,-dy,-37])
#cube([1,15+25,10]);

/**
translate([(dx-ax)/2-20,0,0])
axis_x(ax);
/**/
framey(dy);
//framex(dy);
translate([20,dy+20,ud-5]) b_drive();
translate([0,-dy,ud]) left_idler();
translate([0,dy,ud]) shaft_support();

/* STLs */

module shaft_support(){
translate([210,44-80,114-33.5])
rotate([90,180,0])
import("/home/hespanhol/OneDrive/openscad/Legacy/STLs/Gantry/AB Drive Units/y_shaft_rear_support_x2.stl");
}

module b_drive(){
    translate([-43,-100,30])
    rotate([0,180,-90])
    import("/home/hespanhol/OneDrive/openscad/Legacy/STLs/Gantry/AB Drive Units/b_drive_unit_upper.stl");

    translate([-43,104.7,0])
    rotate([0,0,-90])
    import("/home/hespanhol/OneDrive/openscad/Legacy/STLs/Gantry/AB Drive Units/b_drive_unit_lower.stl");
    
    translate([113,150,18.5])
    rotate([0,180,90])
    import("/home/hespanhol/OneDrive/openscad/Legacy/STLs/Gantry/AB Drive Units/[a]_belt_tensioner_x2.stl");
}

module left_idler(){
    translate([-93,103,20])
    rotate([0,0,-90])
    import("/home/hespanhol/OneDrive/openscad/Legacy/STLs/Gantry/Front Idlers/front_idler_left_upper.stl");
    translate([162,117,0])
    rotate([0,180,90])
    import("/home/hespanhol/OneDrive/openscad/Legacy/STLs/Gantry/Front Idlers/front_idler_left_lower.stl");

}    



/*
translate([165,6,24])
rotate([90,0,0])
jig();
/**/
module stepper_support(){
    t=5;
    t2=7.75;
    nw=nema17_width;
    o=5; // offset
    dist=3;
    h=25;
    
    difference(){
        union(){
            // top
            hull(){
                translate([-nw/2-t,-nw/2-o-dist,0])
                rcube(t, nw+o+dist, t, 2);
                translate([nw/2,-nw/2-o-dist,0])
                rcube(t, nw+o+dist, t, 2);
            }
            //left
            hull(){
                translate([-nw/2-t2,-nw/2-o-dist,0])
                rcube(t2, nw+o+dist, t, 2);
                translate([-nw/2-t2,nw/2-o,-h])
                scube(t2, o, h);
            }
            //right
            hull(){
                translate([nw/2,-nw/2-o-dist,0])
                rcube(t2, nw+o+dist, t, 2);
                translate([nw/2,nw/2-o,-h])
                scube(t2, o, h);
            }
            // offset
            hull(){
                translate([-nw/2-t2,nw/2-o,-h])
                scube(t2, o, h+o);
                translate([nw/2,nw/2-o,-h])
                scube(t2, o, h+o);
            }
            
            // support
            translate([9,nw/2-o,-20-h])
            scube(20, o, 43+h);
            hull(){
                translate([9,nw/2-o,-20-h])
                scube(20, o, 1);
                translate([-nw/2-t2,nw/2-o,-h])
                scube(nw, o, 1);
            }
        }
        //-----------------------------
        slot=18;
        translate([-slot/2,-nw+o,-2])
        scube(slot,nw/2+o+2,10);
        
        translate([0,-o-dist,0])
        nema17_holes();
    }
}    


/* Moving cart *
posf=-dy+30+4;//+40;  // front
posb= dy-49;     //back
ypos=posb;
echo(posb-posf);
translate([20,ypos,0])
{
    // Joiner 
    translate([5,10,0]){ 
        xy_joiner();
        pulley();
    }

    /* X Carriage 
    translate([90,0,1]){
        //#translate([-30, -2, -48.5+9]) cube([50,4,.5]);
        /*
        translate([0, -49, -48.5+9.5]) cube([1,.5,14]);
        translate([0, -39, -48.5+9.5]) cube([1,.5,30]);
    /*
        translate([-car_width/2-3.5, -axis_distance/2-20.5,-65.5]){
            zprobe_support();
            switch_support();
        }
        color(main_color) 
        X_Carriage();
        hotend();
        translate([0,0,0]){ 
           // translate([41.6,-39.5,-7.5])  blower();

            translate([0,0,-4.25]){  
                // E3d V6 
                translate([0,0,6])
                color("silver")
                translate([0,0,23]) 
                rotate([0,180,90])
                e3d_volcano();  
            }
        }
    }
    
}    
/**/
/*==========================*/
module axis_y(dy=160){    
    translate([20+axis_diam/2,-dy-20,-20]) 
    union(){
        /* Y Axis */
        color("silver") 
        rotate([0, 90, 90]) 
        cylinder(d=axis_diam, h=dy*2+40);
        
        /* Y Bushing */
        color("white") 
        translate([0,-ybush_len/2+dy+20,0]) 
        rotate([0, 90, 90]) 
        cylinder(d=bush_width, h=ybush_len);
        /**/
    }
}
    
module screws(){
    color("silver")
    union(){
        // Blower
        translate([10,-63.5,17]) 
        rotate([0,-90,0]) 
        Mscrew(30);
        
        // E3d Clamp
        translate([car_width/2-Mountingpoint_width/2+4,-r-26,hotend_height-17]) 
        rotate([-90,0,0]) 
        Mscrew(30);
        translate([car_width/2+Mountingpoint_width/2-4,-r-26,hotend_height-17]) 
        rotate([-90,0,0]) 
        Mscrew(30);
        
        // Mountpoint
                        
        /* Switch support *
        translate([-9.5,-r-1.5,axis_distance-4]) 
        rotate([-90,0,0]) 
        Mscrew(10,2.5);
        translate([-9.5,-r-1.5,axis_distance-14.5]) 
        rotate([-90,0,0]) 
        Mscrew(10,2.5);
        translate([-9.5,-4,axis_distance-4]) 
        rotate([-90,0,0]) 
        Mnut(2.5);
        translate([-9.5,-4,axis_distance-14.5]) 
        rotate([-90,0,0]) 
        Mnut(2.5);
        /**/
    }
}
