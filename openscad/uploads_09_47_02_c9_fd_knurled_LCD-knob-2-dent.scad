// Knob for RAMPS LCD
include <knurledFinishLib_v2.scad>
$fn=0;
$fs=0.1;
r_main=18.3;
r_insert=3.2;
h_inner=6;
h_main=8;
dent_width=12;
dent_depth=1.5;
//knurl_help()
difference() {
knurl(k_cyl_hg=h_main, k_cyl_od=r_main*2, s_smooth=40); //cylinder(r=r_main, h=h_main);
  difference(){  
  translate ([0,0,h_inner/2])
  cylinder(r=r_insert, h=h_inner, center=true);
  translate ([-3.5,-5,0])
    cube([2,10,h_inner]);
  }
  translate ([-r_main/2,0,dent_width + h_main - dent_depth])
    sphere(dent_width);
}
