use <../lib.scad>
$fn=200;


di=21;
t=2.5;
l=120;



difference(){
    hull(){
        cylinder(d=di+t*2, h=t);
        
        translate([-di/2-t,l,0])   rcube(di+t*2,t,t, 1);
    }

        translate([0,0,-.1])
        cylinder(d=di, h=t+1);

}