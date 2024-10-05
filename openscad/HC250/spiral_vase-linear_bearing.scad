cli=0.18;     // internal cleareance
clo=0.3;    // external cleareance

// outer diameter in mm
outerD=13.0;

// inner diameter in mm
innerD=8.0;

// this is used to trim the inner diameter (mm)
line_width = 0.6;
line_height= 0.32;

// height in mm
H=20;   //  y55 e x76

// number of spikes
N = 8;

// spike angle
spike_angle = 0;

// twist of blades in deg
blade_twist = 45;

//resolution
$fn  = 100;
/******************************************/
//#translate([.5,-outerD/2-.5,-H]) cube([.1,outerD/2,H*2]);

translate([0,0,H/2])
bushing();

module bushing() {
    /* base */
    translate([0,0,-H/2])
        cylinder (d1 = innerD+line_width*4+cli, d2 = innerD+line_width*2+cli, h = line_height*3, center = false); 
        // top
        translate([0,0,H/2-(line_height*3)])
        cylinder (d1 = innerD+line_width*2+cli, d2 = innerD+line_width*4+cli, h = line_height*3, center = false); 
        // middle
        hull(){
        translate([0,0,-H/6-(line_height*3)])
        cylinder (d1 = innerD+line_width*2+cli, d2 = innerD+line_width*4+cli, h = line_height*3, center = false); 
        translate([0,0,H/6])
        cylinder (d1 = innerD+line_width*4+cli, d2 = innerD+line_width*2+cli, h = line_height*3, center = false); 
    }
    
    /**/
    difference() {
        linear_extrude(height = H, center = true, convexity = 10, twist = blade_twist, slices = 100)
        projection() 
        difference() {
            cylinder (d = outerD-clo, h = H, center = true);
             
            for ( i = [0 : 360/N : 360] ) {
               rotate ([0,0,i]) spike();
            }
        }
    } // end diff
} 

module spike() {
    translate ([innerD/2+line_width+cli, 0, -H/2-5])
    rotate ([0,0,spike_angle]) {
        cylinder(d=1, h=H+10);
        translate([0,-.5,0])
        cube([2,1,H+10]);
    }
}

module spike_square() {
    difference() {
        translate ([outerD/2-2,0,0]) 
        rotate ([0,0,spike_angle]) 
        cube([7,1.1,H+2], center = true);
        
        cylinder (d = innerD+line_width*2+cli, h = H+2, center = true); 
    }
} // end spike
