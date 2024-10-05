use <../lib.scad>

$fn=200;
w=7;
l=75;
r=w/2;
y=15;
pw=9.5;
ex=w/2;
x=l-ex-pw;
lw=1;

//mirror([1,0,0])
difference(){
    union(){
        color("grey"){
            // mobile support
            translate([-pw-ex,0,0])
            roundcube(pw+ex+10, 18, w, 7);

            // Center
            translate([0,0,0])
            roundcube(x-y,18,w);

            hull(){
                translate([x-y*2-w,0,0])
                roundcube(w,y/2,w);

                translate([x-4,4,0])
                cylinder(r=4, h=w);
            }
            hull(){
                // tip
                translate([x-w/2,y-w/2,w/2])
                sphere(w/2);
                
                translate([x-4,4,0])
                cylinder(r=4, h=w);
                
                translate([37,y,0])
                cylinder(d=14.5,h=w);
            }
            
        }
    }
    //------------------------------
    // hole
    r=2;
    translate([x-r-1.9,r+2,-.1])
    hull(){
        cylinder(r=r,h=w*2);
        
        translate([-r/3*2,r/3*2,0])
        cylinder(r=r/3,h=w*2);
        
        translate([-r/5*4,-r/5*4,0])
        cylinder(r=r/5,h=w*2);
        
        translate([r/10*9,r/10*9,0])
        cylinder(r=r/10,h=w*2);
    }    
    
    // phone support
    translate([-pw+1,w/2+lw,-w])
    rcube(pw,y*2,w*3, 2); 

    translate([lw*2+1.06,13,-w])
    rcube(pw,y*2,w*3,2); 
    
    // upper cut
    translate([-pw-w,14,-.1])
    scube(pw+w/2,14,w+1);
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
                    translate([7.5,10.5,0])
                    cylinder(d=10,h=w+1);
          
                    *translate([25.5,14.5,0])
                    cylinder(d=18,h=w+1);
                    translate([26.5,13.5,0])
                    cylinder(d=16,h=w+1);
                }
                
                cube([33.5,11,w+1]);
            }
            
            translate([2.6,10,0])
            rotate([0,0,6])
            cube([10,5,w+1]);

            hull(){
                translate([31.7,10.5,0])
                cylinder(d=4,h=w+1);

                translate([24.5,8.5,0])
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