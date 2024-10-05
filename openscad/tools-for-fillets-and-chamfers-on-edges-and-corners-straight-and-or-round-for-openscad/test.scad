//
// Test file for the corner and edge tools.
// get the parameters from corner_tools.scad

include <corner-tools.scad>;


fn=72;

h=10;
h2=h/2;

translate([0,0,0]){
 difference(){
  union(){ 
		 translate([0,0,h2]) cube([30,30,h],center=true);			
  } //end union 
	 translate([0,0,h2]) cube([20,20,h+0.01],center=true);			
				
		translate([-15,-15,h2]) rotate ([0,0,0]) fillet_e(h,3,1,fn);
		translate([  0,-15,h]) rotate ([0,90,0]) fillet_e(30,3,1,fn);
		translate([-15,  0,h]) rotate ([-90,0,0]) fillet_e(30,3,1,fn);
		translate([-15,-15,h]) rotate ([0,0,0]) fillet_c(3,fn);
		
		translate([ 15, 15,h2]) rotate ([0,0,180]) chamfer_e(h,3,1);
		translate([  0, 15,h]) rotate ([0,90,180]) chamfer_e(30,3,1);
		translate([ 15,  0,h]) rotate ([0,90,90]) chamfer_e(30,3,1);
		translate([ 15, 15,h]) rotate ([0,0,180]) chamfer_c(3);
 } //end difference
	translate([-10,-10,h2]) rotate ([0,0,0]) fillet_e(h,3,1,fn);
	translate([-10, 10,h2]) rotate ([0,0,-90]) fillet_e(h,3,1,fn);
	translate([0,10,0]) rotate ([90,0,-90]) fillet_e(20,3,1,fn);
	translate([-10, 10,0]) rotate ([180,0,0]) fillet_c(3,fn);
	translate([ 10, 10,h2]) rotate ([0,0,180]) chamfer_e(h,3,1);
} //end translate

translate([0,55,0]){
 difference(){
  union(){ 
		 translate([0,0,h2]) cylinder(h=h,r=25,center=true,$fn=fn);		   			
  } //end union 
	 translate([0,0,h2]) cylinder(h=h+0.01,r=15,center=true,$fn=fn);
	 translate([0,0,h]) chamfer_r(3,25, 1,fn);		
	 translate([0,0,h]) chamfer_r(3,15,-1,fn);			
 } //end difference
 translate([0,0,0]) rotate ([0,180,0]) chamfer_r(3,15,1,fn);				
} //end translate

translate([55,55,0]){
 difference(){
  union(){ 
		 translate([0,0,h2]) cylinder(h=h,r=25,center=true,$fn=fn);		  			
  } //end union 
	 translate([0,0,h2]) cylinder(h=h+0.01,r=15,center=true,$fn=fn);
	 translate([0,0,h]) fillet_r(3,25, 1,fn);		
	 translate([0,0,h]) fillet_r(3,15,-1,fn);		
 } //end difference
 translate([0,0,0]) rotate ([0,180,0]) fillet_r( 3,15,1,fn);				
} //end translate
