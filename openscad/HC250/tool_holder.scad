use <../lib.scad>
$fn=64;
size=150;
width=22;
thick=4;
type=2;

difference(){
    union(){
        roundCube(size,width,thick,2);
        cube([size,thick,thick*2]);
        
        translate([0,4,0])
        rotate([90,0,0])
        roundCube(width,width,thick,2);
        
        if(type==1){
            translate([size-width,4,0])
            rotate([90,0,0])
            roundCube(width,width,thick,2);
        }
        if(type==2){
            translate([20,-20+thick,0])
            cube([2,20,15]);
        }
        
        // Hook
        for(i = [0:1]) {
            translate([7+(25*i),21,0])
            union(){
                translate([0,0,3])
                rotate([0,90,0])
                roundCube(3,8,3,0.5);
                
                translate([0,7.6,0])
                rotate([30,0,0])
                roundCube(3,6,3,0.5);
            }
        }
    }
           
    // Screws
    translate([10,7,12])
    rotate([90,0,0])
    cylinder(h=10,d=5.5);

    translate([size-10,7,12])
    rotate([90,0,0])
    cylinder(h=10,d=5.5);
    
    // Pliers
    for(i = [0:2]) {
        translate([9+(15*i),13,-1])
        cylinder(h=10,d=12.5);
    }   
    // Hex drives
    for(i = [1:4]) {
        translate([43+(7*i),13,-1])
        cylinder(h=10,d=2.5+i/2);
    }   
    
    // Caliper
    translate([78,10,-0.1])
    roundCube(20,8,10,2);    
    
    // Pliers
    for(i = [0:2]) {
        translate([110+(15*i),13,-1])
        cylinder(h=10,d=13);
    }   
}

