/*************************************************************
 *                        Battery Dispenser for Cylindrical Batteries                           *
 *                              By Blair Thompson    (AKA Justblair)                               *
 *                                                29/12/11                                                       *
 *                                        www.justblair.co.uk                                              *
 *                                              Version 1.0                                                      *
 *************************************************************/

// ***********************  Calibration ** ************************
// Calibrate Option.  If you wish to calibrate set this to true.  If you intend using screws to mount your battery holder
// Set the mount_tab and mount_holes variables to true to allow calibration of the mount holes as well
calibrate = false;		// If true, a calibration piece will be generated.

// *********************  Mount Tab Variables  *********************
mount_tab_opt = true;			// If true tabs will be produced
mount_tab_height = 8	;		// How high above the Channels to do you want the tab to extend
mount_tab_thickness = 5; 		// Set thicknes for the mount tab.  Beware, if you are printing models
						// for two different batt sizes, this will need to be adjusted if you want
						// the tabs to protrude the same distance from the channels.


// *********************  Back Plate Variables  *********************
back_plate= false;			// If true a backplate wil be created.
back_plate_holes_pan = true;		// If true Pan head recessess will be added 
back_plate_thickness = 6;		// Set thickness for back plate (if generated)


// *********** Mounting Holes Dimensions and Shape *******************
mount_holes = false;			// if true tabs will inculde mounting holes
mount_hole_diameter = 3;		// Hole diameters (if holes are generated)
holes_pan_diameter = 5.6; 		// Recess diameter(if generated), this is a sample value is not correct or tested
holes_pan_depth = 3;	 		// Recess depth, (if generated) this is a sample value is not correct or tested

// ***************  Channel Dimensions and Shape *******************
channel_extender_opt = false;	// Set to true if you wish to print an extension channel
$fn=100;					// Set the resolution of the curves
angle = 145;				// Sets the angle the lower section sits at
channel_depth = 12;			// How deep are the channels?  ie.  how tall the print?
channel_width = 22; 			// How wide are the channels?
lower_channel_length = 40;  		// Set lower section size
upper_channel_length= 100;		// Set upper section size

// ******************  Battery Dimensions  *************************
// Un-Comment the size that you need.  Commented lines begin //

// AAA Standard size of battery is 10.5mm x 44.5mm
battery_diameter = 11.6;  		// Needs to be set wider than your intended battery, narrower than the channel width.
battery_length = 46;			// Set slightly longer than your actual battery size

// AA  Standard size of battery is 14.5 x 50.5
// battery_diameter = 15.6;  		// Needs to be set wider than your intended battery, narrower than the channel width.
// battery_length = 52;			// Set slightly longer than your actual battery size

// ****************** Here Comes the Code! ************************

if (calibrate==true)
{
	translate ([channel_width/2,-10+lower_channel_length/2,0])  battery_holder_left(20);
} else if (channel_extender_opt != true){
	translate ([-channel_width/2-1-back_plate_thickness,-upper_channel_length/2+lower_channel_length/2,0]) 
		battery_holder_left(upper_channel_length);
	translate ([channel_width/2+1+back_plate_thickness,-upper_channel_length/2+lower_channel_length/2,0]) 
		mirror ([1,0,0]) battery_holder_left(upper_channel_length);
} else {
	translate ([-channel_width/2-1,0,0]) extension();
	translate ([+channel_width/2+1,0,0]) extension();
} // end if
	
// ************************ Modules ******************************

module battery_holder_left(tab){
	difference(){
		outer_shape(tab);
		inner_shape();


	} // end difference
} // end module

module outer_shape(outer_tab){
	cylinder (h=channel_depth, r=channel_width/2);

