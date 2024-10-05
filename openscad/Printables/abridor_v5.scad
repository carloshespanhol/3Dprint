use <../lib.scad>

$fn=200;
w=6;
l=65;
r=w/2;
y=15;
pw=9.5;
ex=pw+2;
x=l-ex;


difference(){
    union(){
        color("grey"){
            // mobile support
            translate([-ex,0,0])
            rcube(ex+6,y,w, 2);
            
            hull(){
                translate([37,14,0])
                cylinder(d=13,h=w);
            
                translate([28,0,0])
                cube([15,7,w]);
                // tip
                translate([34,0,0])
                rcube(x-34,18,w, 3);
            }
            
            // Center
            scube(l/3*2,10,w);
        }
    }
    //------------------------------
    // hole
    r=2;
    translate([x-r-1.9,r+1.9,-.1])
    hull(){
        cylinder(r=r,h=w*2);
        
        translate([-r/3*2,r/3*2,0])
        cylinder(r=r/3,h=w*2);
        translate([-r/3*2,-r/3*2,0])
        cylinder(r=r/3,h=w*2);
        translate([r/3*2,r/3*2,0])
        cylinder(r=r/3,h=w*2);
    }    
    
    // phone support
    translate([-pw,6,-w])
    rcube(pw,y,w*3, 3);
    
    
    // cut
    translate([0,2,0]){
    translate([-.25,20,-.1])
    rotate([0,0,-69])
    scube(10,10,w+1);  
        
    hull(){
        translate([2,15,-.1])
        cube([20,5,w+1]);
        
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
            
            cube([33.5,11.9,w+1]);
        }
        
        hull(){
            translate([32.1,11,0])
            cylinder(d=3,h=w+1);

            translate([25,9,0])
            cube([2,2,w+1]);
        }
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