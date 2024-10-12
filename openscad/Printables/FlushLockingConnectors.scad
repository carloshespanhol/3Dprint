// Creates an interlocking "keyed" attachment point with a triangle shaped key
module tri_key(x, y, z)
{
	linear_extrude( height = z )
	{
		polygon( points = [ [ 0, 0 ], [ x, 0 ], [x/2, y ] ], paths = [ [ 0, 1 , 2] ] );
	}
}

// Creates a triangular ridge that has a sloped face to allow slipping in one direction but not the other. 90 degrees is unsloped, smaller angles are shallower sides
// x = protruding distance ("overlap"), y = ridge height, z = ridge length,
module one_way_ridge(x, y, z)
{
	translate( [ 0, 0, y ] )
	rotate( [ -90, 0, -90 ] )
	linear_extrude( height = z )
	polygon( points = [ [ 0, 0], [ x, 0 ], [ 0, y ] ], paths = [ [ 0, 1, 2 ] ] );
}

// Mounting block with a "key" piece, block designed to constrain it from sliding vertically
module male_key_block( x, y, z, key_x, key_y, key_z )
{
	// Parameters  may need to be experimented with, especially if printed on different scales
	// If experimenting, remember to modify the corresponding female connector

	// Base thickness is the size of the block stabilizing both one end of the key, and the slot for the corresponding base on the female connector
	base_thickness = (z - key_z)/2;
	y_overlap = y / 3;
	
	lock_height = 1;
	lock_overlap = 0.5;	

	union()
	{
		// Key
		translate( [ (x - key_x)/2, 0, base_thickness ] )
		tri_key( key_x, key_y + y_overlap, key_z );
		
		difference()
		{
			// Base block, stabilizes key
			translate( [ 0, 0, key_z + base_thickness] )
			cube( size = [ x, y, base_thickness ] );
			
			// Cutout for corresponding locking ridge
			translate( [ -0.001, 0 , z ] )
			rotate( [ 180, 0, 0 ] )
			one_way_ridge( lock_overlap, lock_height, x + 0.002);
		}
		
		// Mounting Side Block, union() or superglue to your part
		translate( [ 0, key_y, 0 ] )
		cube( size = [ x, y - key_y, key_z + base_thickness ] );
				
		translate( [ 0, key_y, 0 ] )
		one_way_ridge( lock_overlap, lock_height, x);
	}
}

// Mounting block with a cutout for a matching keyed block, designed to constrain it from sliding vertically
module female_key_block( x, y, z, key_x, key_y, key_z )
{
	// Parameters  may need to be experimented with, especially if printed on different scales
	// If experimenting, remember to modify the corresponding female connector
	
	// Base thickness is the size of the block stabilizing both one end of the key, and the slot for the corresponding base on the female connector
	base_thickness = (z - key_z)/2;	
	
	lock_height = 1;
	lock_overlap = 0.5;

	difference()
	{
		union()
		{
			// Main body, forms base and key slot is cut into
			cube( size = [ x, y, z - base_thickness ] );	
			
			// Block connecting locking ridge to main body
			translate( [ 0, 0, z - base_thickness ] )
			cube( size = [ x, y - key_y, base_thickness ] );

			// Locking ridge
			translate( [ 0, y - key_y , z ] )
			rotate( [ 180, 0, 0 ] )
			one_way_ridge( lock_overlap, lock_height, x);
		}
		
		// Slot for key
		translate( [ ( x - key_x)/2, y - key_y, z - key_z - base_thickness ] )
		tri_key( key_x, y, key_z );
	
		// Cutout for corresponding lock ridge
		translate( [ -0.001, y, 0 ] )
		one_way_ridge( lock_overlap, lock_height, x + 0.002);
	}
}



// Example:
length = 15;
depth = 15 * 2/3;
height = 25;

x = length;
y = depth;
z = height;
key_x = x * 2/3;
key_y = y * 2/3;
key_z =  z * 2/3;
lock_height = 1;
	
// Male Locking connector, Right side in "Right" view
translate ( [ x, 5, z ] )
rotate( a = [ 0, 180, 0] ) //, v = [ x/2, y/2, z/2 ] ) // Ignores v = [...] parameter??? This can be used to rotate around a new origin, such as the center of the object.
male_key_block( x, y, z, key_x, key_y, key_z );
	
// Female Locking connector, Left side in "Right" view
translate( [ 0, - (y + 5), 0 ] )
female_key_block( x, y, z, key_x, key_y, key_z );