	if (calibrate != true){
		translate ([-channel_width/2,0,0]) cube ([channel_width, upper_channel_length, channel_depth]);
		if (back_plate == true){
			difference(){
			translate ([channel_width/2-(channel_width-battery_diameter)/2+1, 0,0]) 
				cube ([back_plate_thickness, upper_channel_length, (channel_width-battery_diameter)/2+battery_length/2]);
		if (mount_holes == true){
			back_plate_holes();
		} // end if
			} // end difference
		}  // end if
	} else {
		translate ([-channel_width/2,0,0]) cube ([channel_width, 20, channel_depth]);	
	} // end if
		if (mount_tab_opt == true){
			mount_tabs(outer_tab);
		} // end if


	rotate (angle,0,0) {
		translate([-channel_width/2,0,0]) cube ([channel_width,lower_channel_length-channel_width/2,channel_depth]);
		translate([0,0,0]) cube ([channel_width/2,lower_channel_length,channel_depth]);
		translate([0,lower_channel_length-channel_width/2,0]) cylinder (h=channel_depth, r=channel_width/2);	
	} // end rotate
} // end module

module inner_shape(){
	translate ([0,0,(channel_width-battery_diameter)/2]) 
		cylinder (h=channel_depth, r=battery_diameter/2);
	translate ([-battery_diameter/2, 0, (channel_width-battery_diameter)/2]) 
		cube ([battery_diameter,upper_channel_length+5,channel_depth]);
	rotate (angle,0,0) {
		translate ([-battery_diameter/2,0,(channel_width-battery_diameter)/2]) 
			cube ([battery_diameter,lower_channel_length-channel_width/2,channel_depth]);
		translate ([0,lower_channel_length-channel_width/2,(channel_width-battery_diameter)/2]) 
			cylinder (h=channel_depth, r=battery_diameter/2);
		translate ([0,lower_channel_length-channel_width/2-battery_diameter/2-2.5,(channel_width-battery_diameter)/2]) 
			cube ([50,battery_diameter+2.5,channel_depth]);
	} // end rotate
} // end 

module extension(){
	difference(){
		translate ([-channel_width/2,-upper_channel_length/2,0]) cube ([channel_width, upper_channel_length, channel_depth]);
	#translate ([-battery_diameter/2, -upper_channel_length/2-2.5, (channel_width-battery_diameter)/2]) 
		cube ([battery_diameter,upper_channel_length+5,channel_depth]);
	} // end difference
} // end module

module back_plate_holes(){	
	translate ([channel_width/2-(channel_width-battery_diameter)/2, upper_channel_length/4, (battery_length/2+(channel_width-battery_diameter)/2+channel_depth)/2]) rotate ([0,90,0]) 
		mount_hole();
	translate ([channel_width/2-(channel_width-battery_diameter)/2, 3*upper_channel_length/4, (battery_length/2+(channel_width-battery_diameter)/2+channel_depth)/2]) rotate ([0,90,0])
		mount_hole();
} //end module

module mount_hole(){
	cylinder (r=mount_hole_diameter/2, h=back_plate_thickness +2);
	if (back_plate_holes_pan == true){
		cylinder(r=holes_pan_diameter/2, h=holes_pan_depth+1);
	} // end if 
} // end module

module mount_tabs(tab_length){
	difference(){
	translate ([channel_width/2-(channel_width-battery_diameter)/2+1, 0,0])  rotate([0,90,0]) { 
		hull() {
   			translate([-mount_tab_height-channel_depth,tab_length-4,0]) cylinder(r=4, h=mount_tab_thickness);
   			translate([-mount_tab_height-channel_depth,4,0])cylinder(r=4, h=mount_tab_thickness);
   			translate([-4,tab_length-4,0])cube ([4,4,mount_tab_thickness] );
   			translate([-4,0,0])cube ([4,4,mount_tab_thickness] );

		 } // end hull
	} // end translate
		if (mount_holes == true){
			translate ([channel_width/2-(channel_width-battery_diameter)/2, upper_channel_length/8, mount_tab_height/2+channel_depth+2]) rotate ([0,90,0]) 
				mount_hole();
			translate ([channel_width/2-(channel_width-battery_diameter)/2, 7*upper_channel_length/8, mount_tab_height/2+channel_depth+2]) rotate ([0,90,0]) 
				mount_hole();
		}// end if
	} // end difference
} // end module