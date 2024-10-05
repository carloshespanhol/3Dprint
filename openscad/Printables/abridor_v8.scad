use <../lib.scad>

$fn=200;
w=8;
l=75;
r=w/2;
y=15;
pw=10;
ex=3;
x=l-ex-pw;
lw=1;

//mirror([1,0,0])
color("grey")
difference(){
    e=1;
    wt=.5;
    union(){
        // mobile support
        translate([-pw-ex,0,-e])
        roundcube(pw+ex+10, 16, w+e*2, 7);

        // Center
        translate([-1,0,-e])
        roundcube(x/2,18,w+e*2);

        hull(){
            // tip
            translate([x-w/2-e,y-w/2-e,w/2])
            sphere(w/2+e);

            // washer
            translate([31+4.6,y+wt,w/2])
            rotate([90,0,-3])
            cylinder(d=8,h=wt);

            translate([36,y+wt+3.9,0])
            cylinder(d=6,h=w);

            translate([44,y+wt+3.4,0])
            cylinder(r=3,h=w);
        }

        hull(){
            // tip
            translate([x-w/2-e,y-w/2-e,w/2])
            sphere(w/2+e);
            
            translate([40,y,0])
            cylinder(d=5,h=w);

            translate([x-4,4,0])
            cylinder(r=4, h=w);
            
            translate([x/2-7,w/2+e,w/2])
            sphere(w/2+e);
            
            translate([x/2,10,0])
            cylinder(d=4, h=w);
        }        
    }
    //=============================================
    // Cut upper, down
    translate([-pw-ex, -.1, w])
    cube([pw+ex+x, y*2, 10]);
    translate([-pw-ex, -.1, -10])
    cube([pw+ex+x, y*2, 10]);
    
    // keyring hole
    r=2;
    translate([x-r-2.1,r+2,-.1])
    hull(){
        difference(){
            cylinder(r=r,h=w+1);
            
            translate([-r,r/2,-.1])
            cube([r*2,r*2,w+2]);
        }
        
        translate([-r/3*2,r/3*2-.5,0])
        cylinder(r=r/3,h=w*2);
        
        translate([-r/5*4,-r/5*4,0])
        cylinder(r=r/5,h=w*2);
        
        translate([r/10*9,r/10*9-.5,0])
        cylinder(r=r/10,h=w*2);
    }    
    
    /* phone support */
    translate([-pw+1,w/2+lw,-w])
    rcube(pw,y*2,w*3, 2); 

    translate([lw*2+1.06,13,-w])
    rcube(pw,y*2,w*3,2); 
    
    /* cut */
    translate([0,3,0]){
        // washer
        translate([31+4.6,y-3,w/2])
        rotate([90,0,-3])
        cylinder(d=8,h=wt+.2);
        translate([31+.6,y-3-wt,-.1])
        rotate([0,0,-3])
        cube([8+.5, wt+.2, 10]);
        
        translate([0,15,-.1])
        rotate([0,0,-17])
        cube([30,15,w+1]);
        
        translate([1.2,15,-.1])
        rotate([0,0,-17])
        cube([30,15,w+1]);
        
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
