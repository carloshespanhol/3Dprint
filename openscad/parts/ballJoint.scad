// Ball joint in SCAD by Erik de Bruijn
// Based on a design by Makerblock ( http://makerblock.com/2010/03/blender-help/ )
use <../lib.scad>


size=6; // radius of the ball joint
joint_spacing =0; // some space between them?
joint_thickness = 1.6; // thickness of the arms
joint_arms = 4; // how many arms do you want?
arm_width = 4; // actually: how much is removed from the arms Larger values will remove more

ro=size*1.5;

//render settings
//$fs=0.8; // def 1, 0.2 is high res
//$fa=4;//def 12, 3 is very nice
$fn=100;

print();
//demo(); // turn on animation, FPS 15, steps 200

module demo()
{
    ball();
    translate([0.7,0,2.9])   rotate([0,30,0]) joint();
}
module print()
{
  translate([size*3,0,size])    
    ball();
  translate([0,0,ro])    
  rotate([0,180,0])
    joint();
}

module ball()
{
    translate([0,0,size/3]) 
	sphere(r=size);
	translate([0,0,-size]) 
    cylinder(r=2,h=size/2);
}



module joint()
{
    jh= size/3;
    
translate([0,0,-2.4])    
difference()
{
    union(){
        sphere(r=ro);
        
        // base
        translate([0,0,size+1.5]) 
        ccube(size*1.5,size,2);

        translate([0,0,size+4]) 
        ccube(size*1.5,size,3);            
    }
    
    //----------------------------------
	sphere(r=size+joint_spacing);
    
        translate([0,0,size+4]) 
            hull(){
                translate([0,0,2]) 
                ccube(2,size,.1);

                translate([0,0,-1]) 
                ccube(4,size,.1);
            }

    // upper cut
	translate([0,0,-ro*1.25]) 
    cube([size*3,size*3,ro*2],center=true);
    
	for(i=[0:joint_arms])
	{
		rotate([0,0,360/joint_arms*i]) 
        hull(){
            translate([-arm_width,0, -ro])
            cube([arm_width*2,size*2,.5]);
            translate([-3/2,0, -ro+size*2])
            cube([3,size*2,.1]);
        }
	}
}

}