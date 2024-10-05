$fn=200;


difference(){
    cylinder(d=50, h=10);
    
    translate([0,0,-.1]){
    cylinder(d=30, h=11);
    
    cube([50,.1,11]);
    }
}