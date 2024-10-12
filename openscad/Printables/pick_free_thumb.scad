//	PickPerfect by LoGan McCarthy 3/07/2012 LM
// A thanks to OpenSCAD manual and MakerBlock Customizer Template for the tips and HarlanDMii for Write.scad.
$fn=200;



larg=15;
comp=16; // 14
esp=2;
alt=17;  // 17

//CUSTOMIZER VARIABLES

//	This section is displays the box options
//Pick Thickness 
z_thick = 2.5;	//	[1:Extra Lite, 1.5:Lite, 1.875:Medium, 2.5:Heavy, 3.75:Extra Heavy, 4.375:Extreme!]

//AdvancedGrip Technology
Grip = 0; // [1:Yes, 0:No]


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

			translate([0,-15,0]) cylinder($fn=260,3,14,23);}
}
}

}
