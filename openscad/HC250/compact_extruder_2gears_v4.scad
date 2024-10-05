// Based on: Compact direct drive bowden extruder for 1.75mm filament
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com> and contributors
use <../lib.scad>
$fn=100;
cl=0.3;
t=5;    //thickness
angle=30;

// avoid openscad artefacts in preview
epsilon = 0.01;

// increase this if your slicer or printer make holes too tight
extra_radius = 0.1;

// major diameter of metric 3mm thread
m3_major = 3;
m3_radius = m3_major / 2 + extra_radius;
m3_wide_radius = m3_major / 2 + extra_radius + 0.2;

// diameter of metric 3mm hexnut screw head
m3_head_radius = 3 + extra_radius;

// drive gear
drive_gear_gear_radius = 9.3 / 2;
drive_gear_outer_radius = 8.00 / 2;
drive_gear_hobbed_radius = 6.35 / 2;
drive_gear_hobbed_offset = 3.2;
drive_gear_length = 15;
drive_gear_tooth_depth = 0.2;

// base width for frame plate
base_width = 30;
base_length = 60;
base_thick = 2.4;

// nema 17 dimensions
nema17_width = 42.3;
nema17_hole_offsets = [
	[-15.5, -15.5, 1.5],
	[-15.5,  15.5, 1.5],
	[ 15.5, -15.5, 1.5],
	[ 15.5,  15.5, 1.5 + base_thick]
];

// inlet type
inlet_type = 0; // 0:normal, 1:push-fit
out_pos = 5;
sbw=0.81;

// filament
filament_diameter = 1.75; // 1.75, 3.00
filament_offset = [
	drive_gear_hobbed_radius + filament_diameter / 2 - drive_gear_tooth_depth+0.4,
	0,
	base_thick + drive_gear_length - drive_gear_hobbed_offset + 2.85
];

/************************************/
/* mounting plate *
translate([-nema17_width / 2 - base_thick-15, 6.5, 0])
rotate([0,-90,0]) 
*/
frame_mount();
/**
mirror([0,1,0]){ 
    translate([30, 0, 19.75]) rotate([0,90,0])
    gear_idler();

    //translate([0,0,nema17_width/2+3]) rotate([0,-90,0])
    %color("silver") gears();        
    compact_extruder();

    %color("black")
    translate([4.25,-5,20.2])
    cube([.1,10,3]);
}
/**/    


//translate([0,50,0]) jig();
/* jig to cut bowden tube */
module jig(){
    sw=0.6;
    sl=45;
    c=0.15;
    w=15;
    h=10;
    t=2.5;
    cl=0.3;
    
    difference(){        
        translate([-sl/2+(sl/2-w)/2,11,0])
        cube([w,sl-21,h]);
        
        // chamfer
        translate([-sl/2+(sl/2-w)/2-1,10,5])
        rotate([0,-45,0])
        cube([w,sl-19,h]);
        
        translate([-3,10,5])
        rotate([0,-45,0])
        cube([w,sl-19,h]);

        // slots
        translate([-.25,0,0])
        {
        translate([0,0,t])
        rotate([0,0,30])
        cube([sw,sl,h]);            
            
        translate([-sl/2,sw/2,t])
        rotate([0,0,-30])
        cube([sw,sl,h]);   

        translate([0,sl/2-2.5-sw,t])
        rotate([0,0,90])
        cube([sw,sl,h]);            
        }
        
        // tube
        translate([-sl/2+(sl/2-w)/2+w/2,sl+5,t+3])
        vcylinder(d=4+cl, h=sl+15);
        
        // cut
        translate([-sl/2+(sl/2-w)/2+w/2-1.5,sl/2-5.4,h/2])
        cube([3,5,h]);            

        //translate([-10,-10,-1])  cube([40,sl+10,h*2]);
    }
}

/*************************************/
// Gears
module gears(){
    translate([0,0,base_thick+3.5])
    rotate([90,0,0])
    import("stl/bondtech_gears.stl");
}

// plate for mounting extruder on frame
module frame_mount(){
    difference(){
        union(){
            /* Nema 17 mount */
            translate([0,0,nema17_width/2+t+cl]){
                difference(){
                    translate([base_thick/2,0,0])
                    cube([base_thick, nema17_width+2*t+2*cl, nema17_width+t],center=true);

                    translate([base_thick/2-.1,0,0])
                    cube([base_thick+.3, nema17_width-5, nema17_width-5],center=true);
                }
                
                rotate([0,90,0]){
                    nema17_mount(base_thick=base_thick, screw_head=false);
                }
            }  
            
            /* Base */
            translate([0,-nema17_width/2-t,0])
            cube([base_width+base_thick, nema17_width+2*t, t]);
            
            // angled base
            translate([0,-10,0]){
            hull(){
                translate([0,-nema17_width/4+t,0])
                cube([base_width+base_thick, nema17_width/2, t]);

                translate([base_width+base_thick,nema17_width/2+t,0])
                rotate([-angle,0,180])
                cube([base_width+base_thick, 20+t, t]);
            }

            // fixing
            mirror([0,0,1])
            translate([base_width+base_thick,nema17_width/2+5,-5])
            rotate([angle,0,180])
            difference(){
                union(){
                cube([base_width+base_thick, t, 20+t]);
                            translate([24,0,12]) 
            cube([8,4+t,5.5]);
                }
                translate([(base_width+base_thick)/2,nema17_width,10+t])
                rotate([0,-90,0])
                vcylinder(d=5.5, h=50);
            }
            }
         /*
            translate([nema17_width/3*2,nema17_width/2+t,0])
                rotate([-angle,0,180])
                cube([nema17_width/3*2, nema17_width+10, t]);
           */ 
            // reinforce
            translate([0,-nema17_width/2-t-cl,0])
            hull(){
                cube([base_thick, t, nema17_width/4*3+t]);
                cube([base_width+base_thick, t, t]);
            }
            translate([0,nema17_width/2+cl,0])
            hull(){
                cube([base_thick, t, nema17_width/4*3+t]);
                cube([base_width+base_thick, t, t]);
            }
        }
    }
}

