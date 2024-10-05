use <../lib.scad>
$fn=100;

lw=0.6; // linewidth

s=50;
si=35;
s2=15;

h=2;
t=1;
r=10;
rc=5;
di=20;
c=10;

calib();

module half_sphere(){
    // Sphere
    difference(){
        translate([s/2, s/2, h/2])  
        sphere(d=di+t*4);

        translate([s/2, s/2, h/2])  
        sphere(d=di+t*4 - lw*10);    

        // Base
        translate([0,0,-di])
        rcube(s,s,di,1);          
    }
}

module calib(){
    difference(){
        union(){
            //Base
            difference(){
                hull(){
                    translate([0,0,h-.1])
                    rcube(s,s,.11,c/2);
                    
                    rcube(s,s,.1,c/2);
                }
                
                translate([c/2,0,-.1])
                rotate([0,0,-45])
                rcube(s*.7,s*.7-c*.6,h+2,1);

                // Center hole
                translate([s/2, s/2, -.1])  
                cylinder(d=di, h=h+.2);

                // Chamfer
                translate([s/2-di/2, s-h*2, -h*2])
                rotate([40,0,0])
                rcube(di,s/2,h*2,1);
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
                translate([s/2, s/2, -di/5])  
                sphere(d=di+t*4);

                translate([s/2, s/2, -di/5])  
                sphere(d=di+t*4 - lw*10);            
            }
            
            // Right
            translate([s, s/2-rc, 0]){
                cylinder(r=rc, h=h);
                
                translate([-rc-t, -rc, 0])
                rcube(rc+t, rc*2, h, .5);
            }
            
            // Cylinders
            p=lw*2;
            ch=di/3;
            translate([c/2, c/2, 0]){  
                cylinder(d=c, h=h);
                cylinder(d1=c, d2=p, h=ch);
            }
            translate([s-c/2, c/2, 0]){  
                cylinder(d=c, h=h);
                cylinder(d1=c, d2=p, h=ch);
            }
            translate([c/2, s-c/2, 0]){
                cylinder(d=c, h=h);
                cylinder(d1=c, d2=p, h=ch);
            }
            translate([s-c/2, s-c/2, 0]){
                cylinder(d=c, h=h);
                cylinder(d1=c, d2=p, h=ch);
            }
        }
        
        // Base
        translate([0,0,-di])
        rcube(s,s,di,1);   
       
        // Bridge
        translate([2, s*.2,-.1])
        rcube( (s-di)/2-4, s*.7, h/2,1);
        
        // Right
        translate([s, s/2+rc, -.1]){
            cylinder(r=rc, h=h+1);
        }
        
    }
}
