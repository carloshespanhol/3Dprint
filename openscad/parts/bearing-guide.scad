//PRUSAMendel
//GNUGPLv2
//GregFrost

/**
*@categoryPrinted
*/

single_layer_width=0.6;
bearing_inner=22.3;
thickness=1.7;
height=7+thickness;
wall_ascent=5;
wall_descent=0.5;

module inner()
{
	difference()
	{
		cylinder(r=bearing_inner/2+single_layer_width,h=height);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2,h=height+2);
	}

	difference()
	{
		cylinder(r=bearing_inner/2+wall_ascent,h=thickness);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2-wall_descent,h=thickness+2);
	}
}

module outer()
{
	difference()
	{
		cylinder(r=bearing_inner/2+2*single_layer_width,h=height);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2+single_layer_width,h=height+2);
	}

	difference()
	{
		cylinder(r=bearing_inner/2+wall_ascent,h=thickness);
		translate([0,0,-1])
		cylinder(r=bearing_inner/2-wall_descent,h=thickness+2);
	}
}

inner();

translate([34,0,0])
outer();
