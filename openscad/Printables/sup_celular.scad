$fn=200;

t=4;
x=200;
y=120;
z=40;


difference(){
    union(){
        *cylinder(d=x, h=t);
        translate([-x/2,0,0])
        rcube(x,y,t,2);
        
        translate([-x/2,0,0])
        cube([x,t,z]);
        
        translate([x/2,t,t])
        rotate([0,0,90])
        fillet(25,x);
    }
    
    translate([-x/2,-x,-.1])
    cube([x,x,t+1]);
}

//------------------------------
module fillet(s=1, t=1) {
    difference() {
        cube([s, t, s]);
                
        translate([s*1,-0.1,s])
        rotate([-90,0,0])
        cylinder(d=s*2, h=t*2);
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

