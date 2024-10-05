//	+---------------------------------------------------------------+
//	| CoreXY test piece for speed, jerk, acceleration as well as    |
//	| ringing, vibration, vertical banding and other 		        |
//	| artefacts.													|
//	|                                                               |
//	| Edit "Globals" to fit your nozzle, edit parameters of         |
//	| "test_layer" function calls to emboss, what you are going     |
//	| to print, edit your GCode after slicing accordingly.          |
//	|                                                               |
//	| This work is currently licensed under The "3-Clause BSD       |
//  | License" => https://opensource.org/licenses/BSD-3-Clause      |
//	|                                                               |
//	|   December 4th, 2018                   Burning Becks          |
//	|           https://burningbecks.wordpress.com/                 |
//	+---------------------------------------------------------------+

// Version 1.0
// OpenSCAD version 2015.03; Manual:
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

// Marlin GCode documentation: http://marlinfw.org/meta/gcode/
// Examples:
// M220 S100; Feedrate 100 => 100%
// M221 S95; Flow: 95 => 95%
// M201 X2000 Y1500; Acceleration for X/Y in mm/s^2
// M205 X20 Y12; So called "Jerk" for X/Y (jumps in acceleration)

//******************************************************************************
//*                    Functions and Modules                                   *
//******************************************************************************

module cyl_at_rot (h, r, t_x, t_y, t_z, r_x, r_y, r_z )
{
    translate   ([t_x, t_y, t_z]){
    rotate      ([r_x, r_y, r_z]){
    cylinder(h,r,r,center=false); }}
};

module cube_at_rot (x,y,z,t_x,t_y,t_z,r_x,r_y,r_z)
{
	translate ([t_x,t_y,t_z]){
    rotate      ([r_x, r_y, r_z]){
	cube ([x,y,z],center=false); }}
};

module txt_at_rot (TEXT, FONT, SIZE, h, t_x, t_y, t_z, r_x, r_y, r_z)
{
    translate   ([t_x, t_y, t_z]){
    rotate      ([r_x, r_y, r_z]){
    linear_extrude (height = h){
    text        (TEXT, font=FONT,size=SIZE); }}}
};

//******************************************************************************
//*                           Globals                                          *
//******************************************************************************

resolution=50;
$fn=resolution;
Font = "Impact";
line_width = 0.81;
base_thickness = 0.3;

module base()
{
    // X
    cube_at_rot (75,10,base_thickness, -10,0,0, 0,0,0);
    // Y
    cube_at_rot (10,100,base_thickness, -10,-90,0, 0,0,0);
    // 45°
    cube_at_rot (10,50,base_thickness, 35,-51,0, 0,0,135);
    // 135°
    cube_at_rot (10,60,base_thickness, 35,-51,0, 0,0,45);
}

module test_layer (h, t_z, text1, text2)
{
    // Rounded corner:
    difference(){
        cyl_at_rot (h, 6, 0,0,t_z+base_thickness, 0,0,0);
        cyl_at_rot (h, 6-(2*line_width), 0,0,t_z+base_thickness, 0,0,0);
        cube_at_rot (10,10,h, 0,-10,t_z+base_thickness, 0,0,0);
        cube_at_rot (10,10,h, 0,0,t_z+base_thickness, 0,0,-10);
        cube_at_rot (12,10,h, -10,-10,t_z+base_thickness, 0,0,10);
        // X-Axis transition
        cube_at_rot ((2*line_width),10,h, -5.8-(2*line_width),-5,t_z+base_thickness, 0,0,0);
    }
    // X-Axis
    difference(){
        cube_at_rot (60,(2*line_width),h, 0,4.3,t_z+base_thickness, 0,0,0);
        cyl_at_rot (h, 6-(2*line_width), 0,0,t_z+base_thickness, 0,0,0);
    }
    txt_at_rot ("<- X", Font, 5, 1, 30,3.8+(2*line_width),t_z+2+base_thickness, 90,0,180);  
    txt_at_rot (text1, Font, 5, 1, 10,3.2+(2*line_width),t_z+2+base_thickness, 90,0,0);  
    // Y-Axis
    cube_at_rot ((2*line_width),85,h, -5.8,-75-8.7,t_z+base_thickness, 0,0,0);
    txt_at_rot ("<- Y", Font, 5, 1, -5.2,-60,t_z+2+base_thickness, 90,0,270);  
    // 45°
    difference(){
        cube_at_rot (60,(2*line_width),h, -6,-86,t_z+base_thickness, 0,0,45);
        cube_at_rot (10,10,h, -14.2-(2*line_width),-92,t_z+base_thickness, 0,0,0);
    }
    txt_at_rot (text2, Font, 5, 1, -1,-78.6-(2*line_width),t_z+2+base_thickness, 90,0,45);  
    // 135°
    difference(){
        cube_at_rot (60,(2*line_width),h, 36.5,-43.5,t_z+base_thickness, 0,0,135);
        cube_at_rot (10,10,h, -14.2-(2*line_width),-5,t_z+base_thickness, 0,0,0);
    }
};
// Display / STL-generation
mode = "all"; // one / two / both / all

//******************************************************************************
//*                           Begin Code                                       *
//******************************************************************************

//330x330 build platform for debug:
translate([-(330/2),-(330/2),-1.01]) %cube([330,330,1]);

// Top
if ((mode == "one") || (mode == "both")|| (mode == "all")){   
color ("SteelBlue"){  
  difference(){
    union(){
        test_layer (8, 0,  "  50/100 mm/s", "A 2k/1k5 J20/12");
        test_layer (8, 8,  "125/150 mm/s", "");
        test_layer (8, 16, "175/200 mm/s", "");
    } // union

    } // difference
} // color
} // Top

// Bottom
if ((mode == "two") || (mode == "both")|| (mode == "all")){
color ("DarkOliveGreen"){
difference(){
    union(){
        base();
    }
}}} // Bottom

// The rest
if (mode == "all"){
color ("Crimson"){
difference(){

} // difference
}} // The rest
