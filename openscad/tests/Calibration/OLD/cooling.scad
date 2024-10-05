x=60;
x2=45;
y=8;
z=20;
t=3;
$fn=100;

difference(){
    rotate([-30,0,0])
    hull(){
        translate([(x-x2)/2,y-t/2,z])
        rotate([0,90,0])
        cylinder(d=t, h=x2);
        
        cube([x,y,.1]);        
    }
    
    translate([x/2,0,z/2])
    rotate([-90,0,0])
    cylinder(d=14, h=x2);

    translate([-.1, -.1, -20])
    cube([x+1,y+5,20]);        
    
}
