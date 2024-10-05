use <../lib.scad>
$fn=100;

w=7;
l=15;
si=35;

h=7;
t=1.25;
r=10;
rc=5;
di=20;

difference(){
    union(){
        rcube(w,l,t,1);
        
        translate([0, 0, 0])
        cylinder(d=10, h=h);
            
        /*
        translate([s/2, s/2, 0])  
        cylinder(d=di+t*4, h=h*2);
        
        // Right
        translate([s, s/2, 0]){
            cylinder(r=rc, h=h);
            
            translate([-rc-t, -rc, 0])
            rcube(rc+t, 6*t, h, .5);
        }
        /**/
    }
            translate([-4, 5, -.1])
            rcube(5,l-2,t+1,1);            
    
            translate([-10, -1, 2])
            rcube(50, 2, 10,1);
        


       translate([0,0, t])
        cylinder(d1=7, d2=5, h=h+10);
    /*
    translate([s/2, s/2, -.1])  
    cylinder(d=di, h=h+100);
    /**/
}
