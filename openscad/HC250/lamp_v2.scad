use <../lib.scad>
$fn=100;

lineHeigth=0.28;
lineWidth=0.60;

diam=50;
height=50;
width=10;
length=10;
thickxy=1;
thickz=2;

lamp();
support();

/************************************/
w=multiple(width, lineWidth);
l=multiple(length, lineWidth);
h=multiple(height, lineHeigth);
txy=multiple(thickxy, lineWidth);
tz=multiple(thickz, lineHeigth);
t=txy*2;
       

module lamp(){
    difference(){
        union(){ 
            cylinder(d=diam, h=h);
            
            translate([diam/2-1,-5,0])
            cube([7,10,10]);
        }
        //--------------------------------
        translate([diam/2+txy,0,5])
        rotate([90,0,90])
        MnutPocket(show_screw=1);

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

module support(){
    difference() {    
        union(){
            hull(){
                cylinder (d=20, h=tz);
                
                translate([-10,1,0])
                cube([3,8,t]);
            }
            
            translate([-10,1,0])
            cube([3,8,diam]);

            translate([-10,5,diam])
            rotate([0,90,0])
            cylinder (d=8, h=3);
        }
        
        translate([0,0,-.1])
        cylinder (d=5.5, h=tz*3);
        
        // Screw
        translate([-15,5,diam])
        rotate([0,90,0])
        cylinder (d=3.5, h=20);
    }
}
