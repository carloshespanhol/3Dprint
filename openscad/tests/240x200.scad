$fn=200;

x=180;
y=180;
b=10;
t=.2;

//circle();
square();

module circle(){
    difference(){
        cylinder(d=y, h=t);
        
        translate([0,0,-.1])
        cylinder(d=y-b*2, h=t+1);
    }
}

module square(){
    translate([-x/2,-y/2,0])
    difference(){
        cube([x,y,t]);
        
        translate([b,b,-.1])
        cube([x-b*2,y-b*2,t+1]);
    }    
}