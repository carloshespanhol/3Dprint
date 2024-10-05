use <../lib.scad>
$fn=100;

difference(){
    translate([0,-15,0])
    rccube(20,20,10,2);
    
    ycylinder(5,30);
}
