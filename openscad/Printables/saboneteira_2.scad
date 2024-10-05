use <../lib.scad>

l=90;
w=70;
h=6;
t=4;
s=l/6;


difference(){
    union(){
/*
translate([-w/2,-l/2,0])
quadx(h/4,h/2,w,l);
*/
translate([-w/2,-l/2,0])
nccube(t,l,t/2);
translate([w/2-t,-l/2,0])
nccube(t,l,t/2);


translate([0,s*3,0])
translate([-w/2,-t/2,0])
nccube(w,h/2,h);
translate([0,-s*3,0])
translate([-w/2,-t/2,0])
nccube(w,h/2,h);
translate([0,s,0])
translate([-w/2,-t/2,0])
nccube(w,h/2,h);
translate([0,-s,0])
translate([-w/2,-t/2,0])
nccube(w,h/2,h);

translate([0,0,0])
translate([-w/2,-t/2,0])
nccube(w,h/2,h);
translate([0,s*2,0])
translate([-w/2,-t/2,0])
nccube(w,h/2,h);
translate([0,-s*2,0])
translate([-w/2,-t/2,0])
nccube(w,h/2,h);
    }
    
    translate([0,l,t-w/7])
    ycylinder(w/4,l*2,false);
}    
/*
translate([0,0,-5])
difference(){
    intersection(){
        import("/home/hespanhol/stl_files/SoapHolder.stl");

        cube([70,110,100],true);
    }    
    
    cube([70,110,10],true);    
}    
/**/