use <../lib.scad>

length=30;
height=15;
width=30;
t=1.36;
bottomthickness=2.4;
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
    cube([width,length,height]);
    
    translate([t,t,-1])
    cube([width-t*2,length-t*2,height*2]);
}    