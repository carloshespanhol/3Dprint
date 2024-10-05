use <../lib.scad>
$fn=100;

lineWidth = 0.68;
lineHeight = 0.28;

holes_dist = 54;
size=68;
m3=3.4;
m5=5.4;

ws=1;       // width of slot
width=5;
height=20;

w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
t=5;
echo(w);
echo(h);

//%translate([-20,0,0]) nccube(20,20,50);

translate([-13,0,0])
scube(6,4,4);

difference(){
    union(){
        rotate([0,0,-10])
        translate([0,-25,0])
        scube(t,size,h);

        translate([-20,-t,0])
        scube(20,t,h);
        
        translate([0,20,0])
        mirror([0,1,0])
        rtriangle(8,h,10);
    }    
    // M3 screws
    translate([-t,-18,h/2])
    rotate([0,0,-10]){
        rotate([0,0,90])
        vcylinder(d=m3,h=10);
        translate([0,holes_dist,0])
        rotate([0,0,90])
        vcylinder(d=m3,h=10);
    }
    // M5 screw
    translate([-10,10,h/2])
    vcylinder(d=m5,h=20);
}   