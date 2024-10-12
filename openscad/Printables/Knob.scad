offsetMargin = 0.1;
$fn = 200;

/* [Knob] */
shaftDiameter   = 6.0;
shaftFlatLength = 13.0;
shaftFlatOffset = 2;      // offset from top
// Knob width (total length)
knob_width		= 38;
knob_height = shaftFlatLength;
// Knob wall size (default = 2.6)
knob_wall		= 2.6;
// Knob wall stripes (number of stripes, 0=off)
knob_wall_stripes = 30; // eg 60
// Knob wall stripes size
knob_wall_stripes_size = 0.4; // eg 0.6

fingerHoleDiameter = 13.0;
fingerHoleDepth = 1.0;
fingerHoleOffsetFromCenterOfKnob = knob_width / 2 - fingerHoleDiameter / 2 - 2;

// Don't change this unless you know what you're doing
//====================================================

createKnob();


module createKnob()
{
    difference()
    {
        union()
        {
            // Main Knob Body
            difference()
            {
                cylinder(d=knob_width, h=knob_height);
                    
                translate([0,0,-1.6])    
                cylinder(d=knob_width-knob_wall*2, h=knob_height);
            }
            
            // Top
            translate([0,0,shaftFlatLength])
            cylinder(d1= knob_width, d2= knob_width-shaftFlatOffset, h=shaftFlatOffset);
            
            // Shaft
            cylinder(h=knob_height, d=shaftDiameter+knob_wall*2);
            
            // Reinforce
            translate([-knob_width/2+knob_wall/2,-knob_wall/2, shaftFlatOffset])
            cube([knob_width-knob_wall, knob_wall, shaftFlatLength-shaftFlatOffset]); 
            translate([-knob_wall/2,-knob_width/2+knob_wall/2, shaftFlatOffset])
            cube([ knob_wall, knob_width-knob_wall, shaftFlatLength-shaftFlatOffset]); 
        }    
            // Shaft Cutout
            translate(v = [0, 0, -offsetMargin])
            {
                cylinder(d = shaftDiameter + offsetMargin, h = shaftFlatLength);
            }
            
            // Finger Hole
            translate(v = [fingerHoleOffsetFromCenterOfKnob, 0,  knob_height +shaftFlatOffset - fingerHoleDepth ])
            {
               
                 cylinder(d1 = fingerHoleDiameter-fingerHoleDepth*2, d2 = fingerHoleDiameter, h=fingerHoleDepth+.1);
             
            }
            
	// wall stripes
	if(knob_wall_stripes > 0) {
		for(i=[1:knob_wall_stripes]) {
			rotate([0,0,i*360/knob_wall_stripes]) translate([knob_width/2*-1, -knob_wall/4, 0]) 
            cube([knob_wall_stripes_size, knob_wall_stripes_size, knob_height]);
		}
	}
            
    }
    
}