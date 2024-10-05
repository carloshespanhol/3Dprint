use <../lib.scad>
$fn=200;

/* Diametro interno */
d=97; 
d=170;


w=2; // wall
r=4;
t=1;
h=12;
bottom=1;

difference(){
    union(){
        // bottom
        cylinder(d=d-r,h=t);

        translate([0,0,r])
        rotate_extrude(convexity = 10)
        translate([d/2-r+w, 0, 0])
        circle(r = r);
        
        // upper
        translate([0,0,r])
        cylinder(d=d+w*2,h=h-r);
    }
    
    translate([0,0,r-w+t])
    cylinder(d=d,h=h);

    translate([0,0,r-w+t])
    rotate_extrude(convexity = 10)
    translate([d/2-(r-w) , 0, 0])
    circle(r = r-w);

    /* Lid diameter */
    translate([0,0,r+t])
    cylinder(d1=d,d2=d-1,h=h-r-t+.1);
   
    /* Lid bottom thickness */
    translate([0,0,t])
    cylinder(d=d-(r-w)*2,h=h);

    /* Lid bottom */
    if(bottom != 1){
        translate([0,0,-.1])
        cylinder(d=d-20,h=h);
    }
}        