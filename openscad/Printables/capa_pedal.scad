use <../lib.scad>
$fn=200;

/* Mangote
mz=50;
d1=8;
d2=30;
est=6;
*/

x=101;
y=79.5;
y2=70;
z=60;
z2=30;
t=3;
ti=4;
r=4;

sy=y/2;
sz=8;

fx=17;  // largura do flat
fz=2.5; // altura do flat

jd=17; // diametro joystick

jsx = 31/2;

supy=16; //suporte parafuso lateral
supz=16;

color("lightgrey")
difference(){
    hull(){
        translate([-t-x/2,-t,-r])
        rbox(x+t*2,y+t*2,z2+t*2,r);
        translate([-y2/2,-t,-r])
        rbox(y2,50,z,r);
    }
    //---------------------------
    translate([-x,-t,-10])
    cube([x*2,y*2,10]);
    
    hull(){
        translate([-x/2+ti,ti,-r-.1])
        rbox(x-ti*2,y-ti*2,z2,r*2);
        translate([-y2/2,0,-r])
        rbox(y2,50-ti,z-t,r);
    }
    
    //screws
    translate([-t-x/2,sy,sz])
    rotate([0,-90,0])
    Mscrew(20);
    
    mirror([1,0,0])
    translate([-t-x/2,sy,sz])
    rotate([0,-90,0])
    Mscrew(20);
    
    //flat cable
    translate([-fx/2, y/2, -5])
    vrcube(fx,y,fz+5,2);
    
    //suporte interno
    translate([-x/2, sy+supy/2, -1])
    rotate([0,0,-90])
    vrcube(supy,x,supz+1,1);
    
    //joystick
    translate([0, -t*2, z/2])
    rotate([-90,0,0])
    cylinder(d=jd, h=y/2);
    
    //screws
    translate([-cos(45)*jsx,-t,sin(45)*z/2])
    rotate([90,0,0])
    Mscrew(20);
    translate([cos(45)*jsx,-t,z-(sin(45)*z/2)])
    rotate([90,0,0])
    Mscrew(20);
}