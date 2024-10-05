use <../lib.scad>
$fn=100;

radius=2;
length=30;
width=20;
height=6;
thick=1;

translate([0,0,length-radius])
rotate([0,90,0])
cover();

module cover(){
    
    translate([length/2-radius/2-thick,0,height/2-thick])
    union(){
        translate([0,width,0])
        cube([length/2,15,thick]);

        translate([0,width+15,0])
        cube([length/2,thick,15]);
    }
    
        translate([length/2,width/2,height/2])    difference(){
        roundedCube(length,width,height*2,radius);
        
        translate([-.1,-.1,height]) 
        ccube(length+.5,width+.5,height*2,radius);
        
        rccube(length-(2*thick),width-(2*thick),height*2-thick*2,radius);

        translate([length/2-radius/2+0.01,0,-radius]) 
        ccube(radius,width,height+radius*2);
        
    }
}    