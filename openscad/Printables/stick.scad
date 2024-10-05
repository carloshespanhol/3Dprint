$fn=100;

l=260;
w=5;
d=25;

rotate([0,0,-40])
difference(){
    hull(){
        cylinder(d=w, h=.5);
        
        translate([d,-w/2,0])
        cube([l-d,w,w]);
    }

    
    hull(){
        translate([l-w*2,-w/2-.1,w/2])
        cube([w,w+1,w]);
        
        translate([l-d,-w/2-.1,w-.1])
        cube([w,w+1,w]);
    }
}
