//color("grey") translate([152.8,77.5,0]) rotate([0,0,-90]) import("stl/cbd-3d_MOSFET_v1.3_model.stl");

use <../lib.scad>

$fn= 100;  // Circle resolution
thickness=4;
height=105;
width=155;
hinge_size=15;
fw=20;  // frame width

// Base
difference(){
    translate([-height/2,-width/2-fw,0])    
    rcube(height*1.6+fw,width+fw,thickness,5);
    
    // Frame screws
    #translate([-height/2+fw,-width/2-fw/2,0])    
    rotate([180,0,0]) Mscrew(10,5);  
    #translate([height*1.2-fw,-width/2-fw/2,0])    
    rotate([180,0,0]) Mscrew(10,5);  
    #translate([height/2-fw/2,-width/2-fw/2,0])    
    rotate([180,0,0]) Mscrew(10,5);  
    
    #translate([height*1.275-fw/2,width/2-fw*2,0])  
    rotate([180,0,0]) Mscrew(10,5);  
    #translate([height*1.275-fw/2,-width/2+fw,0])    
    rotate([180,0,0]) Mscrew(10,5);  
}
// Mount Screws
base_y=-width/2 + 5.8;
base_x= -height/2 + 11.4;
translate([base_x, base_y, thickness])
mount_screw();
translate([base_x, base_y+138.5, thickness])
mount_screw();
translate([base_x+87, base_y, thickness])
mount_screw();
translate([base_x+87, base_y+138.5, thickness])
mount_screw();

/* Mosfet Mount Base */
translate([95, 0, 0])
difference(){
    translate([-height/2,-width/2,0])    
    rcube(height/2+20,width,thickness,5);

    translate([27-height/2,6-width/2,-1])
    rcube(height/2-18,width-12,thickness+4,10);
}
/* Mosfet Mount Screws */
mosfet_mount_screw();
translate([0,-87,0]) mosfet_mount_screw();

/* Hinge */
translate([-height/2 + 2.6,0,0])
union(){
    translate([0, -width/2+hinge_size+10, thickness+3])
    difference(){
    hull(){    
        rotate([90,0,0]) cylinder(hinge_size,3.5,3.5);
        translate([-2,-hinge_size,-6]) cube([7,hinge_size,3.5]);
    }
    translate([0,5,0]) rotate([90,0,0]) Mscrew(30);
    }

    translate([0, width/2 - 10, thickness+3])
    difference(){
    hull(){
        rotate([90,0,0]) cylinder(hinge_size,3.5,3.5);
        translate([-2,-hinge_size,-6]) cube([7,hinge_size,3.5]);
    }    
    translate([0,5,0]) rotate([90,0,0]) Mscrew(30);
    }
    
    /*Screws
    color("silver") translate([0,-width/2,7]) rotate([-90,0,0]) Mscrew(30);    
    color("silver") translate([0,width/2,7]) rotate([90,0,0]) Mscrew(30);
    */
}

// Snap in
translate([height/2 - 20, -width/2+.5, thickness-.5])
rotate([0,90,0]) cylinder(10,2,2);

translate([height/2 - 20, width/2-0.5, thickness-.5])
rotate([0,90,0]) cylinder(10,2,2);


/***/
module mosfet_mount_screw(){
    translate([base_x+107, base_y+87, thickness])
    mount_screw();
    translate([base_x+149, base_y+87, thickness])
    mount_screw();
    translate([base_x+107, base_y+138.5, thickness])
    mount_screw();
    translate([base_x+149, base_y+138.5, thickness])
    mount_screw();
}

module mount_screw(){
    difference(){
    translate([0,0,0]) cylinder(5,3.5,3.5);
    translate([0,0,10]) rotate([180,0,0]) Mscrew(15);
    }
}
