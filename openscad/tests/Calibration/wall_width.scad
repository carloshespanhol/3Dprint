$fn=200;
lw=0.8;
cube([40+5,20,.6]);

wall(lw*2,20,5);

translate([10,0,0])
wall(lw*3,20,5);

translate([20,0,0])
wall(lw*4,20,5);

translate([30,0,0])
wall(4,20,5);

translate([40,0,0])
wall(5,20,5);


module wall(x,y,z){
    difference(){
        hull(){
            translate([0,x,0])
            cylinder(r=x,h=z);
            
            translate([0,y-x,0])
            cylinder(r=x,h=z);
        }
        
        translate([-x-.1,-.1,-.1])
        cube([x+.1,y+1,z+1]);
        
    }
}