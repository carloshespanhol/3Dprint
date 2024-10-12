// Creates an interlocking "keyed" attachment point with a triangle shaped key
module tri_key(x, y, z)
{
	linear_extrude( height = z )
	{
		polygon( points = [ [ 0, 0 ], [ x, 0 ], [x/2, y ] ], paths = [ [ 0, 1 , 2] ] );
	}
}

// Creates a block that has one sloped face to allow slipping in one direction but not the other. 90 degrees is unsloped, smaller angles are shallower sides
module one_way_block(x, y, z, angle)
{
	difference()
	{
		cube( size = [ x, y, z ] );
		
		rotate( [ -90, 0, 0 ] )
		linear_extrude( height = y + 0.001)
		polygon( points = [ [ x, 0], [ x, -z ], [ x - z * tan(90 - angle), -z ] ], paths = [ [ 0, 1, 2 ] ] );
	}
}

// Mounting block with a "key" piece, block designed to constrain it from sliding vertically
module male_key_block( x, y, z, key_x, key_y, key_z )
{
	// Parameters  may need to be experimented with, especially if printed on different scales
	y_overlap = y / 3;
	z_overlap = ( z - key_z )/2;
	
	lock_height = 2;
	lock_overlap = 0.75;
	lock_angle = 65;	

	union()
	{
		translate( [ (x - key_x)/2, 0, z_overlap ] )
		tri_key( key_x, key_y + y_overlap, key_z );
		
		difference()
		{
			cube( size = [ x, y, z ] );
			
			cube( size = [ x, key_y, key_z + z_overlap] );
		}
		
		translate( [ x, y, 0 ] )
		rotate( [ 180, 0, -90 ] )
		one_way_block( x - key_x + lock_overlap, y, lock_height, lock_angle);
	}
}

// Mounting block with a cutout for a matching keyed block, designed to constrain it from sliding vertically
module female_key_block( x, y, z, key_x, key_y, key_z )
{
	y_overlap = y / 3;
	z_overlap = ( z - key_z )/2;
	
	lock_height = 2;
	lock_overlap = 0.75;
	lock_angle = 65;	

	difference()
	{
		union()
		{
			cube( size = [ x, y, z ] );

			translate( [ x, 0, z ] )
			rotate( [ 0, 0, 90 ] )
			one_way_block( x - key_x + lock_overlap, y, lock_height, lock_angle);
		}
		
		translate( [ ( x - key_x)/2, y - key_y, z - key_z - z_overlap ] )
		tri_key( key_x, key_y + y_overlap, key_z );
	
		translate( [ 0, y - key_y, z - z_overlap - 0.002] )
		cube( size = [ x, y, z_overlap + 0.002 ] );
	}
}

length = 15;
height = 30;

x = length;
y = length;
z = height;
key_x = length * 2/3;
key_y = length * 2/3;
key_z =  height * 2/3;


male_key_block( x, y, z, key_x, key_y, key_z );

translate( [ 0, -(y+5), 0 ] )
female_key_block( x, y, z, key_x, key_y, key_z );