// mounting plate for nema 17
module nema17_mount(base_thick=base_thick, screw_head=true)
{
	// settings
	width = nema17_width;
	height = base_thick;
	edge_radius = 27;
	axle_radius = drive_gear_outer_radius + 1 + extra_radius;

	difference()
	{
		// base plate
		translate([0, 0, height / 2])
			intersection()
			{
				cube([width, width, height], center = true);
				cylinder(r = edge_radius, h = height + 2 * epsilon, center = true);
			}
		
		// center hole
		translate([0, 0, -epsilon]	)
			cylinder(r = 11.25 + extra_radius, h = height+1);

		/* axle hole */
		translate([0, 0, -epsilon])
			cylinder(r = axle_radius, h = height + 2 * epsilon);

		/* mounting holes */
		for (a = nema17_hole_offsets)
			translate(a)
			{
				cylinder(r = m3_radius, h = height * 4, center = true);
                if(screw_head){
                    cylinder(r = m3_head_radius, h = height + epsilon);
                }
			}
	}
}



// inlet for filament
module filament_tunnel()
{
	// settings
	width = 10;
	length = nema17_width;
	height = filament_offset[2] - base_thick + 4;
    hdiff = 3; // height diff

    
	translate([0, 0, height / 2])
	{
		difference()
		{
                 intersection(){
                     union(){
            translate([-17.8, -21 ,0]) cylinder(r = 26.3, h = height + 10, center = true);
            translate([-17.8, 21 ,0]) cylinder(r = 26.3, h = height + 10, center = true);
                         translate([0, 8 ,0]) cube([20,20,20]);
                     }
			union()
			{
				// base
				translate([0, 0, 0.75])
					cube([width, length, height+hdiff-1.5], center = true);

				/* outlet */
				translate([-width/2, length / 2, 0])
                cube([width,out_pos,height/2+1.5]);

                /* tube fixing */
				translate([-2, length / 2+5, 0])
                cube([4,out_pos,4]);
                
				translate([-3, length / 2+8, 0])
                cube([6,3,5]);
                
                /* idler support */
                intersection(){
                    translate([0, length/4+.6, height/2-1.5])
                        oblong(16, 10, 3);
                    translate([-5,0,0])
                    cylinder(r = 27, h = height+10 , center = true);
                }
            
				/* idler tensioner */
				intersection()
				{
					translate([5, -length / 2 + 7.5, 0.75])
						cube([width, 15, height+hdiff-1.5], center = true);
					translate([-17.8, -21 ,0])
						cylinder(r = 26.5, h = height + 10, center = true);
				}
                
                /* rounded corner */
			translate([-width*1.4, -length/2-epsilon, -height/2])
                cube([width,length,width]);

			}
        }
            
            /* idler mounting hole */
            translate([11.5, 15.5, 0])
                cylinder(r = m3_wide_radius, h = height * 4, center = true);

            /* center hole */
            translate([length/2, 0, -drive_gear_length/2+1.5])
            rotate([0,-90,0])            
            cylinder(d=drive_gear_length, h = length);
            translate([-drive_gear_length-2,-drive_gear_length/2,-drive_gear_length*1.4])
            cube([drive_gear_length+10,drive_gear_length,drive_gear_length]);
			

			/* middle cutout for drive gear */
			translate([-filament_offset[0], 0, 0])
				cylinder(r = drive_gear_outer_radius+0.5+ extra_radius, h = height + 6, center = true);

			/* middle cutout for idler gear */
			translate([3.5 + filament_diameter / 2, 0, 0])
				cylinder(r = drive_gear_outer_radius+0.5+ extra_radius, h = height + 6, center = true);

			/* idler mounting hexnut */
			translate([filament_diameter-5, -nema17_width / 2 + 4, .25])
				rotate([0, 90, 0])
					cylinder(r = m3_radius, h = 20, center = false);
			translate([filament_diameter + 3, -nema17_width / 2 + 4, 5])
				cube([2.5 + 3 * extra_radius, 5.5 + 2.5 * extra_radius, 15], center = true);
			translate([filament_diameter + 3, -nema17_width / 2 + 4, 0])
				rotate([0, 90, 0])
					cylinder(r = 3.15 + 2.5 * extra_radius, h = 2.5 + 3 * extra_radius, center = true, $fn = 6);
			
			/* rounded corner */
			translate([-height/2-width/2+0.04, -epsilon, 0])
				rotate([90, 0, 0])
					cylinder(r = height/2, h = length+1 , center = true);
                    
                    
                    
			/*** filament path ***/
            /*********************/
			translate([0, 0, -height / 2 + filament_offset[2] - base_thick])
				rotate([90, 0, 0])
					cylinder(r = filament_diameter / 2 + 2 * extra_radius,
						h = length + 2 * epsilon, center = true);
			
                    
			/* funnnel inlet */
            // normal type
            translate([0, -length / 2 + 1 - epsilon, -height / 2 + filament_offset[2] - base_thick])
                rotate([90, 0, 0])
                    cylinder(r1 = filament_diameter / 2, r2 = filament_diameter / 2 + 1.5 + epsilon / 1.554,
                        h = 3 + epsilon, center = true);
            
            /* outlet */
			translate([0, length / 2 + 1 - 2.5 + epsilon+out_pos, -height / 2 + filament_offset[2] - base_thick])
				rotate([90, 0, 0])
					cylinder(d=4+cl, h = 50, center = true);
            /**/
		}
        
	}
}


