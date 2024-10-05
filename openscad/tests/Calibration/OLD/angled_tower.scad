l=50;
w=60;
t=8;
a=45;


difference(){
    union(){
        translate([-3,0,-t/2])
        rotate([0,-a,0])
        cube([l,w,t]);
        
        translate([-3,0,0])
        cube([l/2,w,0.44]);
    }    
    
    translate([-l,-w/2,-l])
    cube([l*2,w*2,l]);
}