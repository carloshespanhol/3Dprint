$fn=256;

thick=1;
diam=90;
h=6;
num_ribs=8;
s=diam/2/num_ribs;
floor_width=1.6;
rib_height=floor_width+1;
rib_width=1;
slot=5;

coaster();
ribs();

module ribs(){
    difference(){
        for(i=[s:s:diam/2-s]){
            rotate_extrude() 
            translate([i,0,0])
            square([rib_width,rib_height]); 
        }
        
        translate([-diam/2,-slot/2,-.1])
        cube([diam,slot,h*2]);
    }
}

module coaster() {
    difference() {
      cylinder(h=h, d1=diam, d2=diam+h);
        
      translate([0,0,floor_width]) 
      cylinder(h=h, d1=diam-thick, d2=diam+h-thick);
    } 
}
