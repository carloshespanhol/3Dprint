$fn = 200;
l=55;
w=20;
fontsize = 3.5;
linedist = 4.5;

function multiple(Size,Unit) = Unit * ceil(Size / Unit);

// Wall
translate([13,9,3])
cube([.8,10,2]);
translate([13+4,9,3])
cube([1.6,10,2]);
translate([13+8,9,3])
cube([1,10,2]);
translate([13+12,9,3])
cube([2,10,2]);

difference() {
    union(){
        for (a =[.2,.4,.6,.8]){
            translate([10,0,0])
            linear_extrude(height=a) {
                    minkowski() {
                        square([(l-18*a),w-2]);
                        circle(1);
                    }
             }
        }

        for (a =[1,2,3,4,5]){
            linear_extrude(height=a) {
                    minkowski() {
                        square([(l-4*a)-4,w-2]);
                        circle(1);
                    }
             }
        }
    }
    // Hole
    hull(){
        translate([4,4,3])
        cylinder(d=5,h=10);
        translate([4,14,3])
        cylinder(d=5,h=10);
    }
    // Wall
    translate([10,9,3])
    cube([20,7,5]);
    // Bridge
    translate([4,10,-.1])
    cube([16,5,2]);
    // Overhang
    translate([10,-4.5,0.5])
    rotate([-40,0,0])
    cube([10,8,5]);

/*
    translate([l-14,-4,-.1])
    rotate([0,0,180])
    mirror([0,1,0])
    linear_extrude(height=2) {
        translate([0,4*linedist]) text(make_text_box, size=fontsize);
        translate([0,3*linedist]) text(filament_text_box, size=fontsize);
        translate([0,2*linedist]) text(color_text_box, size=fontsize);
        translate([0,1*linedist]) text(str("T=", temp_text_box, " B=", bedtemp_text_box), size=fontsize);
    }
*/
}
