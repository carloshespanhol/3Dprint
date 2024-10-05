use <../lib.scad>
$fn=64;

size= 40;
h=3;
t=1;
w=8;

difference(){
    rcube(size,size,h,2);
    
    translate([t,t,t])
    rcube(size-t*2,size-t*2,h,1);
}    

translate([size+w,0,0])
rcube(w,size,t,w/2);