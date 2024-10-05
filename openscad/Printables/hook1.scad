$fn=100;
h=40;

difference(){
    rotate([0,-45,0])
    translate([0,0,-7]) 
    union(){
        cylinder(d=15,h=h);
        
       // translate([0,0,h])  sphere(7.5);
    }

    //translate([-h*1.2,-15,0])    cube([30,30,30]);
    
    translate([0,0,-15])    cube([30,30,30],center=true);
}    