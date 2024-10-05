use <../lib.scad>

sl=95;
sw=55;
t=4;
/*********/
l=90;
w=70;
h=6;
s=l/6;
tw=t/5*3;

difference(){
    union(){
/*
translate([-w/2,-l/2,0])
quadx(h/4,h/2,w,l);
*/
translate([-w/2,-l/2,0])
#scube(tw,l,h+t);
translate([w/2-t/2,-l/2,0])
scube(tw,l,h+t);


translate([0,s*3,0])
translate([-w/2,-t/2,0])
scube(w,tw,h+t);
translate([0,-s*3,0])
translate([-w/2,0,0])
scube(w,tw,h+t);
        
translate([0,s,0])
translate([-w/2,-t/2,0])
scube(w,h/2,h);
translate([0,-s,0])
translate([-w/2,-t/2,0])
scube(w,h/2,h);

translate([0,0,0])
translate([-w/2,-t/2,0])
scube(w,h/2,h);
translate([0,s*2,0])
translate([-w/2,-t/2,0])
scube(w,h/2,h);
translate([0,-s*2,0])
translate([-w/2,-t/2,0])
scube(w,h/2,h);
    }
    
    //translate([0,0,0])
    //ycylinder(w/4,l*2,false);
    ccube(w/4,l*2,h);
    
    translate([-w/8-1,0,0])
    rotate([0,45,0])
    ccube(h/2,l*2,h);
    translate([w/8+1,0,0])
    rotate([0,-45,0])
    ccube(h/2,l*2,h);
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