$fn=100;
dr=10;
l=120;
w=25;
t=6;
tz=10;

hammock();

module hammock(){
    difference(){
        hull(){
            translate([w/2-t,-w/2,0])
            cube([l,w,tz]);
                       
            cylinder(d=w, h=tz);
            
            translate([l+w/2,0,0])
            cylinder(d=w, h=tz);
        }
        //-------------------
        translate([0,0,-.1])
        cylinder(d=w-t*2, h=tz+1);
        translate([l+w/2,0,-.1])
        cylinder(d=w-t*2, h=tz+1);
        
        translate([-w,-dr/2,-.1])
        cube([w,dr,tz+1]);
        translate([l+w/2,-dr/2,-.1])
        cube([w,dr,tz+1]);
        
    }
}

