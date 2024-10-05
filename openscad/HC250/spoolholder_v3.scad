use <../lib.scad>
$fn=200;
tf=0.5; // tolerance fit

spool_diam=200;
len=138;
thick=8;
joiner_diam=8;
t=4;
echo( (spool_diam/2*1.2) / 1.73 * 2 );
echo( "Altura:",len/2 * 1.732);

/*
translate([0,0,142])
rotate([-90,0,0])
arm_cap();
/**/
arm();


module arm_cap(){
    difference(){
        union(){
            translate([len/2-joiner_diam*2-t*0.75,spool_diam/2-joiner_diam/2+5.5,-t*0.375])
            rcube(joiner_diam*4+t*1.5,joiner_diam*2+25,thick+t*.75, 2);
            
        }
        
        arm(tf);
        
        // Oblongs
        translate([0,30,-5]){
            translate([len/2-joiner_diam/3,spool_diam/2+thick/2,-0.1]) 
            rotate([0,0,90])
            oblong(joiner_diam*2,joiner_diam,thick+10);
            translate([len/2+joiner_diam*1.4,spool_diam/2+thick/2,-0.1]) 
            rotate([0,0,90])
            oblong(joiner_diam*2,joiner_diam,thick+10);
        }
    }
}

module arm(tol=0){
    difference(){
        union(){
            // structure
            translate([0,-thick/2,0])
            cube([len,thick,thick]);
            
            translate([thick/2,0,0])
            rotate([0,0,60])
            cube([len,thick,thick]);
            
            translate([len/2-thick/2,len*7/8,0])
            rotate([0,0,-60])
            cube([len,thick,thick]);
            
            // joints
            cylinder(d=joiner_diam+thick, h=thick);
            translate([len,0,0])
            cylinder(d=joiner_diam+thick, h=thick);

            // Spool support
            translate([len/2-joiner_diam*2-tol/2,spool_diam/2-joiner_diam/2,-tol/2])
            rcube(joiner_diam*4+tol,joiner_diam*2,thick+tol, 1);

        }
        
        // Upper cut
        translate([len/3,spool_diam/2+thick+joiner_diam/2,-.1])
        cube([50,50,20]);
        
        // holes
        translate([0,0,-0.1])
        cylinder(d=joiner_diam, h=thick+1);
        translate([len,0,-0.1])
        cylinder(d=joiner_diam, h=thick+1);
        
        // Oblongs
        translate([len/2-joiner_diam/3-tol/2,spool_diam/2+thick/2,-0.1]) 
        rotate([0,0,90])
        oblong(joiner_diam*2,joiner_diam-tol,thick+10);
        translate([len/2+joiner_diam*1.4-tol/2,spool_diam/2+thick/2,-0.1]) 
        rotate([0,0,90])
        oblong(joiner_diam*2,joiner_diam-tol,thick+10);
    }
}
