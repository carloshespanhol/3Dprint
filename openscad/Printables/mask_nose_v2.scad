use <../lib.scad>
$fn=200;


sh=90;
t=2;
h=30;

rotate([0,90,0])
difference(){
    union(){
        translate([0,0,0])
        cylinder(d=sh, h=h/4);

            
        // nose support
        translate([-sh/2+.5,-2,t])
        rotate([0,0,0]) {
            cube([4,5,h]);
            /*
            translate([0,5,10+t])
            rotate([0,0,90])
            vcylinder(d=15,h=4);
            /* clip */
            translate([-t-1,0,h-5])
            cube([t,5,5]);
            translate([-t-1,0,h-t])
            cube([t+1+4,5,t]);
        }
    }


    // Cut 
    translate([10,0,-.1])
    cylinder(d=80, h=h);
    
    translate([-5,-sh,-.1])
    cube([sh,sh*2,h]);
    
    //
    translate([t*2,0,-.1])
    cylinder(d=sh, h=h*2);
    
    translate([-sh/2+3,-sh,-.1])
    cube([sh,sh*2,h*2]);
    
}
