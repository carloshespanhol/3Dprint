use <../lib.scad>
$fn=100;

l=60;
w=l/2;
h=6;
r=6;
s=4;
c=w-s*2;
type=0;

if(type==1){
    translate([w/2,w/2,h/2])
    cylinder(d=c/3, h=h/2);
}

difference(){
    translate([-r,0,0])
    union(){
        translate([w-r,0,0])
        rcube(l+r*2-w,w,h/2,r);
        
        if(type==1){
          rcube(l/2+r,w,h,r);       
        }
    }
    //---------------------
    translate([w/2,w/2,h/6*5])
    cylinder(d=c, h=h/4+1);
    translate([w/2,w/2,h/6*4])
    cylinder(d=c/3, h=h/4+1);
    
    translate([w/2+w,w/2,h/6*2])
    cylinder(d=c, h=h/4+1);
    translate([w/2+w,w/2,h/6])
    cylinder(d=c/3, h=h/4+1);
    
    // cut
    translate([-r*2,-1,-1])
    cube([r*2,w+2,h+2]);
    
    /* bridge
    translate([w/2-c/2,-1, h/8])
    hull(){
        cube([c/3*2,w+2,.1]);    
        
        translate([h/4, 0, h/4])
        cube([c/3*2-h/4,w+2,.1]);    
    }
    /**/
}

