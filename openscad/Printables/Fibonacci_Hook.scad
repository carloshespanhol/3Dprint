//FIBONACCI HOOK

//Parameters

//Maximum Desk Thickness
desk=20;

//Hook Thickness (ideally half of desk thickness, not under 1/9 of desk thickness)
thick=10;

//Chamfer ratio (ratio Hook thickness:chamfer size, higher value -> smaller chamfer)
chamferratio=10; // [4:100]

 //Facet Number (detail of curves, at least 500 for smooth surfaces)
$fn=500; // [25:1000]


//DO NOT TOUCH!!! (unless you know what  you're doing ;-))
 module __Customizer_Limit__ () {}
    shown_by_customizer = false;
 
//Some helpful variables

//Chamfer size
 chamfer=thick/chamferratio;
 

//Radius
radius=sqrt(2)*(desk/2+thick/2);

//Profile
profile=[[thick/2,thick/2-chamfer], [thick/2,-(thick/2-chamfer)], [(thick/2-chamfer),-thick/2], [-(thick/2-chamfer), -thick/2], [-thick/2, -(thick/2-chamfer)], [-thick/2, thick/2-chamfer], [-(thick/2-chamfer), thick/2], [thick/2-chamfer, thick/2] ];

//Profile/2
profile2=[[thick/2,thick/2-chamfer], [thick/2,-(thick/2-chamfer)], [(thick/2-chamfer),-thick/2], [0, -thick/2], [0, thick/2], [thick/2-chamfer, thick/2] ];

//ProfileFillet
profilefil=[[thick/2,thick/2-chamfer], [thick/2,-(thick/2-chamfer)], [(thick/2+chamfer),-thick/2], [1.5*thick-chamfer, -(thick/2)], [1.5*thick-chamfer, thick/2], [thick/2+chamfer, thick/2] ];

//Filler
filler=[[0,0], [0,-thick], [-thick*0.75,0]];



//MODELING STARTS HERE

union(){
//1+1
intersection(){
//first circle
rotate_extrude()translate([radius, 0, 0])polygon(profile);
//Cutting tool (because Thingiverse does not support partial rotate extrude)
translate([-1000,0,-1000]) cube([2000,1000,2000]);
}

//2
difference(){
//second circle
translate([-radius, 0, 0])rotate_extrude()translate([radius*2, 0, 0])polygon(profile);
//cutting tool
translate([-radius,0,-1000])linear_extrude(height=2000){polygon([[0,0], [0,-1000], [-1000,-1000], [-1000,1000], [1000,1000], [1000,0]]);}
}

//Round End Part Beginning
translate([-radius,0,0])rotate_extrude() polygon(profile2);
    
//Round End Part End
translate([-radius,-2*radius,0]) rotate([0,0,90]) rotate_extrude() polygon(profile2);

//Hanger
rotate([-90,0,0]) translate([radius,0,0]) linear_extrude(height=radius+desk) polygon(profile);

//Round End Part Hanger
translate([radius,radius+desk,0]) rotate_extrude() polygon(profile2);


//Fillet

translate([radius-thick,sqrt((radius+thick)*(radius+thick)-(radius-thick)*(radius-thick)),0])
difference(){
rotate_extrude() polygon(profilefil);
translate([0,0,-1000]) union(){
cube([1000,1000,2000]);
rotate([0,0,-(asin((radius-thick)/(radius+thick))+180)]) cube([1000,1000,2000]);
rotate([0,0,90]) cube([1000,1000,2000]);
}
}

//Filler (for the hole in the middle)

translate([radius-thick/2+chamfer,sqrt((radius+thick)*(radius+thick)-(radius-thick)*(radius-thick))-thick,-thick/2 ])linear_extrude(thick)polygon(filler);
}


//Test desk
//rotate([0,0,45]) translate([-1000, -desk/2]) cube([1000,desk, 50]);