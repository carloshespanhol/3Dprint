$fn=100;

t=1.5;
s=20;

translate([-s/2,-s/2,0])
cube([s,s,t]);

hull(){
    translate([s/2-t*3,-s/2,0])
    cube([t*3,s,t]);
    
    translate([s/2-t*2,-s/4,t])
    cube([t*2,s/2,t*2]);
}    

hull(){
    translate([s/2-t*2,-s/4,t])
    cube([t*2,s/2,t*2]);

    translate([0,0,s/4])
    sphere(d=t*2);
}    
