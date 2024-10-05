$fn=200;
fit=.3;
use <../lib.scad>
s=25.4;
a=10;

// speaker
*translate([26.5,10,5.5])
vrcube(40,2,40,8);

box();


*translate([200+5,0,0])
//translate([cos(a)*100,sin(a)*100,0])
//rotate([0,0,a])
mirror([1,0,0]) box();

module box(){
    difference(){
        scale([s,s,s])
        translate([-0.311,-0.017,-0.012])
        import("/home/hespanhol/3D Print/stl_files/Bose_V1.stl");

        *translate([0,-5,0])
        cube([100,5,50]);
        *translate([100-3.5,-1,0])
        cube([10,159,50]);
        
        dist=31.5;
        *translate([30.55,0,9.5])
        for( i = [0:1] ){
            for( j = [0:1] ){
                translate([i*dist,0,j*dist])
                rotate([-90,0,0])
                cylinder(h=10,d=1);
            }
        }
    }    
}