// compose all parts
module compact_extruder()
{
	// motor plate
    difference(){
        nema17_mount();

        translate([0,-drive_gear_length/2,-1])
        cube([drive_gear_length+10,drive_gear_length,drive_gear_length]);
    }
    
	/* filament inlet/outlet */
	translate([filament_offset[0], 0, base_thick - epsilon])
		filament_tunnel();

	/* filament */
	%color("red")
		translate(filament_offset - [0, 0, epsilon])
			rotate([90, 0, 0])
				cylinder(r = filament_diameter / 2, h = 100, center = true);
}

module gear_idler()
{
	// settings
	width = nema17_width;
	height = filament_offset[2] - base_thick + 4;
	edge_radius = 27;
	hole_offsets = [-width / 2 + 4, width / 2 - 4];
	bearing_bottom = filament_offset[2] / 2 - base_thick / 2 - 6;
	offset = drive_gear_hobbed_radius - drive_gear_tooth_depth + filament_diameter;
	pre_tension = 0.25;
	gap = 1;
	top = 2;

	// base plate
	translate([0, 0, height/2+base_thick+epsilon])
	difference()
	{
		union()
		{
			// base
			translate([1, 0, top / 2])
			intersection()
			{
                translate([0, -2.5, 0])
				cube([width-5, width+5, height + top], center = true);
                /**/
				translate([0, 0, 0])
					cylinder(r = edge_radius+2, h = height + top + 2 * epsilon, center = true);
				translate([edge_radius+drive_gear_outer_radius, -2, 0])
					cylinder(r = edge_radius+2, h = height + top + 2 * epsilon, center = true);
                    
                /**/
                translate([0,-30,-10])
                cube([40,80,30]);
                    
				translate([edge_radius/2, -edge_radius/4, 0])
					cylinder(r = edge_radius, h = height + top + 2 * epsilon, center = true);
				translate([offset + 10.65 + gap, -2.5, 0])
					cube([15, nema17_width + 5, height + top], center = true);
                
                translate([-2,0,0])
                    cylinder(r = 30, h = height+1 , center = true);                
			}
			
			
            /* Gear Support */
                translate([drive_gear_gear_radius*2,0,top/2])
            hull()
            {
                   cylinder(r=drive_gear_gear_radius-.5, h = height+top+2, center = true);
            translate([-1,-6,-9.5])  cube([10,12,19]);
                }  
		}
        
        /* screw chamfer */
        translate([6, -nema17_width/2-5, -height/2-6.5])
        cube([17, 15, 10], center = false);

        /* support chamfer */
        translate([5, width/4, height/2-2])
        cube([17, 11, 10], center = false);
        
        /* Gear */
		translate([drive_gear_gear_radius*2,0,1])
			cylinder(r=drive_gear_gear_radius*2, h = drive_gear_length, center = true);
        
        /* Gear support slot */
        cube([15,1,height+10],center=true);
        
        /* Gear Pin */
		translate([drive_gear_gear_radius*2-filament_diameter/2,0,0])
			cylinder(d=3, h = drive_gear_length*3, center = true);
        
		/* tensioner bolt slot */
        translate([-10, -nema17_width / 2 + 1.5, -1.5])
        rotate([90, 0, 0])
        rotate([0, 90, 0])
        oblong(5,m3_wide_radius*2,50);
		// fastener cutout
        difference(){
            translate([offset - 18.85 + gap, -21, top / 2])
                cylinder(r = 27, h = height + top + 2 * epsilon, center = true);
        
            translate([-21+drive_gear_gear_radius*2, -21.5, -10])
                cube([21.5,width,height+10]);
        }
        
        
		// mounting hole
		translate([15.5, 15.5, 0])
			cylinder(r = m3_wide_radius, h = height * 4, center = true);

	}  
}