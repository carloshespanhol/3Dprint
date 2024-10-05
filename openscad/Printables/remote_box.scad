use <../lib.scad>
$fn=100;

lineWidth = 0.68;
lineHeight = 0.28;

length=200;
width=50; 
height=100;

hw=60; // phone width
hh=30;
thick=3;

/**************************/
l = multiple(length,lineWidth); 
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
t = multiple(thick,lineWidth);
echo(w);
echo(h);

rotate([0,0,0]){    
difference(){
    rotate([0,0,0]){
        /* Sacrifice bridge *
        translate([w,ch-t,0])
        nccube(lineWidth+0.01,w,h);            
        /**/
        difference(){
            union(){
                translate([0,0,0])
                nccube(w,h,l);

                translate([w,h-t,0])
                nccube(hw,t,l);

                translate([w+hw,h-hh-t,0])
                nccube(t,hh+t,l);

                hull(){
                }
            }
                translate([t,t,t])
                nccube(w-t*2,h,l-t*2);

            /**
            translate([l/6,-h-t/2,-.1])
            rotate([0,0,-20])
            nccube(pw,h*2,w+1);
            
            translate([t*1.25,h/2+t*.25,-.1])
            cylinder(d=t,h=w+1);
            /**/
        }
    }    
}
}