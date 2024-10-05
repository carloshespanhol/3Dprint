include <config.scad>
use <../lib.scad>
use <parts.scad>
$fn=100;

len=60;
thick=5;
top_screw=len-15;

//%translate([10,0,26.75]) idler_pulley();


//mirror([1,0,0])
//translate([0,0,20]) rotate([-90,0,0])
strong_idler();

module strong_idler(dy=0){
    translate([20,dy,-29])
    difference(){
        union(){
            // Bracket
            translate([0,20,60])
            rotate([180,0,0])
            cnr_bracket_rail_mnt( L=60, corner_notch=true);
            
        }

        // Frame Screw
        translate([-10,10-4.5/2, top_screw+4+2.5])
        rotate([0,90,0]) 
        rcube(8,4.5,30,1);
        translate([5,-5.5, top_screw+5+2])
        rotate([0,90,0]) 
        rcube(9,19,24,.5);

        // Belt hole
        translate([1.2,-5, 20])
        vrcube(15.5,50,19,.5);

        //
        translate([-10,5.5, len-23])
        rcube(10,8.5,24,.5);        
    }
}

// corner bracket with rail mount holes
// (C) Ricky White 2015
// CC-SA-AA
///////////////////////////////////////////////////////////////////////////////
module cnr_bracket_rail_mnt(L = 60, extrusion_w = 20, hole_d = 5, corner_notch=false )
{
	brace_thick = 6;
	base_thick = 8;
	
	locate_thick = 6;	// locate_thick = 1;
	locate_w = 6;
	nut_len = 11.5;
	e=0.01;				// overlap for manifold
	T = 0.2;			// tollerance for fit
	hole_A = 20.5;
	hole_B = 46;
	cnr_r = 5;
	hole_csk_d = 9;
	
	difference()
	{
		union()
		{
            translate([base_thick,0,base_thick])	
            cube([L,brace_thick,L]);

			/* corner brace */
            hull(){				
				translate([base_thick*2, brace_thick, base_thick*2])	
                cube([.1,.1,.1]);
       
				translate([base_thick, extrusion_w-.1, base_thick*2])
       rotate([0,135,0]) 
                cube([10,.1,base_thick*2]);
            }
        
			/**/
            hull(){
              cube([L+base_thick,extrusion_w,base_thick]);
	
              translate([0,brace_thick,base_thick])
              cube([L+base_thick,.1,base_thick]);
            }
            hull(){
              cube([base_thick,extrusion_w,L+base_thick]);
              
              translate([base_thick,brace_thick,0])
              cube([base_thick,.1,L+base_thick]);
            }
      
			// base slot
			translate([0,(extrusion_w-locate_w)/2, -locate_thick])	
          cube([L+base_thick,locate_w,locate_thick]);
			// vert slot
			translate([-locate_thick,(extrusion_w-locate_w)/2, -locate_thick])	
          cube([locate_thick,locate_w,L+base_thick+locate_thick]);
		}
        
        /*********************************/
		// subtract holes
		union()
		{
			// horizontal
			union()
			{
				/*
                translate( [base_thick+hole_A, extrusion_w/2, -0.1-locate_thick] ) cylinder( d = hole_d, base_thick+L );
				translate( [base_thick+hole_A, extrusion_w/2, base_thick*2/3] ) cylinder( d = hole_csk_d, base_thick+10 );
				#translate( [base_thick+hole_A, extrusion_w/2, -locate_thick/2] ) cube([ nut_len+T, locate_w+2*e, locate_thick+e], center=true );
				/**/
                
				translate( [base_thick+hole_B, extrusion_w/2, -0.1-locate_thick] ) cylinder( d = hole_d, L+locate_thick );
				translate( [base_thick+hole_B, extrusion_w/2, base_thick*2/3] ) cylinder( d = hole_csk_d, base_thick+10 );
				translate( [base_thick+hole_B, extrusion_w/2, -locate_thick/2] ) cube([ nut_len+T, locate_w+2*e, locate_thick+e], center=true );
			}
			
			// vertical
			union()
			{
				mirror([1,0,0]) rotate([0,-90,0])
				{
                    /*translate( [base_thick+hole_A, extrusion_w/2, -0.1] ) cylinder( d = hole_d, L );
					translate( [base_thick+hole_A, extrusion_w/2, base_thick*2/3] ) cylinder( d = hole_csk_d, base_thick+10 );
					translate( [base_thick+hole_A, extrusion_w/2, -locate_thick/2] ) cube([ nut_len+T, locate_w+2*e, locate_thick+e], center=true );*/
					
					translate( [base_thick+hole_B, extrusion_w/2, -0.1] ) cylinder( d = hole_d, L );
					translate( [base_thick+hole_B, extrusion_w/2, base_thick*2/3] ) cylinder( d = hole_csk_d, base_thick+10 );
					translate( [base_thick+hole_B, extrusion_w/2, -locate_thick/2] ) cube([ nut_len+T, locate_w+2*e, locate_thick+e], center=true );
				}
			}
            
			if( corner_notch==true )
			{
				translate([ -locate_thick/2-e, extrusion_w/2, -locate_thick/2-e ]) cube([locate_thick+e,locate_thick+e,locate_thick+e], center=true);
			}
			
            translate([L+base_thick*2,-0.1,0])
            rotate([0,-45,0]) 
            cube([L,2*L, 2*L]);

			// base slot
			translate([-1,(extrusion_w-locate_w)/2-1, -locate_thick-1])	
            cube([L/2,locate_w+2,locate_thick+1]);

		}
	}
}
