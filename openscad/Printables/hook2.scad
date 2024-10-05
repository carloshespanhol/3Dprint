use <../lib.scad>
$fn= 64;  // Circle 


t=4;
d=50;
w=18;
l=85;
lu=l/3*2;
ll=l/3;

// Upper
translate([0,ll,0])
difference(){
    roundCube(d+t,lu+t,w,4);
    
    translate([-t,-t,-1]) 
    nccube(d,lu,w+3);    
}    

// Lower
translate([0,-1.5,0])
rotate([0,0,-15])
difference(){
    translate([t,0,0]) roundCube(d/3*2,ll*1.7,w,4);
    
    translate([0,t*2,-1]) roundCube(d/3*2+t,ll*1.7,w+3,4);    
}    

hull(){    
    translate([d-.1,l-lu/3*2,0])
    cylinder(d=t*2,h=w);    
    
    translate([d-.1,l-lu,0])
    cylinder(d=t*2,h=w);    
    
    translate([d-t*4+1,-t-2,0])
    cylinder(d=t*2,h=w);
}    