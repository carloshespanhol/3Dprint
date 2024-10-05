use <../lib.scad>

$fn=500;
fit=0.6;
x=41;   //opener size
pw=14;  //phone width
pin=3;  //pin diameter
pp=3;   //pin x position
hy=3.5;   //hinge tickness
yp=3.5;   //hinge position
w=11;   //thickness
l=58.5;   //total x size
y=hy+yp+12; //total y size

color("grey")
difference(){
    abridor();
    
    // cut
    *translate([-.1,-11,w/2])
    cube([100,50,20]);
}

hinge();


*translate([18.5,y+1,w/2])
rotate([0,0,-3])
rotate([90,0,0])
tampa();

module hinge(){
    difference(){
        union(){
            // body
            translate([pp+w/2+fit,yp+hy+fit/2,w/2])
            rotate([90,0,0])
            cylinder(d=w, h=hy);    
            
            translate([pp+w/2,yp+fit/2,0])
            vrcube(l-pp-w/2-(l-x-pw)-fit, hy, w, 2);
            translate([pp+w/2,yp+fit/2,0])
            vrcube(l/2, hy, w, 0.1);
            
            // top
            translate([x+pw/2-3,yp+fit/2,0])
            vrcube(pw/2-fit+3, y-yp*2, w, 2);
            
            // pin
            translate([w/2+pp, 0,w/2])
            rotate([-90,0,0])
            cylinder(d=pin, h=hy+yp*2);    
        }
        //----------------------------------
        translate([x+pw/2-fit/2+3,yp+hy+fit/2,-2])
        rotate([0,-45,0])
        vrcube(fit, y-yp*2-hy+.1, w, .01);

        translate([x+pw/2-fit/2,yp+hy+fit/2,-2])
        rotate([0,-45,0])
        vrcube(fit+2, y-yp*2-hy+.1, w, .01);
    }
}


module abridor(){
translate([x-10,0,0])
cube([pw,yp,4]);
        
difference(){
    union(){
        // Body
        translate([0,0,0])
        rcube(l,y,w,3);
    }
    //=====================================
    // hinge top hole
    translate([x+pw/2,yp+fit/2,-.5])
    vrcube(pw/2-fit/2, y-yp*2+fit/2, w, .01);
    
    translate([x+pw/2-fit/2+3,yp+fit/2,-2])
    rotate([0,-45,0])
    vrcube(pw/2, y-yp*2+fit/2, w, .01);
    
    // Pin hole
    translate([w/2+pp,-.5,w/2])
    rotate([-90,0,0])
    cylinder(d=pin+fit, h=hy+yp*2+fit*2);    

    /* phone support */
    translate([x,-9.1, w+.1])
    rotate([0,180,0])
    fillet(5, y*2);
    
    translate([x-.1,-12, 4])
    cube([pw,y*2,w]); 
    
    //tampa
    translate([0,y-5.5,-.1])
    rotate([0,0,-3])
    chapinha(); 
    //
    translate([x-10,-.1,4])
    cube([pw,5,w]);
    translate([x-10+.1,-.1, w+.1])
    rotate([0,180,0])
    fillet(2, yp+1);
    
    // hinge slot
    translate([3,yp,-.1])
    cube([x+pw-3-fit/2,hy+fit,w+1]);

    // keyring hole
    ro=6;
    ri=3;
    hr=4;
    translate([-1,y/2+3.5,w-1])
    rotate([90,0,0])
    ring(ro,ri,hr);    
}
}

module chapinha(){
    wt=1;
    wp= 7.4 + wt;
    
    // nut & screw
    translate([31+4.6, 0, w/2])
    rotate([90,0,0])
    Mscrew(16,he=true);
    translate([31+4.6, 19.5, w/2])
    rotate([90,0,0])
    rotate([0,0,30])
    Mnut();
    
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