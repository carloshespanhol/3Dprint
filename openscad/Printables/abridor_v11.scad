use <../lib.scad>

$fn=200;
w=9;
l=60;
r=w/2;
y=15;
pw=10;
ex=3;
x=l;
lw=1;
cnc=false;

//mirror([1,0,0])
color("grey")
difference(){
    abridor();

    *translate([0,-.1,w/2])
    cube([50,50,20]);
}

*translate([18.5,16,w/2])
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
    translate([0,2,0])
    union(){
        // Body
        translate([-1,0,0])
        rcube(x,y-1,w,w/2);
        translate([x-11,-3.5,0])
        rcube(10,y+3,w,w/3);

        hull(){
            // tip
            translate([x-w/2-1,y-3.5,0])
            cylinder(d=w, h=w);

            translate([36.5,y-1,0])
            cube([7,2,w]);
        }
    
    }
    //=====================================
    // keyring hole
    r=3;
    dh=3;
    translate([x-dh-2,y-1,-.1])
    rotate([0,0,90])
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
    
    /* phone support */
    translate([x-pw*2+3,-6,-w])
    rotate([0,0,5])
    rcube(pw,y+5,w*3, 2); 

    /* cut */
    translate([0,9.5,-.1])
    rotate([0,0,-3])
    chapinha();    

    if(!cnc){
        translate([30, y+.5, -.1])
        rotate([0,0,-3])
        cube([6.5, 8, 10]);
    }
}
}

module chapinha(){
    wt=1;
    wp= 7.4 + wt;
    
    if(!cnc){
        // nut & screw
        translate([31+4.6, -4+2, w/2])
        rotate([90,0,0])
        Mscrew(16,he=true);
        translate([31+4.6, y+5, w/2])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut();

        // washer
        translate([31+4.6,wp,w/2])
        rotate([90,0,0])
        cylinder(d=8,h=wt);        
        translate([30+.2,wp-wt,-.1])
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
        cube([33.5,7.5,w+1]);
        
        translate([0,.3,0])
        cube([35,7.5,w+1]);
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