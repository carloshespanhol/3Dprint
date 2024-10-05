use <../lib.scad>
FontFacesInCustomizer=["Arial:style=Bold","Liberation Sans",
    "Open Sans:style=Bold",
    "Montserrat:style=Bold","Dosis:style=Bold","Orbitron:style=Bold"]; //TODO add more
Font="Orbitron";

$fn=500;
fit=0.5;
x=41;   //opener size
pw=15.5;  //phone width
pin=3;  //pin diameter
pp=3;   //pin x position
hy=3.5;   //hinge tickness
yp=3.5;   //hinge position
w=11;   //thickness
l=60;   //total x size
y=hy+yp+12; //total y size

color("grey")
difference(){
    abridor();
    
    translate([l,0,0])
    rotate([0,0,180])
    ruler();
    
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
            translate([yp+w/2,yp+hy+fit/2,w/2])
            rotate([90,0,0])
            cylinder(d=w, h=hy);    
            translate([yp,yp+fit/2,0])
            vrcube(l-yp-w/2-(l-x-pw)-fit, hy, w/3*2+2, 4);
            
            translate([yp+w/2,yp+fit/2,0])
            vrcube(x-w/2, hy, w, 0.1);
            
            // top
            hull(){
            difference(){
                translate([x+fit/2,yp+fit/2,0])
                vrcube(pw-fit, y-yp-fit/2, w, 3);
                
                translate([x+fit/2-.1,yp+fit/2-.1,-.1])
                cube([pw-fit+1, y-yp-fit/2+1, 4+fit+yp]);
            }
            translate([x+fit/2,yp+fit/2,4+fit])
            vrcube(pw/2-fit+4, y-yp*2, .1, .5);
            }
            translate([x+fit/2,yp+fit/2,0])
            vrcube(pw/2-fit+4, y-yp*2, 4+fit, .5);
            
            // pin
            translate([w/2+pp, 0+2,w/2])
            rotate([-90,0,0])
            cylinder(d=pin, h=hy+yp*2-2.5);    
        }
        //----------------------------------
        translate([x+pw/2-3,yp,-2])
        rotate([0,45,0])
        vrcube(5, y+1, w*2, .01);
        
    }
}


module abridor(){
translate([x-10,0,0])
cube([pw,yp,4]);

// phone support 
translate([x+pw,y, 4])
rotate([0,0,180])
fillet(3.5, y);
        
difference(){
    union(){
        // Body
        translate([0,0,0])
        rcube(l,y,w,4);
    }
    //=====================================
    // hinge top hole
    translate([l-7.5,yp,4])
    rotate([0,45+180,0])
    vrcube(4, y-yp*2+fit, w+1.5, .01);

    translate([x-.1,yp,-.5])
    vrcube(pw/2-fit/2, y-yp*2+fit, w, .01);
    
    // hinge slot
    translate([yp-fit/2,yp,-.1])
    cube([x+3,hy+fit,w+1]);

    // Pin hole
    translate([w/2+pp,1.5,w/2])
    rotate([-90,0,0])
    cylinder(d=pin+fit, h=hy+yp+2);    

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
    
    // keyring hole
    ro=7;
    ri=3;
    hr=3.5;
    translate([-1,y/2+2.5,w-1])
    rotate([90,0,0])
    ring(ro,ri,hr);    
}
}

module ruler(length = l, t=[-0.5,0,-1.75], r=[0,0,-90])
{
	mark_width = 0.125;
	mark_depth = 1;

	rotate(r) translate(t) union()
	{
		for ( i = [1:length-1] )
		{
			if (i % 10 == 0)	// tall one every 10
			{
				translate( [0, i, 0] ) cube( [mark_depth, mark_width*2, 7 ] );
				translate( [0, i+(2*mark_width), 6.5] ) rotate([90,0,90]) color("white")
               if (i<30){  
                text(str(i), 1.5, Font);
                //write(str(i), t=mark_depth, h=1, font="orbitron.dxf");
               } 
			}
			else if (i % 5 == 0)	// med. tall one every 5
				translate( [0, i, 0] ) color("white") cube( [mark_depth, mark_width, 5 ] );
			else	// otherwise a short one
				translate( [0, i, 0] ) color("white") cube( [mark_depth, mark_width, 3 ] );
		}
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