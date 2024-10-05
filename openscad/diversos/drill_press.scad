use <../lib.scad>
$fn=100;
fit=.1;

x=80;
y=40;
z=25;
t=5;

translate([-30,0,0])
base();

*support();

module support(){
    h=25;
    
    %cube([20,20,150]);
    
    color("lime")
    translate([0,0,70])
    difference(){
        union(){
            hull(){
                translate([10,10,0])
                cylinder(d=40,h=25);
                
                translate([0,-15,0])
                cube([20,10,25]);
            }
        }
        //-------------------------
        translate([0,0,-.1])
        cube([20+fit,20+fit,100]);

        ro=25;
        translate([10,-ro-6,3])
        ring(ro,ro-2,3.5);
        translate([10,-ro-6,h-3-3.5])
        ring(ro,ro-2,3.5);
    }
}    

module base(){
    ws=3.6;
    
    color("grey")
    difference(){
        union(){
            hull(){
                cube([x,y,.1]);
                
                translate([30-t,0,z])
                cube([20+t*2,20+t,.1]);
            }
            // base
            translate([-15,0,0])
            rcube(x+30,y+15,t, 3);

            translate([-15,0,0])
            rcube(x+30,5,25, 3);
        }
        
        translate([30,-.1,-.1])
        cube([20,20,50]);
        translate([30,-1.1,-.1])
        cube([20,20,50]);
        
        translate([30-t,10,z/2])
        rotate([0,-90,0])
        Mscrew(l=50,d=5.5);
        
        translate([50+t,10,z/2])
        rotate([0,90,0])
        Mscrew(l=50, d=5.5);

        translate([x/2,20+t,z/2])
        rotate([-90,0,0])
        Mscrew(l=50, d=5.5);
        
        // Wood Screws
        translate([-5,y/2,-.1])
        cylinder(d=ws, h=50);
        translate([x+5,y/2,-.1])
        cylinder(d=ws, h=50);

        translate([x/2,y+5,-.1])
        cylinder(d=ws, h=50);
    }    
}    