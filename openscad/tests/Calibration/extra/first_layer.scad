$fn=200;

x=230;
y=170;
s=30;
t=.32;
b=20; // border distance
nl=1;

l=.6;

//circles();
//squares();
//bigcircle();
//bigx();

//p3();
center();

//p1();
//p2();
//p4();
//c3();


//%translate([-x/2,-y/2,0]) cube([x,y,.1]);

module center(){
    a=45;
    difference(){
        union(){
            translate([-s/2,-s/2,0])
            cube([s,s,t]);
            
            hull(){
                translate([-s/2,-s/2, t])
                cube([s,s,0.01]);
                
                translate([-s/2,-s/2, nl*t-t])
                cube([s,s+cos(a)*((nl*t)-t), t]);
            }
        }
        
        // front
        translate([0,-s/2, -.1])
        cylinder(d=s/4,h=nl*t*4);
        
        // center hole
        translate([0, 0, -.1])
        cylinder(d=s/2,h=(nl*t)/2);
    }
}    

module c3(){
    // Center
    difference(){
        translate([-s/2,-s/2,0])
        cube([s,s,t]);

        translate([0,-s/2,-.1])
        cylinder(d=5,h=t+1);
    }
    // Left
    translate([-x/2+s/2+b,0,0])
    difference(){
        translate([-s/2,-s/2,0])
        cube([s,s,t]);

        translate([0,-s/2,-.1])
        cylinder(d=5,h=t+1);
    }
    // Right
    translate([x/2-s/2-b,0,0])
    difference(){
        translate([-s/2,-s/2,0])
        cube([s,s,t]);

        translate([0,-s/2,-.1])
        cylinder(d=5,h=t+1);
    }
}


module p1(){
    // Center
    difference(){
        translate([-s/2,-s/2,0])
        cube([s,s,t]);

        translate([0,-s/2,-.1])
        cylinder(d=5,h=t+1);
    }
}
module p2(){
    // Left
    translate([-x/2+s/2+b,0,0])
    difference(){
        translate([-s/2,-s/2,0])
        cube([s,s,t]);

        translate([0,-s/2,-.1])
        cylinder(d=5,h=t+1);
    }
    // Right
    translate([x/2-s/2-b,0,0])
    difference(){
        translate([-s/2,-s/2,0])
        cube([s,s,t]);

        translate([0,-s/2,-.1])
        cylinder(d=5,h=t+1);
    }
}

module p4(){
    // Front 
    translate([-s/2,-y/2+b,0])
    cube([s,s,t]);    
    // Back 
    translate([-s/2,y/2-s-b,0])
    cube([s,s,t]);    
    // Left
    translate([-x/2+b,-s/2,0])
    cube([s,s,t]);    
    // Right
    translate([x/2-b-s,-s/2,0])
    cube([s,s,t]);        
}
module p3(){
    // Front 
    translate([-s/2,-y/2+b,0])
    difference(){
        cube([s,s,t]);    

        translate([s/2,0,-.1])
        cylinder(d=5,h=t+1);
    }
    // Back Left
    translate([-x/2+b,y/2-s-b,0])
    difference(){
        cube([s,s,t]);    

        translate([s/2,0,-.1])
        cylinder(d=5,h=t+1);
    }
    // Back Right
    translate([x/2-b-s,y/2-s-b,0])
    difference(){
        cube([s,s,t]);    

        translate([s/2,0,-.1])
        cylinder(d=5,h=t+1);
    }
}

module bigcircle(){
    difference(){
        cylinder(d=y, h=t);
        
        translate([0,0,-.1])
        cylinder(d=y-s, h=1);
    }
}

module bigx(){
    hull(){
        // Front Left
        translate([-x/2,-y/2,0])
        cube([s,s,t]);    
        // Back Right
        translate([x/2-s,y/2-s,0])
        cube([s,s,t]);    
    }

    hull(){
        // Front Right
        translate([x/2-s,-y/2,0])
        cube([s,s,t]);
        // Back Left
        translate([-x/2,y/2-s,0])
        cube([s,s,t]);    
    }
    
}
module squares(){
    // Front Left
    translate([-x/2,-y/2,0])
    cube([s,s,t]);    
    // Back Right
    translate([x/2-s,y/2-s,0])
    cube([s,s,t]);    
    // Front Right
    translate([x/2-s,-y/2,0])
    cube([s,s,t]);
    // Back Left
    translate([-x/2,y/2-s,0])
    cube([s,s,t]);    
    
    // Center
    translate([-s/2,-s/2,0])
    cube([s,s,t]);
}
module circles(){
    // Front Left
    translate([-x/2+s/2,-y/2+s/2,0])
    cylinder(d=s,h=t);
    // Front Right
    translate([x/2-s/2,-y/2+s/2,0])
    cylinder(d=s,h=t);
    // Back Left
    translate([-x/2+s/2,y/2-s/2,0])
    cylinder(d=s,h=t);
    // Back Right
    translate([x/2-s/2,y/2-s/2,0])
    cylinder(d=s,h=t);

    // Center
    cylinder(d=s,h=t);
}


/* Line
difference(){
    translate([-x/2+s/2,-y/2+s/2,0])
    cube([x-s,y-s,t]);

    translate([-x/2+s/2+l,-y/2+s/2+l,-.1])
    cube([x-s-l*2,y-s-l*2,t*2]);
}
/**/