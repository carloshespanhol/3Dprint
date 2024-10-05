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
washer=false;

//mirror([1,0,0])
color("grey")
difference(){
    abridor();

    *translate([0,-.1,w/2])
    cube([50,50,20]);
}

%translate([18.5,16,w/2])
rotate([0,0,-3])
rotate([90,0,0])
tampa();

module tampa(){
    //27, 29, 26, 7
    hull(){
        cylinder(d=29, h=.1);
        
        translate([0,0,6])
        cylinder(d=27, h=.1);
        translate([0,0,7])
        cylinder(d=25, h=.1);
    }
    // Garrafa
    translate([0,0,-5])
    cylinder(d=26, h=10);
}

module abridor(){
difference(){
    e=1;
    union(){
        // Center
        translate([-1,0,-e])
        roundcube(x/2,20,w+e*2);

        hull(){
            // tip
            translate([x-w/2-e,y-w/2-e,w/2])
            sphere(w/2+e);

            // washer
            translate([31+4.6,y+.15,w/2])
            rotate([90,0,-3])
            cylinder(d=8,h=.1);

            translate([31+.5,y+.15,0])
            cube([8,1,8]);
            
            translate([36,y+2.9,0])
            cylinder(d=8,h=w);

            translate([44,y+3.4,0])
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
    //==========================================
    // Cut upper, down
    translate([-pw-ex, -.1, w])
    cube([pw+ex+x, y*2, 10]);
    translate([-pw-ex, -.1, -10])
    cube([pw+ex+x, y*2, 10]);
    
    // keyring hole
    r=2;
    translate([r+1.5,r+2.5,-.1])
    rotate([0,0,-90])
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
    translate([x-pw-3.5,-w/2+lw,-w])
    rcube(pw,y,w*3, 2); 

    /* cut */
    translate([0,9.5,-.1])
    rotate([0,0,-3])
    chapinha();
}
}

module chapinha(){
    wt=.5;
    wp= 6.9 + wt;
    
    *translate([0,wp,0])
    cube([40,.1,w]);
    
    // nut & screw
    translate([31+4.6, -2.5, w/2])
    rotate([90,0,0])
    Mscrew(16);
    translate([31+4.6, y+9, w/2])
    rotate([90,0,0])
    rotate([0,0,30])
    Mnut();
    
    // washer
    if(washer){
        translate([31+4.6,wp,w/2])
        rotate([90,0,0])
        cylinder(d=8,h=wt+.2);        
        translate([30+.2,wp-wt-.2,-.1])
        rotate([0,0,0])
        cube([9+.5, wt+.2, 10]);
    }
    
    intersection(){
        hull(){
            translate([6.7,5/2+.3,0])
            cylinder(d=5,h=w+1);
  
            translate([26.5,6,0])
            cylinder(d=14,h=w+1);
        }
        
        translate([0,.3,0])
        cube([33.5,7,w+1]);
        
        translate([0,.3,0])
        cube([35,7,w+1]);
    }
    
    *translate([31.7,5,0])
    cylinder(d=4,h=w+1);

    // left
    hull(){
        translate([7,6/2+.3,0])
        cylinder(d=6,h=w+1);

        translate([3.7,5,0])
        rotate([0,0,8])
        cube([10,10,w+1]);
    } 

    // center
    translate([7,2.5,-.1])
    cube([24,15,w+1]);
   
}    