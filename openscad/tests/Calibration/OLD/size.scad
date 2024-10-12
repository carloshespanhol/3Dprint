$fn=200;

lw=0.8;
x=60;
y=20;
h=4;
r=4;
d=6.5;
t=3;

size();


module size(){
    difference(){
        rcube(x,y,h,r);
        
        translate([t,t,1])
        rcube(x-t*2,y-t*2,h,r/2);
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

