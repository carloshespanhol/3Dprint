use <../lib.scad>
$fn=100;

lineHeight = 0.20;
lineWidth = 0.88;

length=30;
height=10;
width=20;
t=lineWidth+0.01;
bottomthickness=1;

/**************************/
l = length; //multiple(length,lineWidth); 
w = width; //multiple(width,lineWidth); 
h = height; //multiple(height,lineHeight);
echo(w);
echo(h);

/*
translate([0,0,t]){
    xrtriangle(5,5,length);
    translate([0,length,0])
    rotate([90,0,0])
    xrtriangle(5,5,length);

    yrtriangle(5,5,length);
    translate([width,0,0])
    rotate([0,-90,0])
    yrtriangle(5,5,length);
}
*/
difference(){
    cube([w,l,h]);
    
    translate([t,t,-0.32])
    cube([w-t*2,l-t*2,h*2]);
    
    //translate([t*2,l/4,0])    cube([w*2,l/2,2]);    
}    