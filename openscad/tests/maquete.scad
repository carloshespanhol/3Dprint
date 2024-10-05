use <../lib.scad>
$fn= 100;

lw=.4;

x=60;
y=20;
t1=.8;
t2=.8;
h=10;
r=1;

difference(){
    union(){
        rcube(x,y,t1,.1);    //base

        rcube(1.5,t2,h,.1);

        // X walls
        translate([x/11,0,0])
        rcube(x/3,t2,h,.1);

        translate([0,0,h/4*3])  //upper
        rcube(x/3*2,t2,h/4,.1);

        translate([0,y/3*2,0])
        rcube(x*.18+.5,t1,h,.1);

        translate([x-8,0,0])
        rcube(8,t1,h,.1);


        // Y walls
        translate([x*.18,t1/2,0])  //
        rcube(t1,y-t1/2,h,.1);

        translate([x*.35,t1/2,0])  //
        rcube(t2,y-t1/2,h,.1);

        translate([x-15,y/3*2,0])  //
        rcube(t2,y/3,h,.1);
    }
    
    // window
    translate([2,y/2,h/2])
    rcube(x/10,y,3,.1);
    // door
    translate([10,2,t1])
    rcube(x*.25,3,5,.1);    
}