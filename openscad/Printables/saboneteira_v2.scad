$fn=200;
w=70;
l=80;
t=3;
r=10;
num=6;
dist=(l-t)/num;

*translate([-78,-55,0])
import("/home/hespanhol/3D Print/stl_files/Ribs Soap Dish.stl");

for(i=[0:dist:l]){
    translate([i,0,0])
    piece();
}

translate([0,r,r])
rotate([0,90,0])
cylinder(d=5, h=l);
translate([0,w-r,r])
rotate([0,90,0])
cylinder(d=5, h=l);


module piece(){
difference(){
    union(){
        translate([0,w/4,0])
        cube([t,w/2,r*2]);

        hull(){
            translate([0,r,r])
            rotate([0,90,0])
            cylinder(d=r*2, h=t);

            translate([0,0,r*1.4]){
                translate([t/2,r*2,0])
                cylinder(d=t, h=.1);
                translate([t/2,w-r*2,0])
                cylinder(d=t, h=.1);
            }
            
            translate([t/2,r/2,0])
            cylinder(d=t, h=.1);
            translate([t/2,w-r/2,0])
            cylinder(d=t, h=.1);
        }
        hull(){
            translate([0,w-r,r])
            rotate([0,90,0])
            cylinder(d=r*2, h=t);

            translate([0,0,r*1.4]){
                translate([t/2,r*2,0])
                cylinder(d=t, h=.1);
                translate([t/2,w-r*2,0])
                cylinder(d=t, h=.1);
            }

            translate([t/2,r/2,0])
            cylinder(d=t, h=.1);

            translate([t/2,w-r/2,0])
            cylinder(d=t, h=.1);
        }
    }
    //-----------------------------------
    d2=w*2;
    difference(){
        translate([-.1,w/2,d2/2+r+6])
        rotate([0,90,0])
        cylinder(d=d2, h=t+1);
        
        cube([t+1,w,r*1.7]);
    }
}    
}