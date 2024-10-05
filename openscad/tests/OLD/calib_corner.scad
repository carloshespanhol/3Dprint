$fn=100;

h=2;
do=18;
di=5;

corners();

module corners(){

	difference(){
	
		//Main Body 
		union(){

			cylinder(h=h,d=do); 

		}
	
        // Hole
        translate([0,0,-.1])
        cylinder(h=h+1,d=di); 
        
		// Small Grooves 
		for ( i = [0 : 3] ){	
		    rotate( i * 360 / 3, [0, 0, 1])
		  	  translate([0, 11, -.1])
		  		 cylinder(h=h+1,d=6);
		}
			
		//Large Grooves 
        rotate([0,0,360/6]){
            for ( i = [0 : 3] ){	
                rotate( i * 360 / 3, [0, 0, 1])
                  translate([0,  17, -.1])
                    cylinder(h=h+1,d=20);
            }
        }
	}
}

			


