$fn=100;
// 150 x 85

t=1.2;
l=170;
w=95;
h=t+6;
rs=3.5;
r=10;
hs=3.7;
ho=10;

difference(){
    u=ho+hs;
    nw  = floor((w-ho) / u);
    nl  = floor((l-ho) / u);
    by = (w-(u*nw)+hs)/2;
    bx = (l-(u*nl)+hs)/2;
    
    union(){
        hull(){
            translate([r,r,0])
            cylinder(r=r, h=t);
            translate([r,w-r,0])
            cylinder(r=r, h=t);
            translate([l-r,w-r,0])
            cylinder(r=r, h=t);
            translate([l-r,r,0])
            cylinder(r=r, h=t);
        }
        
        translate([bx+u-hs/2-t/2, by+ho, 0])
        cube([t,w-by*2-ho*2,h]);
        translate([l-bx-u+hs/2-t/2, by+ho, 0])
        cube([t,w-by*2-ho*2,h]);

        translate([l/2-t/2, by+ho, 0])
        cube([t,w-by*2-ho*2,h]);
    }
    //------------------------------------
    //row
    for(i=[0:nl-1]){
        // col
        for(j=[0:nw-1]){
            translate([bx+u*i,by+u*j,-.1]){
                cube([ho,ho,t+1]);
            }
        }
    }
}    
