use <../lib.scad>
$fn=100;

difference(){
    union(){

        translate([10,30,0])
        difference(){
            translate([40,0,0])
            cube([30,30,15]);

            translate([50,-1,3])
            cube([10,40,3]);    

            translate([50,-1,9])
            cube([10,40,3]);    

            translate([75,10,3])
            rotate([0,0,90])
            cube([10,40,3]);    

            translate([75,10,9])
            rotate([0,0,90])
            cube([10,40,3]);    
        }    
    }

    translate([10,30,0])
    translate([40.6,0.6,0.5])
    cube([28.8,28.8,20]);
}


