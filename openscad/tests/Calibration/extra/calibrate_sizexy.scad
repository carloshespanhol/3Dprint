// Calibration object for delta sizing
//
// Generate STL using OpenSCAD:
//   openscad calibrate_size.scad -o calibrate_size.stl
$fn=200;

base_radius = 50;
base_height = 1.5;
base_width = 10
;
cylinder_height = 3;
cylinder_radius = 6;
cylinder_outer_dist = 44.5;
ridge_cut_radius = .5;

text_height = 1;
text_size = 7;
spoke_angles = [0, 45, 90, 135, 180, 225, 270, 315];
CUT=0.01;

// Circular ring around entire object (to help reduce warping)
module base_ring() {
    difference() {
        cylinder(h=base_height, r=base_radius);
        translate([0, 0, -CUT])
            cylinder(h=base_height + 2*CUT, r=base_radius-base_width);
    }
}

// The base ring plus the base spokes
module base() {
    base_ring();
    // Spokes
    for (angle=[0,90,180,270])
        rotate([0, 0, angle])
            translate([-base_width/2, -CUT, 0])
                cube([base_width, base_radius-base_width+2*CUT, base_height]);
}

// Cylinder that measurement ridges are cut out of
module measuring_cylinder() {
    cut_width = cylinder_radius;
    difference() {
        cylinder(h=cylinder_height+CUT, r=cylinder_radius, $fn=60);
        for (angle=spoke_angles)
            rotate([0, 0, angle])
                translate([-cut_width, cylinder_radius - ridge_cut_radius, -CUT])
                    cube([2*cut_width, cut_width, cylinder_height+3*CUT]);
    }
}

// All the measuring cylinders around the ring
module measuring_cylinders() {
    measuring_cylinder();
    for (angle=spoke_angles)
        rotate([0, 0, angle])
            translate([0, cylinder_outer_dist, 0])
                measuring_cylinder();
}

// Text writing
module write_text(angle, dist, msg) {
    text_offset = dist + 1 - text_size/2;
    rotate([0, 0, angle])
        translate([0, text_offset, base_height - CUT])
            linear_extrude(height=text_height + CUT)
                text(msg, size=text_size, halign="center");
}

// Final object with text descriptions
module calibration_object() {
    base();
    translate([0, 0, base_height-CUT])
        measuring_cylinders();
    write_text(90, cylinder_outer_dist - 20, "X");
    write_text(0, cylinder_outer_dist - 20, "Y");
}

calibration_object();
