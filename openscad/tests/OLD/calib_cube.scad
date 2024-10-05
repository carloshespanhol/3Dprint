use <../lib.scad>
$fn=100;

s=50;
si=35;
s2=15;

h=4;
t=1;
r=10;
rc=5;
di=20;
c=4;


difference(){
    union(){
        //Base
        difference(){
            hull(){
                translate([0,0,h-.1])
                rcube(s,s,.11,1);
                
                rcube(s,s,.1,1);
            }
            
            translate([s/2-di/2,-1,-.1])
            rcube(di,s/2,h+2,1);

            translate([s/2, s/2, -.1])  
            cylinder(d=di, h=h+.2);

            translate([s/2-di/2,s,-h])
            rotate([40,0,0])
            rcube(di,s/2,h+2,1);
        }
        
        // Center hole
        difference(){
            translate([s/2, s/2, 0])  
            cylinder(d=di+t*4, h=h);
    
            translate([s/2, s/2, -.1])  
            cylinder(d=di, h=h+.2);
        }
        
        // Sphere
        difference(){
            translate([s/2, s/2, 0])  
            sphere(d=di+t*4);

            translate([s/2, s/2, 0])  
            sphere(d=di);
            
        }
        
        // Right
        translate([s, s/2, 0]){
            cylinder(r=rc, h=h);
            
            translate([-rc-t, -rc, 0])
            rcube(rc+t, rc*2, h, .5);
        }
        
        // Cylinders
        translate([c/2, c/2, 0])  
        cylinder(d=c, h=di/2);
        translate([s-c/2, c/2, 0])  
        cylinder(d=c, h=di/2);
        translate([c/2, s-c/2, 0])  
        cylinder(d=c, h=di/2);
        translate([s-c/2, s-c/2, 0])  
        cylinder(d=c, h=di/2);
        
    }
    
    // Base
    translate([0,0,-di])
    rcube(s,s,di,1);   
   
   // Bridge
   translate([di/4, s/2-di/2,-.1])
   rcube(5,di,h/2,1);
}
