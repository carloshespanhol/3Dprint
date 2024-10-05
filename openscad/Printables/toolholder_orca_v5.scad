// ToolBaseSize
holder_w = 125;
holder_h = 50;
holder_d = 3;

shaft_r = 4.25;

// SquareToolsSize
micrometer_w = 17.6;
micrometer_h =  8;
micrometer_d = 17;
micrometer_s_w = 16;
micrometer_s_h =  13;
micrometer_s_d = 12;
micrometer_w_o = 45;
micrometer_h_o = 30;

tweezers_w = 10;
tweezers_h =  3;
tweezers_d = 10;

spanner_w = 20;
spanner_h = 23;
spanner_d = 40;

nipper_w = 16;
nipper_h = 16;
nipper_d = 10;

scraper_w = 25;
scraper_h = 6.5;
scraper_d = 15;

// RoundtoolsSize
hexkey_r = 4;
hexkey_h =  12;
hexkey_r_o = 10;

screwdriver_r = 12;
screwdriver_h =  15;
screwdriver_r_o = 35;

rotate([180,0,0]){
// Base
difference() {
	translate([-holder_w/2,0,0])union(){
		
		translate([0,holder_h/2-holder_d/2,0])roundedBox([holder_w,holder_h,holder_d],4,true);
		translate([holder_w/2-85,0,-50/2]){
			rotate([90,0,0])cube([22,50,holder_d], center=true);
			translate([-9,0,25])rotate([0,0,90])TriangleSupport(20,20,4);
			translate([9,0,25])rotate([0,0,90])TriangleSupport(20,20,4);
		}
	}
	// MountHole
	translate([-85,holder_d,0]){
		#translate([0,0,-12])rotate([90,0,0])cylinder(r=shaft_r/2,h=holder_d*3,$fn=16);
		#translate([0,0,-37])rotate([90,0,0])cylinder(r=shaft_r/2,h=holder_d*3,$fn=16);
	}

	// ToolHole
	translate([-25,20,-micrometer_d/2+holder_d/2])cube([micrometer_w,micrometer_h,micrometer_d],center=true);
	translate([-5-micrometer_w/2,20,-micrometer_s_d/2+holder_d/2])cube([micrometer_s_w,micrometer_s_h,micrometer_s_d],center=true);
	for (axis = [0:10:20]) {
		translate([-15-axis,40,-hexkey_h/2+holder_d/2])cylinder(r=hexkey_r/2,h=hexkey_h,$fn=16);
	}
	translate([-55,40,-tweezers_d/2+holder_d/2])cube([tweezers_w,tweezers_h,tweezers_d],center=true);
	translate([-59,20,-spanner_d/3])cube([spanner_w,spanner_h,spanner_d],center=true);
	translate([-111,32,-nipper_d/2+holder_d/2])cube([nipper_w,nipper_h,nipper_d],center=true);
	translate([-82,40,-scraper_d/2+holder_d/2])cube([scraper_w,scraper_h,scraper_d],center=true);
	translate([-87,20,-screwdriver_h/2+holder_d/2])cylinder(r=screwdriver_r/2,h=screwdriver_h,$fn=16);
}
union(){
	// DigitalMicrometer
	union(){
		difference() {
			translate([-25,20,-micrometer_d/2+holder_d/2])SquareHole(micrometer_w,micrometer_h,micrometer_d,micrometer_w_o,micrometer_h_o);
			translate([-5-micrometer_w/2,20,-micrometer_s_d/2+holder_d/2])SquareHole(micrometer_s_w-2,micrometer_s_h-2,micrometer_s_d);
			translate([-5-micrometer_w/2,20,-micrometer_s_d+holder_d/2])cube([micrometer_s_w,micrometer_s_h,1],center=true);
		}
		difference() {
			translate([-5-micrometer_w/2,20,-micrometer_s_d/2+holder_d/2])SquareHole(micrometer_s_w,micrometer_s_h,micrometer_s_d);
			translate([-25,20,-micrometer_d/2+holder_d/2])cube([micrometer_w,micrometer_h,micrometer_d],center=true);
		}
	}
	// HexKey
	for (axis = [0:10:20]) {
		translate([-15-axis,40,-hexkey_h/2+holder_d/2])RoundHole(hexkey_r,hexkey_h,hexkey_r_o);
	}
	// Tweezers
		translate([-55,40,-tweezers_d/2+holder_d/2])SquareHole(tweezers_w,tweezers_h,tweezers_d,tweezers_w_o,tweezers_h_o);
	
	// Spanner
	translate([-59,20,-spanner_d/2])SquareBox(spanner_w,spanner_h,spanner_d);

	// Nipper
	translate([-111,32,-nipper_d/2+holder_d/2])SquareHole(nipper_w,nipper_h,nipper_d);

	// Scraper
	translate([-82,40,-scraper_d/2+holder_d/2])SquareHole(scraper_w,scraper_h,scraper_d);

	// Screwdriver
	translate([-87,20,-screwdriver_h/2+holder_d/2])RoundHole(screwdriver_r,screwdriver_h,screwdriver_r_o);
}
}

// size is a vector [w, h, d]
module TriangleSupport(size_w, size_h, size_d)
{
	translate([0,0,-size_h])
 	polyhedron (points = [[0, -size_d/2, size_h], [0, size_d/2, size_h], [0, size_d/2, 0], 
                        [0, -size_d/2, 0], [size_w, -size_d/2, size_h], [size_w, size_d/2, size_h]], 
              triangles = [[0,3,2], [0,2,1],  [3,0,4], [1,2,5], 
                           [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
}

// size is a vector [w, h, d]
module SquareBox(size_w, size_h, size_d)
{
	difference() {
		cube([size_w+holder_d,size_h+holder_d,size_d+holder_d],center=true);
		#translate([0,0,holder_d/2])cube([size_w,size_h,size_d+0.02],center=true);
	}
}
// size is a vector [w, h, d, outer_w, outer_h]
module SquareHole(size_w, size_h, size_d, size_o_w, size_o_h)
{
	difference() {
		union(){
			cube([size_w+holder_d,size_h+holder_d,size_d],center=true);
			%translate([0,0,size_d/2-holder_d/2])cube([size_o_w,size_o_h,holder_d],center=true);
		}
		#cube([size_w,size_h,size_d+0.04],center=true);
	}
}
// size is a vector [r, h, outer_r outer_h]
module RoundHole(size_r, size_h, size_o_r)
{
	difference() {
		union(){
			cylinder(r=size_r/2+holder_d/2, h=size_h, center=true,$fn=16);
			%translate([0,0,size_h/2-holder_d/2])cylinder(r=size_o_r/2, h=holder_d, center=true,$fn=16);
		}
		#cylinder(r=size_r/2, h=size_h+0.04, center=true,$fn=16);
	}
}
// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly) {
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				 y = [radius-size[1]/2, -radius+size[1]/2]) {
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
					y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
				rotate(rot[axis]) 
					translate([x,y,0]) 
					cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				y = [radius-size[1]/2, -radius+size[1]/2],
				z = [radius-size[2]/2, -radius+size[2]/2]) {
			translate([x,y,z]) sphere(radius);
		}
	}
}