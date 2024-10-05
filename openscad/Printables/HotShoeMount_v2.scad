
hotshoemount();

module hotshoemount() {

    // Base
    translate([0,5.9,0]) 
    cube([45,3,17.5], center=true);
    translate([0,14,-7.25]) 
    cube([45,15,3], center=true);

	difference() {

		cube([20,14.8,17.5], center=true);

		translate([0,-7.6,0]) {
			cube([9.4,2.5,18], center=true);
		}
	
		translate([-8.125,-0.60,0]) {
			cube([3.99,10,18], center=true);
		}
	
		translate([-9.65,-6.5,0]) {
			cube([1,2,18], center=true);
		}
	
	
		translate([8.125,-0.60,0]) {
			cube([3.99,10,18], center=true);
		}
	
		translate([9.65,-6.5,0]) {
			cube([1,2,18], center=true);
		}

	}


}




