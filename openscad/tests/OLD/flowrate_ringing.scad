use <../lib.scad>
$fn=100;

linewidth = 0.44;
lw=linewidth;
lh=0.2;

cube_size = 30;
cube_height = 6;
font = "Liberation Sans";
letter_size = cube_height/2;
letter_height = linewidth;

module letter(l, letter_size=letter_size) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = letter_height) {
		text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
	}
}

difference(){
    union(){
        translate([0,10,0])
        cube([cube_size,cube_size-10,cube_height]);

        rcube(cube_size,cube_size-2,cube_height,2);

        // Upper
        translate([0,3,cube_height])
        cube([cube_size,cube_size-3,cube_height]);
        
        // Right
        translate([cube_size+linewidth, cube_size/2, 0]){
            cylinder(r=3*linewidth, h=cube_height/2);
            translate([-4*linewidth, -3*linewidth, 0])
            cube([4*linewidth, 6*linewidth, cube_height/2]);
        }
        // Back        
        translate([cube_size/2, cube_size+linewidth, 0]){
            cylinder(r=3*linewidth, h=cube_height/2);
            translate([-3*linewidth, -4*linewidth, 0])
            cube([6*linewidth, 4*linewidth, cube_height/2]);
        }
    }
    
    // Inner
    translate([lw*2,10,lh])
    cube([cube_size-lw*4,cube_size-10-lw*2,cube_height*2]);

    translate([lw*2,lw*2,lh])
    rcube(cube_size-lw*4,cube_size-2,cube_height*2,1.1);
    
    // Upper
    translate([-lw*2,3-lw*2,cube_height])
    cube([cube_size,cube_size-3,cube_height+1]);
    
    // Front
    translate([cube_size/2, letter_height-linewidth/2, cube_height/2])
    rotate([90,0,0])
    letter("X");
    translate([cube_size/2, letter_height, cube_height/2])
    rotate([90,0,0])
    letter("X", letter_size*.90);
    
    // Left
    translate([-linewidth/2, cube_size/2, cube_height/2])
    rotate([90,0,90])
    letter("Y");
    translate([0, cube_size/2, cube_height/2])
    rotate([90,0,90])
    letter("Y", letter_size*.90);
}

