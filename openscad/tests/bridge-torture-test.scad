$fn=100;

bridge_length = 40;
bridge_angle = 0;
bridge_width = 6;

bridge_recovery_layers = 5;

layer_height = 0.32;
extrusion_width = 0.88;
height=3;
solid_strut=1;
foot_border=4;
strut_length=15;
top_cylinder=0;

bridge2();


/**********************************/
module bridge2(){
    min=20;
    max=40;
    base=0.5;
    p=10;
    h=5;
    bh=layer_height * bridge_recovery_layers + 0.01;
    // poles
    hull(){
        translate([0,min,0])
        cube([p,p,h]);

        translate([0,max,0])
        cube([p,p,h]);
    }
    
    hull(){
        translate([0,min,0])
        cube([p,p,base]);

        translate([0,max,0])
        cube([p,p,base]);

        translate([min+p*2-1,min,0])
        cube([1,p,base]);

        translate([max+p*2-1,max,0])
        cube([1,p,base]);
    }
    /**/
    // bridges
    for( i = [min:p*2:max]){
        hull(){
            translate([0,i,h-bh])
            cube([p,p,bh]);

            translate([i,i,h-bh])
            cube([p,p,bh]);
        }
        // pole
        translate([i+p,i,0])
        cube([p,p,h]);
    }
}    

module foot() {
    b= foot_border;
    e=height*cos(45);
    translate([-b-e,-b-e,0])
    cube([strut_length+b*2+e*2, bridge_width+b*2+e*2, layer_height]);
}

module strut() {
    e=height*cos(45);
	difference() {
        hull(){
            translate([-e,-e,0])
            cube([strut_length+e*2, bridge_width+e*2, .1]);

            translate([0,0,height])
            cube([strut_length, bridge_width, .1]);
        }

        if (solid_strut == 0){
            translate([0, 0, -1])
            cylinder(r1=(bridge_width / 1.5 - extrusion_width * 2) / cos(45), r2=(bridge_width / 2 - extrusion_width * 2) / cos(45), h=10, $fn=4);
        }
	}
}

module bridge1(){
    rotate(bridge_angle) {
        // Feet
        translate([0, 0, 0]) foot();
        translate([bridge_length + strut_length, 0, 0]) foot();

        // Structures
        translate([0, 0, 0]) strut();
        translate([bridge_length + strut_length, 0, 0]) strut();

        // Bridge
        translate([0, 0, height]) 
        cube([bridge_length + strut_length*2, bridge_width, layer_height * bridge_recovery_layers]);

        // Top cylinder
        if(top_cylinder == 1){
            translate([bridge_length / 2 + strut_length, bridge_width/2, height + layer_height * bridge_recovery_layers])
            difference() {
                cylinder(r=bridge_width / 2, h=bridge_width/3);
                cylinder(r=bridge_width / 2 - extrusion_width, h=5);
            }
        }
    }
}
