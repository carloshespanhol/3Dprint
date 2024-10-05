use <../lib.scad>
$fn=200;

s=175;
h=4;
r=5;
d=h/3;

t=15;




difference(){
    union(){

        hull(){            
            translate([d,d,0])
            rcube(s-2*d,s-2*d,.1,r);
            
            translate([0,0,h-.1])
            rcube(s,s,.1,r);            
        }
    }

    translate([t,t,-.1])
    cube([s-t*2, s-t*2, h+1]);
}