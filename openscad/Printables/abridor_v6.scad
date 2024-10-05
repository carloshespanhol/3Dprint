use <../lib.scad>

$fn=200;
w=8;
l=75;
r=w/2;
y=15;
pw=9.5;
ex=2.5;
x=l-ex-pw;


difference(){
    union(){
        color("grey"){
            hull(){
                translate([0,w/4,w/2])
                rotate([0,90,0])
                cylinder(d=w, h=l/2);
                //
                translate([-pw+w/2,w/4,w/2])
                sphere(d=w);

                // mobile support
                translate([-ex-pw,0,0])
                rcube(pw+ex+8, 18, w, 7);
                // Center
                translate([7,0,0])
                scube(l/2,y-2,w);
                
                // tip
                translate([40,0,0])
                rcube(x-40,y+2,w, 4);
            }    

            hull(){
                translate([37,y,0])
                cylinder(d=14.5,h=w);
            
                translate([28,0,0])
                cube([15,7,w]);
                // tip
                translate([34,0,0])
                rcube(x-34,y+2,w, 4);
            }
            
        }
    }
    //------------------------------
    // hole
    r=2;
    translate([x-r-2,r+2,-.1])
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
    translate([3.8-ex-pw,3.9,-w])
    rcube(pw,y*2,w*3, 3); 
    
    // upper cut
    translate([-pw-ex-2,14,-.1])
    rcube(pw,14,w+1, 2);
    translate([-pw/4,16,-.1])
    rcube(pw,14,w+1, 2);
    
    // cut
    translate([0,4,0]){
        translate([0,14,-.1])
        rotate([0,0,-15])
        cube([30,10,w+1]);
        
        translate([0,1,-.1])
        rotate([0,0,-3])
        {
            intersection(){
                hull(){
                    translate([8,11,0])
                    cylinder(d=11,h=w+1);
                    
                    translate([25.5,14.5,0])
                    cylinder(d=18,h=w+1);
                }
                
                cube([33.5,11,w+1]);
            }
            
                translate([2.6,10,0])
            rotate([0,0,6])
                cube([10,5,w+1]);

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