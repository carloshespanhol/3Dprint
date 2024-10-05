use <../../lib.scad>

$fn=200;
w=4;
l=75;
r=w/2;
y=15;
pw=10;
ex=3;
x=l-ex-pw;
lw=1;
washer=true;



difference(){
    e=1;
    union(){
        // Body
        translate([-1,0,-e])
        rcube(x/2,y,w+e*2,w/2+e);


    }
    //=====================================
    // Cut upper, down
    translate([-pw-ex, -.1, w])
    cube([pw+ex+x, y*2, 10]);
    translate([-pw-ex, -.1, -10])
    cube([pw+ex+x, y*2, 10]);
    
    // keyring hole
    r=3;
    dh=3;
    translate([dh,dh+1,-.1])
    rotate([0,0,-90])
    hull(){
        difference(){
            translate([-.5,.5,0])
            cylinder(r=r,h=w+1);
            
            translate([-dh,1,-.1])
            cube([dh*3,dh*2,w+2]);
            
            translate([-7,-3,-.1])
            cube([dh*2,dh*2,w+2]);
        }
        
        translate([-1,1,0])
        cylinder(r=.5,h=w*2);
        
        translate([-1,-dh+1,0])
        cylinder(r=.5,h=w*2);
        
        translate([dh-1,1,0])
        cylinder(r=.5,h=w*2);
    }    
    
    /* cut */
    translate([0,9.5,-.1])
    rotate([0,0,-3])
    chapinha();    

}

module chapinha(){
    wt=1;
    wp= 7.4 + wt;
    
    // nut & screw
    translate([31+4.6, -4, w/2])
    rotate([90,0,0])
    Mscrew(16,he=true);
    translate([31+4.6, y+7.5, w/2])
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
            translate([6.6,5/2+.3,0])
            cylinder(d=5,h=w+1);
  
            translate([29.8,5/2+.3,0])
            cylinder(d=5,h=w+1);
  
            translate([24.9,7,0])
            cylinder(d=15.7,h=w+1);
        }
        
        translate([0,.3,0])
        cube([33.5,7,w+1]);
        
        translate([0,.3,0])
        cube([35,7,w+1]);
    }
    
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