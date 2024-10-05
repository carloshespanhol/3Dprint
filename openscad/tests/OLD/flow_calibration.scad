$fn=100;

s=100;
h=5;
t=0.44 *2;
si=s-2*t;
r=10;
rc=5;

difference(){
    union(){
        rcube(s,s,h,r);
        
        // Right
        translate([s, s/2, 0]){
            cylinder(r=rc, h=h);
            
            translate([-rc-t, -rc, 0])
            cube([rc+t, 6*t, h]);
        }
    }
    
    translate([t,t,-.1])
    rcube(si,si,h+1,r-t);
}

module rcube(length,width,height,radius=.05,chamfer=0){    
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
