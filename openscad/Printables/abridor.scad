$fn=100;

difference(){
    union(){
        opener();
        translate([0,0,5])
        opener();

        translate([62,0,7.1])
        rotate([0,45,0])
        cube([10,7.3,10]);

        translate([59.1,0,0])
        cube([10,7.3,10]);

        translate([60,0,7.1])
        cube([16.15,7.3,12.9]);
    }
    
    translate([70,10,14])
    rotate([90,0,0])
    cylinder(d=5,h=15);
    
#    hull(){
        intersection(){
            hull(){
                translate([3.75,11.25,-.1])
                cylinder(d=3,h=30);
                translate([8.3,9.9,-.1])
                cylinder(d=10,h=30);
                translate([25,14,-.1])
                cylinder(d=18.5,h=30);
            }
            
            cube([50,11,50]);
        }
        
        translate([32.25,11.25,-.1])
        cylinder(d=3,h=30);
    }
}

module opener(){
    difference(){
        translate([-24,-0.6,-10])
        import("/home/hespanhol/Downloads/BottleOpenerNexeo-3DWP.stl");

        translate([0,-20,0])
        cube([110,20,50]);
    }
}