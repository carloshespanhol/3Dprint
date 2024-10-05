use <../lib.scad>

$fn=200;
w=11;
l=64;
r=w/2;
y=12;
pw=13;
ex=3;
x=43;
lw=1;
cnc=false;
fit=0.5;
pin=3;
hy=5-fit;
yp=-fit/2;

color("grey")
difference(){
    abridor();

    *translate([-.1,-11,w/2])
    cube([100,50,20]);
}

hinge();


*translate([18.5,12,w/2])
rotate([0,0,-3])
rotate([90,0,0])
tampa();

module hinge(){
    difference(){
        union(){
            // hinge
            hull(){
                translate([5+w/2+fit,yp,w/2])
                rotate([90,0,0])
                cylinder(d=w, h=hy);    
                
                translate([x-hy/2-fit,yp-hy/2,0])
                cylinder(d=hy, h=w);    
            }
            translate([x-hy,yp-hy,4+fit])
            vrcube(pw+hy-.5, hy, w-4-fit, 2);
            translate([x+pw-hy,yp-hy/2,4+fit/2])
            cylinder(d=hy, h=1);    
            
            translate([w/2+5, -8,w/2])
            rotate([-90,0,0])
            cylinder(d=pin, h=11);    
        }
        //----------------------------------
        
    }
}


module abridor(){
rc=2;
sy=8;

difference(){
    union(){
        // Body
        translate([0,0,0])
        rcube(x,y-1,w,3);
        translate([3,3,0])
        cube([x-3,y-3-1,w]);
        
        translate([0,0,0])
        cube([x,y/2,w]);
        
        // Mobile support
        translate([43,-sy,0])
        rcube(pw+4,y+sy-1,w,2);
        translate([43-2,-sy,0])
        cube([pw,y+sy-1,4]);

        //
        translate([0,-sy+rc,0])
        cube([5,10,w]);
        translate([rc,-sy+rc,0])
        cylinder(r=rc, h=w);

        translate([rc,-sy,0])
        cube([x,sy-5,w]);
    }
    //=====================================
    // Pin hole
    translate([w/2+5,-8.5,w/2])
    rotate([-90,0,0])
    cylinder(d=pin+fit, h=12);    

    /* phone support */
    translate([x,-9.1, w+.1])
    rotate([0,180,0])
    fillet(4.5, y*2);
    
    translate([x-hy/2-fit,yp-hy/2,-1])
    rotate([0,20,0])
    cylinder(d=hy+fit, h=w*2);    
    
    hull(){
        translate([43-.1,-12, w])
        cube([pw,y*2,.1]); 

        translate([43-.1,-12, 4])
        cube([pw,y*2,.1]); 
    }
    
    /* cut */
    translate([0,7.5-2,-.1])
    rotate([0,0,-3])
    chapinha();    

    // keyring hole
    ro=6;
    ri=3;
    hr=4;
    translate([0,-9.5,w/2-hr/2])
    ring(ro,ri,hr);    
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

/*    r=3;
    dh=3;
    translate([x+pw+2.6,-5.9,-.1])
    rotate([0,0,0])
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
}
*/