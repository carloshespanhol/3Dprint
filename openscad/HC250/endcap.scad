use <../lib.scad>
$fn=200;
t=4;
f=1.2;
  
*%translate([-10,-10,t-2.5])
import("stl/Misumi_2020_Endcap_80u__v1-0.STL");



endcap(10);
//rotate([-90,0,0])
*_insert();


module endcap_grid(x=40, y=40, h=8, th=2, bolt_hole=0, min_side_length=20) {
    repeat_grid([x/min_side_length, y/min_side_length, 1], 
                [min_side_length+5,min_side_length+5,0])
    endcap(h=h, th=th, min_side_length=min_side_length, bolt_hole=bolt_hole);
}

module endcap(h=10,r=1.5) {
    l=7.4;
    s = 20;

    translate([-s/2,-s/2,0])
    frcube(20,20,t,r,f);
        
    translate([0,0,h/2])
    rotate([-90,0,0])
    {
          translate([0,0,-l/2])rotate([0,180,0])_insert(h);
          translate([0,0,l/2])_insert(h);
          translate([l/2,0,0])rotate([0,90,0])_insert(h);
          translate([-l/2,0,0])rotate([0,-90,0])_insert(h);      
    }
}
module _insert(h=10) {
    // x
    lb=11;
    ls=5.5;
    // z
    d=4.25;
    t=1.5;
    
    hull(){
        translate([-lb/2,-h/2,d-t])
        rcube(lb,h,t,1);

        translate([-ls/2,-h/2,0])
        rcube(ls,h,t,1);
    }
    // Chanel
    c=6;
    translate([-c/2,-1,0])
    hull(){
        translate([0,-4,3])
        rcube(c,c,1,.25);
        
        translate([0,4,c/2])
        rotate([90,0,0])
        rcube(c,c/2,1,.25);
    }
}
