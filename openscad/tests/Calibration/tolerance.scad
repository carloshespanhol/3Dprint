$fn=200;

x=60;
y=16;
h=4;
r=4;
d=6;

tolerance();

module hex(s=6, h=10){
    d=s/(sqrt(3)/2);
    cylinder(d=d, h=h, $fn=6);
}

module tolerance(){
    // pin
    translate([6*(8.6+6/10)-2.5,y-6,-.1])
    hex(d, h=h);
    // Text
    for (i = [1:6]) {
        translate([i*(8.6+i/10)-4, 1, h])
        linear_extrude(.6)
        text(str(i), 4);
    }
    // Holes
    difference(){
        rcube(x,y,h,r);
    
        for (i = [1:6]) {
            translate([i*(8.6+i/10)-2.5,y-6,-.1])
            hex(d+i/10, h=h+1);
        }
    }
}


module rcube(length,width,height,r=.5){ 
    l=length-2*r;
    w=width-2*r;    
    translate([r,r,0]){
        cylinder(r=r,h=height);    
        translate([0,w,0])
        cylinder(r=r,h=height);    
        translate([l,0,0])
        cylinder(r=r,h=height);    
        translate([l,w,0])
        cylinder(r=r,h=height);    
    }
    // Inner cubes
    translate([0,r,0])
    cube([length,w,height]);
    translate([r,0,0])
    cube([l,width,height]);
}

