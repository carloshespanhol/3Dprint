$fs=0.2;
//Diametro Carretel 1Kg 
d1=205;
//Diametro Carretel 0.5Kg 
d05=160;
// 80, 100, 65, 85, 100, 70
dist=100;


bearingDiameter=22;
bearingWidth=7;
bearingHole=8;
tolerance=0.28;
wallWidth=4;
thickness=1.2;
axisDiameter=8;
footHeight=25;
space=12;
/***************************************/
bd=bearingDiameter;
bw=bearingWidth;
bh=bearingHole;
ad=axisDiameter;
fh=footHeight;
s=space;
tol=tolerance;
ww=wallWidth;
t=thickness;


/**/
cap();

translate([-bh, bd,-.1]) collar();
translate([ bh, bd,-.1]) collar();

/********
rotate([0,90,0]) cap();
translate([80,0,0])
rotate([0,90,0]) cap();
translate([0,dist,0])
rotate([0,90,0]) cap();
translate([80,dist,0])
rotate([0,90,0]) cap();

translate([-10,0,0])
rotate([0,-90,0]) 
foot();

/**
translate([bw/2,dist/2, d1/2+1])
%rotate([0,90,0]) cylinder(d=d1, h=80);
/**
translate([bw/2,dist/2, d05/2-2])
%rotate([0,90,0]) cylinder(d=d05, h=80);
/**/


module foot(){
    difference() {
        union() {
            hull(){
                cylinder(d=bd, h=ww);

                translate([-bd,0,0])
                cube([10,bd,ww]);
            }
            
            hull(){
                translate([0,dist,0])
                cylinder(d=bd, h=ww);
            
                translate([-bd,dist-bd,0])
                cube([10,bd,ww]);
            }

            translate([-bd,0,0])
            cube([15,dist,ww]);
        }
        
        translate([0,0,-.1])
        cylinder(d=ad+tol, h=s+bw);
        translate([0,dist,-.1])
        cylinder(d=ad+tol, h=s+bw);
    }    
}


module collar(){
    difference() {
        union() {
            cylinder(d1=bh+t*4, d2=bh+t*2, h=s/2);
            
            translate([0,0,s/2])
            cylinder(d=bh, h=bw/2-tol);
        }
        
        translate([0,0,-.1])
        cylinder(d=ad+tol, h=s+bw);
    }    
}

module cap(){
    difference() {
        union() {
            cylinder(d=bd+t*2, h=bw);
            
            
            cylinder(d=bd+t*2+bw, h=.5);
            translate([0,0,.5])
            cylinder(d1=bd+t*2+bw, d2=bd+t*2, h=bw/2-1);
            
            translate([0,0,bw/2+.5])
            cylinder(d2=bd+t*2+bw, d1=bd+t*2, h=bw/2-1);
            translate([0,0,bw-.5])
            cylinder(d=bd+t*2+bw, h=.5);
        }
        
        translate([0,0,-.1])
        cylinder(d=bd+tol, h=bw+1);
    }
}

module holder(){
    translate([wallWidth+spacerDepth+0.15,0,0]) rotate([0,90,0]) %cylinder(7, r=22/2);

    translate([80,0,73])
    rotate([90,0,0])
    import("/home/hespanhol/Downloads/USHR_Foot.stl");


    rotate([0,90,00]) bearingHolder();
    rotate([0,90,00]) translate([0,holderDistance,0]) bearingHolder();


    if (doubleSided) {
    translate([-mainOutlineLength+wallWidth,0,0]) rotate([0,90,00]) bearingHolder();
    translate([-mainOutlineLength+wallWidth,0,0]) rotate([0,90,00]) translate([0,holderDistance,0]) bearingHolder();
    }


    translate([0,0,-wallWidth*7]) scale([wallWidth,holderDistance,wallWidth*3]) cube(1);
}

module mainOutline() {
    union() {
        translate([0,0,0])cylinder(mainOutlineLength, r=bearingRadius+wallWidth/2);
    }
        
    translate([0,-bearingRadius-wallWidth/2,0])
        scale([wallWidth*7, 2*(bearingRadius+wallWidth/2),mainOutlineLength ]) 
        cube(1);
}

module bearingOutline() {
    cubeX=150;
    cubeY=spacerDepth*2+bearingWidth;
    cubeZ=100;
    
    rotate([90,0,-90])
    translate([ -cubeX/2,
                mainOutlineLength/2-cubeY/2,
                //hard coded depth
                -23])
    scale([cubeX,cubeY,cubeZ]) cube(1);
}


module mainCutout() {
    difference() {
        mainOutline();
        bearingOutline();
    }
}

module bearingHolder() {
    difference() {
        union() {
            mainCutout();
            translate([ 0,0, 
                        mainOutlineLength/2+bearingWidth/2]) 
            cylinder(spacerDepth, r1=holderRadius+spacerRadius, r2=holderRadius+spacerRadius+spacerDepth);
            
            
            translate([0,0,
                        mainOutlineLength/2-bearingWidth/2-spacerDepth]) 
            cylinder(spacerDepth, r1=holderRadius+spacerRadius+spacerDepth, r2=holderRadius+spacerRadius);            
        }
        
        translate([0,0,-150]) 
        cylinder(300,r=holderRadius);
    }
}
