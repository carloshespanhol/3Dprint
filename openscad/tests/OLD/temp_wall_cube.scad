$fn=64;
h=40;

difference(){
    cube([20,20,h]);
    
    translate([1,1,-1])
    cube([18,18,h+2]);
    
    // Circles
    for(i=[0:3]){
        translate([10,2,5+(h/4*i)])
        rotate([90,0,0])
        cylinder(d=8,h=20);
    }

    // Squares
    for(i=[0:3]){
        translate([7,22,2+(h/4*i)])
        rotate([90,0,0])
        cube([6,6,6]);
    }
}    
