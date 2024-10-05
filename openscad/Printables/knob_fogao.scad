use <../lib.scad>

$fn=300;
t=4;
d=6.1;
c=5;
h=9;
ph=12;
do=46;
y=d/2-(d-c);
rt=false;
th=21;
lt=34;

knob();

module knob(){
// Sacrifice Bridge
*#translate([0,y,h/2])
cylinder(d=(do/3*2), h=.39);

// pin
difference(){
    translate([0,d/2-(d-c),0])
    cylinder(d=d+t*2, h=h);

    difference(){
        translate([0,d/2-(d-c),-.1])
        cylinder(d=d, h=h+1);
        
        translate([-d/2,-d,-.2])
        cube([d,d,h+1]);
    }
}
difference(){
    i=5;
    w=14;
    r=2;
    
    union(){
        // round base top
        if(rt){
            hull(){
                translate([0,y,h])
                cylinder(d=do-i, h=.1);
                translate([0,y,h+4])
                cylinder(d=d*2, h=.1);
            }
        }
        hull(){
            translate([0,y,0])
            cylinder(d=do, h=2);
            translate([0,y,h])
            cylinder(d=do-i, h=.1);
        }
        
        hull(){
            translate([-w/2,-do/2+y+i/2,h-.1])
            intersection(){
                translate([0,-i/2,0])
                rcube(w,do,.1, 2);
                translate([w/2,(do-i)/2,0])
                cylinder(d=do-i, h=1);
            }
            translate([-w/2,-lt/2+y,th-r])
            rcube(w,lt,.1, r);
        }
        translate([-w/2,-lt/2+y,th-r-.2])
        round_plane(w,lt, r);
    }
    //---------------------------
    // pin
    difference(){
        translate([0,d/2-(d-c),-.1])
        cylinder(d=d, h=ph);
        
        translate([-d/2,-d,-.2])
        cube([d,d,ph+1]);
    }
    hull(){
        translate([0,y,-.1])
        cylinder(d=do/4*3, h=.1);
        translate([0,y,h/2])
        cylinder(d=(do/4*3)-h, h=.1);
    }
    // Mark
    translate([-1,12,th-1])
    cube([2,20,5]);
}
}
