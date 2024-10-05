use <../lib.scad>
$fn=100;
pf=0.2; //pressfit

cl= 130;
cw= 50;

br=22;
bh=8+pf;
bw=7;

dxy=40;
t=4;
r=1;

// mobile
*%translate([-cl/2,dxy,cw/2])
vrcube(cl,t,cw,r);
// axis
*%translate([0,dxy,-100])
cylinder(d=bh, h=125);

//rotate([90,45,0])
bearing_arm();
//translate([0,dxy,dxy]) rotate([-90,0,0]) 
*arm();
*base();


module base(){
    l=160;
    w=25;
    r=10;
    t=6;
    
    difference(){
        union(){
            rcube(l,w,t,r);
        }
        //---------------------
        translate([l/2-w/2-pf,-l/2+w/2,t/2])
        rcube(w,l,t,r-t);
        
        // axis
        translate([l/2,w/2,-20])
        cylinder(d=bh, h=50);        

        // Weight
        translate([w/2,w/2,-20])
        cylinder(d=bh, h=50);        
        translate([l-w/2,w/2,-20])
        cylinder(d=bh, h=50);        
    }
}

module arm(){
    difference(){
        union(){
            // arm
            *translate([dxy-bw-t-1,dxy-(br+t)/2,-bw-br/2-t])
            rotate([0,-45,0])
            cube([br/2+t/2,br+t,bw+t]);

            translate([dxy-bw-t-1,dxy-(br+t)/2,-bw-br/2-t])
            cube([bw+t,br+t,br]);
            
            translate([dxy-bw-t-1,dxy-(br+t)/2,-br/2])
            rotate([0,-90,0])
            fillet(t,br+t);
            
            // bearing holders
            hull(){
                translate([dxy-bw*2-t,dxy-(br+t)/2,-bw-br/2-t])
                cube([t,br+t,bw+t]);

                translate([0,dxy,-bw-br/2-t])
                cylinder(d=br+t*2, h=bw+t);
            }
            
            translate([dxy-bw-t-1,dxy,-.1])
            rotate([90,0,90])
            cylinder(d=br+t, h=bw+t);
        }
        //---------------------------
        
            translate([dxy-bw-t-1,dxy-(br+t)/2-t/2,-bw*2-br/2-t*3+.5])
            rotate([0,-45,0])
            cube([br+t,br+t*2,bw+t]);

        
        // axis
        translate([0,dxy,-50])
        cylinder(d=bh, h=125);

        translate([0,dxy,0])
        rotate([0,90,0])
        cylinder(d=bh, h=125);
    }
}
module bearing_arm(){
    difference(){
        union(){
            // arm
            hull(){
                translate([br/2,-bw-t,-br/2])
                cube([t,bw,br]);
                
                translate([dxy+t,dxy-br/2-t,-br/2])
                cube([bw,t,br]);
            }

            // bearing holders
            translate([0,0,0])
            rotate([90,0,0])
            cylinder(d=br+t*2, h=bw+t);

            translate([dxy,dxy,-.1])
            rotate([90,0,90])
            cylinder(d=br+t*2, h=bw+t);
        }
        //---------------------------
        
        // bearings
        translate([0,.1,0])
        rotate([90,0,0])
        cylinder(d=br+pf, h=bw);

        translate([dxy-.1,dxy,0])
        rotate([90,0,90])
        cylinder(d=br+pf, h=bw);
        
        // holes
        translate([0,-1,0])
        rotate([90,0,0])
        cylinder(d=bh*2, h=bw+t);

        translate([dxy-.1,dxy,0])
        rotate([90,0,90])
        cylinder(d=bh*2, h=bw+t+1);    
    }
}


