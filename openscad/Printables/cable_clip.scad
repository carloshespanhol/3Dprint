use <../lib.scad>

i=22;

t=3;
l=i*2+t*3;
h=i+t*2;  
w=30;

r1=4;
r2=3;
echo( l);


translate([0, l/2-t/2, 0])
cube([w,t,h]);        

difference(){
    rotate([90,0,90])
    union(){        
        rcube(l, h, w, r1);

        rcube(l, h/1.5, w, r2);        
    }
    
  //  translate([-.1,t,t+.5])    cube([l,l-t*2,5]);

    translate([-.1,t,h-t])
    rotate([0,90,0])
    rcube(h-t*2,l-t*2,w+1,r2-t/2);


    translate([-.1,l/4,-.1])
    cube([w+1,l/2,5]);
}
