use <../lib.scad>
$fn=64;

lineHeigth=0.20;
lineWidth=0.80;

diam=50;
height=50;
width=10;
length=10;
thickxy=1;
thickz=1;

lamp();
//support();

/************************************/
w=multiple(width, lineWidth);
l=multiple(length, lineWidth);
h=multiple(height, lineHeigth);
txy=multiple(thickxy, lineWidth);
tz=multiple(thickz, lineHeigth);
t=txy*2;

module support(){
    difference(){
        union(){             
            translate([diam/2,-t/2,0])
            nccube(l,t,w);

            translate([diam/2+l,t/2,w/2])
            rotate([90,0,0])
            cylinder(d=w*1.15, h=t, $fn=6);            

            translate([diam/2+l,t*.6,0])
            nccube(l*1.5,t,w);

            translate([diam/2+l,t*1.6,w/2])
            rotate([90,0,0])
            cylinder(d=w*1.15, h=t, $fn=6);
        }
        //--------------------------------
        // Hole
        translate([diam/2+l,t*2,w/2])
        rotate([90,0,0])
        cylinder(d=3.5, h=l); 
    }

    translate([diam/2+l*2+t,-w*.51,w/2])
    rotate([0,0,90])
    difference(){
        union(){   
            translate([0,-t,-w/2])
            nccube(l*1,t,w);

            rotate([90,0,0])
            cylinder(d=w*1.15, h=t, $fn=6);
        }
        //--------------------------------
        // Hole
        rotate([90,0,0])
        cylinder(d=3.5, h=l); 
    }
}

module lamp(){
    difference(){
        union(){ 
            cylinder(d=diam, h=h);
            
        }
        //--------------------------------
        translate([0,0,tz])
        cylinder(d=diam-txy*2, h=h*2);

        translate([0,0,-tz])
        cylinder(d=diam-txy*6, h=h*2);
        
        // Hole
        translate([diam/2+l,t,w/2])
        rotate([90,0,0])
        cylinder(d=3.5, h=l); 
    }
}
