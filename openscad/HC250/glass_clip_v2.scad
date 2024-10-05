$fn=64;
thick=3;
h=4+thick;    // thickness of bed and glass
sensor=1;
//rotate([90,0,0]) middle();

//mirror()
//translate([0,10,0]) rotate([0,-90,90]) 
corner();

module corner(){
    l=30;
    w=50;
    difference(){
        cube([l,w,h]);

        // Superior Cut
        translate([5,5,thick]) cube([l+1,w+1,15]);
        
        // Slot
        translate([-0.1,-0.1,thick])
        difference(){
            cube([l+0.2,w+0.2,.4]);
            cube([l/2,w/2,1]);
        }
        
        // Screw Hole
        rotate([0,0,-30]){
        translate([2,35,0]){
            cube([4,20,11],center=true);
            translate([0,10,-10]){cylinder(d=4,h=15);}
            translate([0,-10,-10]){cylinder(d=4,h=15);}
            }
        }
        
        // Chanfer
        translate([50,43,0])
        rotate([0,0,45]){
            cube([l,80,11],center=true);
        }
    }

    translate([l-3,4.5,thick+2.2]){sphere(d=3.5);}
    translate([4.5,w-3,thick+2.2]){sphere(d=3.5);}
}

module middle(){
    difference(){
        cube([40,25,h]);

        // Superior Cut
        translate([-0.01,4,3]) cube([40.02,40,15]);
        
        // Slot
        translate([-0.1,-0.1,3+(thick/2)])
        difference(){
            cube([40.2,40.2,.5]);
            cube([15,15,1]);
        }
        
        // Screw Hole
        translate([20,11.5,0]){
            cube([3.5,10,11],center=true);
            translate([0,5,-5]){cylinder(d=3.5,h=11);}
            translate([0,-5,-5]){cylinder(d=3.5,h=11);}
            }
        
        
    }
    
    translate([37,3.5,3+thick+2]){sphere(d=4);}
}

