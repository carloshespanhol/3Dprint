use <../lib.scad>
$fn=200;
cf=.4;  // Fit
cl=.3;  // Cleareance

ct=.3;  // Thread

lw=0.64;    // linewidth

h=1.4;
iw=7;
l=14;
w=iw + lw*6;
echo(w);

difference(){
    rcube(l,w,h*2,3);
    
    translate([w/3,w/2,-.1])
    cylinder(d=iw, h=h*3);

    translate([-.1,w/2-(iw-2)/2,-.1])
    scube(iw/2,iw-2,h*3);

    translate([-.1,w/2-iw/4,-.1])
    scube(l-lw*6,iw/2,h*3);
    
    // top cut
    translate([-.1,-.1,h])
    scube(l-lw*3,w+1,h*2);
}    