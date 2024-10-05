
// 51101 Thrust Ball Bearing 

$fn=60;

thrustBearing();

// Thrust bearing
module thrustBearing() { 
    $fn=60;
    difference() {
      union() {
        color( "SlateGray", 1.0 ) {cylinder(h=2.52, d=23.9);}
        *color( "FireBrick", 1.0 ) {translate([0,0,3.36]) cylinder(h=2.4, d=23.9);}
        *color( "SlateGray", 1.0 ) {translate([0,0,6.59]) cylinder(h=2.54, d=23.9);}
      }
        translate([0,0,-.1]) cylinder(h=9.4, d=10.4);

    
// ball bearings x9
    trackRadius = 8.325;
    color( "Linen", 1.0 ) {
    for (a =[0:8]) {
        translate ([sin(a*45)*trackRadius,cos(a*45)*trackRadius,4.55]) sphere(d=4.8);
  
    }
}
    }
}

