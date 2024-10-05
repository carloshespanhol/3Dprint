use <../lib.scad>

$fn=200;
w=8;
l=60;
r=w/2;
y=12;
pw=10;

difference(){
    union(){
        color("grey"){
            // phone support
            translate([-5-pw-2,0,0])
            rcube(l/2,16,w,5);

            translate([-5,0,0])
            rcube(l/4,14,w,5);
            
            hull(){
                translate([37,14,0])
                cylinder(d=13,h=w);
            
                translate([28,0,0])
                cube([23.5,7,w]);

                translate([l/2,0,0])
                rcube(l/2,y,w,w/2);
            }

            scube(l/2,7,w);
        }
    }
    //------------------------------
    // hole
    translate([l-r-2,y/2,-.1])
    cylinder(d=y/2-.5,h=w*2);
    
    // phone support
    translate([-2.5-pw,y/2,-w])
    //rotate([0,-45,0])
    cube([pw,20,l]);
    
    
    // cut
    translate([-.25,20,-.1])
    rotate([0,0,-69])
    scube(10,10,w+1);   
    hull(){
        translate([2,15,-.1])
        cube([20,y,w+1]);
        
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