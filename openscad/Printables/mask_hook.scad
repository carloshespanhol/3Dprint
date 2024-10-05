use <../lib.scad>
$fn=200;

hook3();

module hook3(){
tz=1.5;
l=95;
w=4.75;
t=3.75;
dh=5;
    
    translate([t+1,0,0])
    difference(){
        cylinder(d=dh+t*2, h=tz);

        translate([-3,-20,-.1])
        cube([40,40,40]);
    }
    
    difference(){
        union(){
            translate([0,-w/2,0])
            rcube(l,w, tz);

            translate([l-dh/2,0,0])
            cylinder(d=dh+t*2, h=tz);
            
            /* hook */
            hull(){
                translate([w,-dh/2-t,0])
                cylinder(d=dh/2,h=tz);

                translate([.5,-w,0])
                rcube(1,w, tz);
            }
            mirror([0,1,0])
            hull(){
                translate([w,-dh/2-t,0])
                cylinder(d=dh/2,h=tz);

                translate([.5,-w,0])
                rcube(1,w, tz);
            }
        }
        
        translate([l-dh/2, 0, -.1])
        cylinder(d=dh, h=tz+1);
    }
}

module hook2(){
h=90;
l=120;
w=4.4;
ti= 1;
t=2;
sw=20;
lw=30;

len=80;
    translate([w,0,0])
    rcube(len,w,t);

    translate([len+w*2,0,0])
    mirror([1,0,0])
    hk2();

    hk2();
}

module hook1(){
h=90;
l=120;
w=4.4;
ti= 1;
t=2;
sw=20;
lw=30;

len=80;
    hook();
    //mirror([1,0,0]) hook();
    mirror([0,1,0]) hook();
    //mirror([1,0,0]) mirror([0,1,0]) hook();

    difference(){
        union(){
            // Center
            translate([-sw/2, -(l-h)/2, 0])
            rcube(sw,l-h, ti);

            translate([-lw/2, (l-h)/2-w, 0])
            rcube(lw/2+w+2,w, t);

            translate([-lw/2, -(l-h)/2, 0])
            rcube(lw/2+w+2,w, t);
            
            // hook
            translate([-lw/2-w, (l-h)/2, 0])
            hk();
            translate([-lw/2-w, -(l-h)/2, 0])
            mirror([0,1,0]) hk();
        }

        // Upper cut
        translate([-h,-l,t])
        scube(h*2,l*2,20);    
    }
}

module hk(){
    translate([-w*1.5,0,0])
    cylinder(d=w, h=t);
    
    rotate_extrude(angle=270, convexity=10)
    translate([w, 0]) 
    square(w);
}
    
module hk2(){
    difference(){
        union(){
            translate([0,-w,0])
            cylinder(d=w, h=t);
            
            rotate_extrude(angle=270, convexity=10)
            translate([w/2, 0]) 
            square(w);
        }
        
        translate([-len/2,-len/2,t])
        scube(len*2,len,w);
    }
}
    
module hook(){
    difference(){
        union(){
            // hook
            translate([h/2+w*2, l/2+w, 0]){
                translate([w*1.5,0,0])
                cylinder(d=w, h=t);
                
                rotate([0,0,0])
                rotate_extrude(angle=270, convexity=10)
                translate([w, 0]) 
                square(w);
            }
        
            // struct
            translate([w, l/2, 0])
            rotate_extrude(angle=-90, convexity=10)
              translate([h/2, 0]) 
               square(w);
                            
        }

        // Upper cut
        translate([-1,-w,t])
        scube(h*2,l,20);
    }    
}   
    