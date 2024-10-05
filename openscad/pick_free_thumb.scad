//	PickPerfect by LoGan McCarthy 3/07/2012 LM
// A thanks to OpenSCAD manual and MakerBlock Customizer Template for the tips and HarlanDMii for Write.scad.




larg=15;
comp=14; // 14
esp=2;
alt=17;  // 17

use <utils/build_plate.scad>

use<Write.scad>
include <write/Write.scad>

//CUSTOMIZER VARIABLES

//	This section is displays the box options
//Pick Thickness 
z_thick = 2.5;	//	[1:Extra Lite, 1.5:Lite, 1.875:Medium, 2.5:Heavy, 3.75:Extra Heavy, 4.375:Extreme!]

//AdvancedGrip Technology
Grip = 0; // [1:Yes, 0:No]


//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//CUSTOMIZER VARIABLES END


translate([esp*3.5,0-esp*4,0]) // normal
rotate([0,0,45]) 

//anel
difference()
{
	union()
	{
		translate([0-larg/2,0,0])
		cube([larg,comp+esp*2,alt+esp*2-comp/2]);
		rotate([0,90,0])
		translate([0-alt+comp/2-esp,comp/2+esp,0-larg/2])
		cylinder(r=comp/2+esp,h=larg);		
	}
	union()
	{
		translate([0-larg/2-esp,esp,esp])
		cube([larg+esp*2,comp,alt-comp/2]);
		translate([0-larg/2,esp,esp])

		rotate([0,90,0])
		translate([0-alt+comp/2,comp/2,0-esp])
		cylinder(r=comp/2,h=larg+esp*2);		
	}
}


//PickPerfect


scale(v = [.93,.93, z_thick]) {

union() {
color("darkorange")

//error correct
	scale(v = [1,1,.8]) {
minkowski()
{

translate([0,25,0])
	
		intersection() {
			translate([-51,0,0]) cylinder($fn=360,.4,69,69);
			translate([51,0,0]) cylinder($fn=360,.4,69,69);
			translate([0,-38,0]) cylinder($fn=360,.4,25,25);
 }
 cylinder($fn=60,r=1,h=.1);}
}
}

//TOP GRIP
color("gold")

if(Grip==1){
translate([0,0,-1.61]) {
difference() {
translate([0,23,2])
	
		intersection() {
			translate([-51,0,0]) cylinder($fn=260,.2,67,66);
			translate([51,0,0]) cylinder($fn=260,.2,67,66);
			translate([0,-38,0]) cylinder($fn=260,.2,25,24);}

			translate([0,-15,0]) cylinder($fn=260,3,16,25);}
}


//BOTTOM GRIP
translate([0,-4,-1.61]) {
difference() {
translate([0,23,2])
	
		intersection() {
			translate([-51,0,0]) cylinder($fn=260,.2,65,64);
			translate([51,0,0]) cylinder($fn=260,.2,65,64);
			translate([0,-38,0]) cylinder($fn=260,.2,23,22);}

//use<Write.scad>


			translate([0,-15,0]) cylinder($fn=260,3,14,23);}
}
}



	// Name

//XL

	if(z_thick==1){

	translate([0,-3,.445]) color("darkred") write("XL",t=.1,h=6,font="knewave.dxf",center=true);}

//L

	if(z_thick==1.5){

	translate([0,-3,.445]) color("darkred") write("Lite",t=.1,h=5,font="knewave.dxf",center=true);}

//M

	if(z_thick==1.875){

	translate([0,-3,.445]) color("darkred") write("M",t=.1,h=6,font="knewave.dxf",center=true);}

//H

	if(z_thick==2.5){

	translate([0,-3,.445]) color("darkred") write("H",t=.1,h=6,font="knewave.dxf",center=true);}

//XH

	if(z_thick==3.75){

	translate([0,-3,.445]) color("darkred") write("XH",t=.1,h=6,font="knewave.dxf",center=true);}

//X

	if(z_thick==4.375){

	translate([0,-3,.445]) color("darkred") write("X",t=.1,h=6,font="knewave.dxf",center=true);}
}

