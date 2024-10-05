use <../lib.scad>
$fn=64;

lineHeigth=0.20;
lineWidth=0.80;

width=80;
length=80;
height=3.5;
thickxy=20;
thickz=1.2;


/************************************/
w=multiple(width, lineWidth);
l=multiple(length, lineWidth);
h=multiple(height, lineHeigth);
txy=multiple(thickxy, lineWidth);
tz=multiple(thickz, lineHeigth);


difference(){
    union(){ 
        difference(){
            cube([w,l,h]);

            //translate([20,20,-.1]) 
            translate([w,20,-.1]) rotate([0,0,45])
            cube([w,l+5,h+1]);
        }
        translate([0,60,0])
        rotate([0,0,-45])
        cube([w,txy,h]);
    }
    
    // X holes
    translate([28.5,10,-.1])
    cylinder(d=5.5, h=5);
    translate([63.5,10,-.1])
    cylinder(d=5.5, h=5);
    // Y holes
    translate([10,28.5,-.1])
    cylinder(d=5.5, h=5);
    translate([10,63.5,-.1])
    cylinder(d=5.5, h=5);
    
    // Support hole
    translate([l*0.4,w*0.4,-.1])
    cylinder(d=3.5, h=5);
    
    //
    translate([w*1.2,l*1.2,-.1])
    cylinder(d=w*2 , h=h+1);
}

