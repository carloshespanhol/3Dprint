use <../lib.scad>

$fn=200;
w=12;
l=75;
r=w/2;

difference(){
    union(){
        color("grey"){
            translate([-5,0,0])
            rcube(l/4,14,w,5);
            hull(){
                translate([37,14,0])
                cylinder(d=13,h=w);
            
                translate([28,0,0])
                cube([23.5,7,w]);
            }
            
            vrcube(l,7,w,r);
            
            scube(l/2,7,w);

            translate([40,0,0])
            cube([15,15,w]);
        }
    }
    //------------------------------
    // Bridge test
    hull(){
        translate([41,6,-.1])
        cylinder(d=8, h=w/4);
        translate([51,4,-.1])
        cylinder(d=4, h=w/4);
    }
    
    // chamfer
    translate([61.3,30,-.1])
    hull(){
        translate([0,0,-.1])
        cylinder(d=48,h=w+1);
        translate([l,0,-.1])
        cylinder(d=48,h=w+1);
    }
    
    // hole
    translate([l-r-2,w*2-r,w/2])
    rotate([90,8,0])
    polyhole(d=w/2-.5,h=w*2);
    
    // cut
    translate([1.7,15.5,-.1])
    rotate([0,0,-70])
    scube(8,10,w+1);
    
    hull(){
        translate([2.5,14.25,-.1])
        cylinder(d=1,h=w+1);
        translate([8.75,10.48,-.1])
        cylinder(d=10,h=w+1);
    }

    translate([0,1,-.1])
    rotate([0,0,-3])
    {
        intersection(){
            hull(){
                translate([5,9,0])
                cylinder(d=3,h=w+1);
                
                translate([8.3,9.9,0])
                cylinder(d=10,h=w+1);
                
                translate([25.225,14,0])
                cylinder(d=18,h=w+1);
            }
            
            cube([50,10.4,50]);
        }
        
        hull(){
            translate([32.1,11,0])
            cylinder(d=3,h=w+1);

            translate([25,9,0])
            cube([2,2,w+1]);
        }
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