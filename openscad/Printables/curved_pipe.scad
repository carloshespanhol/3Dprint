// This is a "hack" in that I manually aligned the parts, rather than using sin(), cos(), etc to compute actual proper positions as the pipe length and angle are changed.
dia_in = 2.5; // inches
dia_mm = 2.5*25.4; //mm
thickness = .1*25.4; //" to mm
alpha = .5; //< 1 for transparency
angle=60;

$fa=1; // 1 degree angles (smoothness of pipe)

color("red",alpha)
pipe();

// -.05 ensures overlap, needed for secure 3D Printing
color("blue",alpha)
translate([0,0,7*25.4])
rotate([90,0,0])
elbow();

color("greenyellow",alpha)
translate([(dia_mm*cos(angle))-dia_mm, 0, dia_mm*sin(angle)])
translate([0,0,7*25.4])
rotate([0,-angle,0])
pipe();

module pipe(length=7*25.4){
  difference(){
    cylinder(d=dia_mm, 
             h=length);
    translate([0,0,-.1])
    cylinder(d=dia_mm-2*thickness, 
             h=length+.2);
  }
}

// rotate_extrude test
module elbow(){
  translate([-dia_mm, 0, 0])
  rotate_extrude(angle=angle)
  translate([dia_mm, 0, 0])
  difference(){
    circle(d = dia_mm);    
    circle(d = dia_mm-thickness*2);
  }
}

