$fn=100;

lw=0.8;
t=3;
so=50;
si=so-t*2;
h=3;
r=5;

//circle();
//square();
twowalls();

module twowalls(){

    for (i = [so/20:so/5:so*.5]) {
        translate([i,r/2,0])
        cylinder(d=so/10, h=h);
        translate([i-so/20,r/2,0])
        cube([so/10,so/10,h]);
    }
    difference(){
        union(){
            translate([0,0,0])
            rcube(so, so/2, h,r); 

            *translate([so/5,so*.375,0])
            cylinder(d=so/4, h=h/2*3);
        }
        translate([-11,-r,-.1])
        rcube(so+1, r*2, h+1,r);

        translate([so*.55,so/2,-.1])
        cylinder(d=so/8, h=h/2*3);
        
        translate([so*.89,so*.39,-.1])
        cylinder(d=so/8, h=h/2*3);
        
        *translate([so*.89,so*.1,-.1])
        cylinder(d=so/8, h=h/2*3);
        
        translate([r,so/2-so/4-1.5,-.1])
        rcube(so/3,so/3,h/2,r/4);    
        
        translate([0,so/2-h/2+.5,-h])
        rotate([40,0,0])
        cube([so,so/2,h]);
        
        for (i = [so/20+so/10:so/5:so*.5]) {
            translate([i,r,-.1])
            cylinder(d=so/10, h=h+1);
        }
        
    }
}

module square(){
    translate([-so/2,0,0])
    difference(){
        translate([0,0,0])
        cube([so, so/2, h]); 
        
        translate([t,t,-.1])
        cube([si, si, h+1]); 
    }   

    difference(){
        rotate([0,0,45])
        difference(){
            cube([so, so, h]); 

            translate([t,t,-.1])
            cube([si, si, h+1]); 
        }
        translate([-so/2,0,-.1])
        cube([so, so/2, h+1]); 

        translate([t-so/2,t,-.1])
        cube([si, so/2, h+1]); 
    }   
}

module circle(){
    difference(){
        cylinder(d=so, h=h); 
     
        translate([0,0,-.1])
        cylinder(d=si, h=h+1);
    }    
}

module rcube(length,width,height,radius=.5,chamfer=0){    
    l=length-2*radius;
    w=width-2*radius;    
    difference(){
        translate([radius,radius,0])
        hull(){
            cylinder(r=radius,h=height);    
            translate([0,w,0])
            cylinder(r=radius,h=height);    
            translate([l,0,0])
            cylinder(r=radius,h=height);    
            translate([l,w,0])
            cylinder(r=radius,h=height);    
        }
        /*******************************/
        difference(){
            translate([-.1,-.1,-.1])
                cube([length+.2,width+.2,chamfer]);
            /*******************************/
            hull(){
                translate([-.1,-.1,chamfer])
                cube([length+.2,width+.2,.1]);
                translate([chamfer,chamfer-.1])
                cube([length-chamfer*2,width-chamfer*2,.1]);
            }
        }
    }
}
    