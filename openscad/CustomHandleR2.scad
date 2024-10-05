//// File: CustomHandleR2.scad
//// Version: OpenSCAD 2015.03-2
//// Author: Kijja Chaovanakij
//// Date: 2018.07.11

// Revise-1: 2018.07.30
// - Change input size of square hole or hexagon hole from diagonal dimension to opposite side dimension.
// Revise-2: 2020.07.11
// - Rewrite for faster rendering
// - Remove some features
// Revise-3: 2020.07.13
// - bug fix about groove

//smoothness
smooth=3; //[1:high, 2:medium, 3:low]
//hole tolerance[0.66]
tol=0.66; //[0.5:0.02:0.8]
//test hole size (used together with collet)
test_hole=0; //[0:no, 1:yes]

/*[option]*/
//shape of the hole
hole_shape=1; //[0:round, 1:hexagon, 2:square]
//add the shield
shield=0; //[0:no, 1:yes]
//add the collet
collet=1; //[0:no, 1:yes]
//hole at the end of the handle
end_hole=0; //[0:no, 1:yes]

/*[hole]*/
//diameter of the round hole[8]
hole_dia=8; //[3:0.1:30]
//side to opposite side of the hexagon hole or the square hole[6.24]
hole_size=6.24; //[4:0.02:30]
//depth of the hole[80]
hole_dep=90; //[5:1:150]

/*[handle] */
//diameter of the handle[28] >= (hole diameter+7mm.)
handle_dia=28; //[10:1:80]
//length of the handle[100]
handle_len=100; //[10:1:150]
//number of the grooves
n_groove=5; //[0:1:8]

/*[collet] */
//diameter of the collet[15] >= (hole diameter+5mm.)
collet_dia=15; //[8:1:35]
//length of the collet[6]
collet_len=6; //[5:1:25]

/*[shield]*/
//width of the shield
shield_wid=12; //[10:1:30]
//thickness of the shield 
shield_thi=3; //[2:0.1:5]

/*[Hidden]*/
$fa=3;
$fs=smooth/2;

//======== main ========//
if (shield==1)
  echo("total handle length=", handle_len+shield_thi);
else if (collet==1)
  echo("total handle length=", handle_len+collet_len);
else
  echo("total handle length=", handle_len);

if (test_hole==1)
  test_hole();
else
  rotate([90, 0, 0])
  translate([0, 0, -handle_len/2])
  handle();

module handle(){
  difference(){
    union(){
      color("Goldenrod")
      rotate_extrude()
      difference(){
        square([handle_dia/2, handle_len]);
        translate([handle_dia/2, 0])
        rotate([0, 0, 90])
          chamfer(size=handle_dia/5);
        if (shield==0)
          if (collet==0)
            translate([handle_dia/2, handle_len])
            rotate([0, 0, 180])
              chamfer(size=handle_dia/5);
          else if (collet==1)
            if (collet_dia <= handle_dia)
              translate([handle_dia/2, handle_len])
              rotate([0, 0, 180])
                chamfer(size=handle_dia/2-collet_dia/2);
      }//d
      if (shield==1)
        add_shield();
      else if (collet==1)
        add_collet();
    }//u
    groove();
    cut_center_hole();
    if (end_hole==1)
      cut_end_hole();
  }//d
}//m
//

module add_shield(){
  color("Gold")
  translate([0, 0, handle_len])
  rotate_extrude()
  union(){
    square([handle_dia/2+shield_wid-shield_thi/2, shield_thi]);
    translate([handle_dia/2+shield_wid-shield_thi/2, shield_thi/2])
      circle(d=shield_thi, $fn=32);
  }//u
}//m
//

module add_collet(){
  color("Gold")
  translate([0, 0, handle_len])
  rotate_extrude()
    difference(){
      square([collet_dia/2, collet_len]);
      translate([collet_dia/2, collet_len])
      rotate([0, 0, 180])
        chamfer(size=2, $fn=32);
    }//d
}//m
//

module groove(){
  $fn=48;
  for (i=[0:1:n_groove-1])
    rotate([0, 0, i*360/n_groove])
    translate([handle_dia/2*1.3, 0, 0])
      rotate_extrude()
      difference(){
        hull(){
          for (j=[handle_len*0.1, handle_len*0.9])
            translate([0, j, 0])
              circle(d=handle_dia*0.45);
        }//h
        translate([-handle_dia, -handle_dia/2, 0])
          square([handle_dia, handle_len+handle_dia]);
      }//d
}//m
//

module cut_center_hole(){
  ep=0.001;
  translate([0, 0, handle_len-hole_dep-ep])
  linear_extrude(hole_dep+collet_len+shield_thi)
  if (hole_shape==0)
    circle(d=hole_dia+tol);
  else if (hole_shape==1)
    circle(d=hole_size/cos(30)+tol, $fn=6);
  else if (hole_shape==2)
    circle(d=hole_size/cos(45)+tol, $fn=4);
}//m
//

module cut_end_hole(){
  translate([handle_dia/2*0.5, 0, 0])
  rotate([0, 40, 0])
    cylinder(h=handle_dia, d=2.4, center=true, $fn=32);
}//m
//

module chamfer(size=2){
  ep=0.001;
  translate([-ep, -ep])
  difference(){
    square([size, size]);
    translate([size, size])
      circle(r=size);
  }//d
}//m
//

module test_hole(){
  translate([0, 0, -handle_len])
  difference(){
    add_collet();
    cut_center_hole();
  }//d
}//m
//