use <../lib.scad>
$fn=200;

l=60;
w=25;
t=.64;

e=10;
h=2;



rcube(w,l,t,2);

difference(){
    union(){

        
        translate([w/2,0,0])
        cylinder(d=w, h=h);
    }
    
    translate([w/2,0,-.1])
    cylinder(d=w/3, h=h+1);
    
    // Upper cut
    translate([0,0,t])
    rcube(w,l,h,0.1);

    // Chamfer
    translate([0,-w/2-4,h])
    rotate([-30,0,0])
    rcube(w,l,h*2,0.1);
}

/*
difference(){
    cylinder(d=s, h=t);
    
    translate([0,0,-.1])
    cylinder(d=is, h=t*2);
}    
*/