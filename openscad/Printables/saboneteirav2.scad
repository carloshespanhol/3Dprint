w=70;
t=2;
r=10;

translate([-78,-55,0])
import("/home/hespanhol/3D Print/stl_files/Ribs Soap Dish.stl");

color("blue")
translate([0,r,r])
rotate([0,90,0])
cylinder(d=r*2, h=t);

color("blue")
translate([0,w-r,r])
rotate([0,90,0])
cylinder(d=r*2, h=t);

