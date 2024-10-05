fn = 128;

motorHoles = [[-15.5, -15.5], [-15.5, 15.5], [15.5, 15.5], [15.5, -15.5]];
motorScrewRadius = 3.5/2;
motorScrewHeadRadius = 6.5/2;
motorWidth = 42.3;

filamentRadius = 1.75/2;
filamentTunnelRadius = filamentRadius+0.5;
pneufitRadius = 9/2;
pneufitHeight = 8;

drivegearOuterRadius = 9/2;
drivegearHobbedRadius = 7.5/2;

idlerHeight = 3;
idlerOffset = 0.25; // spacing between base and idler
idlerScrewRadius = 2.8/2;   // screw to lock the bearing

bearingRadius = 11;
bearingInnerRadius = 7.8/2;
bearingHeight = 7;

basePlateHeight = 5;
baseHeight = basePlateHeight + idlerOffset + idlerHeight + bearingHeight + 2.75;

springRadius = 7.5/2;
springLength = 16;  // aka. spring-preload //16=min
springHullLength = 1;

mountPlate = 1;     // 1=true; 0=false;
mountPlateHeight = 5;
mountPlateScrewRadius = 4/2;

/* ############################################################### */

// BASE
baseComplete();

// IDLER
translate([0, -motorWidth-3, -basePlateHeight-idlerOffset]) 
    idlerComplete();

// support-structure @ drivegear
//cylinder(r=drivegearOuterRadius+1.1, h=3, $fn=fn);  // doesn't work pretty well

// Dummy-FILAMENT
%filament();

// DUMMY-DRIVEGEAR
%translate([0,0,6])    cylinder(r=drivegearOuterRadius, h=9, $fn=fn);

// dummy-608
translate([-bearingRadius-drivegearHobbedRadius-filamentRadius*2, 0, basePlateHeight+idlerHeight+idlerOffset]) 
        %cylinder(r=bearingRadius, h=bearingHeight, $fn=fn);    // 608-dummy

/* ############################################################### */

module mountplateBottom() {
    radius = 4;
    
    difference() {
        hull() {
            translate([0, -motorWidth/2+mountPlateHeight/2, baseHeight/2])
                cube([motorWidth, mountPlateHeight, baseHeight], center=true);
            
            //left
            translate([motorWidth/2+mountPlateScrewRadius+2, -motorWidth/2+mountPlateHeight/2, radius])
                rotate([90, 0, 0])
                    cylinder(r=radius, h=mountPlateHeight, center=true, $fn=fn);
            translate([motorWidth/2+mountPlateScrewRadius+2, -motorWidth/2+mountPlateHeight/2, baseHeight-radius])
                rotate([90, 0, 0])
                    cylinder(r=radius, h=mountPlateHeight, center=true, $fn=fn);
            
            
            //right
            translate([-motorWidth/2-mountPlateScrewRadius-2, -motorWidth/2+mountPlateHeight/2, radius])
                rotate([90, 0, 0])
                    cylinder(r=radius, h=mountPlateHeight, center=true, $fn=fn);
            translate([-motorWidth/2-mountPlateScrewRadius-2, -motorWidth/2+mountPlateHeight/2, baseHeight-radius])
                rotate([90, 0, 0])
                    cylinder(r=radius, h=mountPlateHeight, center=true, $fn=fn);
        }
        
        translate([motorWidth/2+mountPlateScrewRadius+2, -motorWidth/2+mountPlateHeight/2-0.1, baseHeight/2])
                rotate([90, 0, 0])
                    cylinder(r=mountPlateScrewRadius, h=100, center=true, $fn=fn);
        
        translate([-motorWidth/2-mountPlateScrewRadius-2, -motorWidth/2+mountPlateHeight/2-0.1, baseHeight/2])
                rotate([90, 0, 0])
                    cylinder(r=mountPlateScrewRadius, h=100, center=true, $fn=fn);
    }
}

module mountplateBottom_old() {
    difference() {
        hull() {
            translate([0, -motorWidth/2+mountPlateHeight/2, baseHeight/2])
                cube([motorWidth, mountPlateHeight, baseHeight], center=true);
            
            translate([motorWidth/2+5, -motorWidth/2+mountPlateHeight/2, baseHeight/2])
                rotate([90, 0, 0])
                    cylinder(r=mountPlateScrewRadius+3, h=mountPlateHeight, center=true, $fn=fn);
            
            translate([-motorWidth/2-5, -motorWidth/2+mountPlateHeight/2, baseHeight/2])
                rotate([90, 0, 0])
                    cylinder(r=mountPlateScrewRadius+3, h=mountPlateHeight, center=true, $fn=fn);
        }
        
        translate([motorWidth/2+5, -motorWidth/2+mountPlateHeight/2-0.1, baseHeight/2])
                rotate([90, 0, 0])
                    cylinder(r=mountPlateScrewRadius, h=100, center=true, $fn=fn);
        
        translate([-motorWidth/2-5, -motorWidth/2+mountPlateHeight/2-0.1, baseHeight/2])
                rotate([90, 0, 0])
                    cylinder(r=mountPlateScrewRadius, h=100, center=true, $fn=fn);
    }
}

module baseComplete() {
    difference() {  // baseplate
        union() {
            if(mountPlate==1) mountplateBottom();
            
            // spring-hull
            translate([motorWidth/2-springRadius-3, -drivegearOuterRadius-1+springHullLength, (baseHeight-basePlateHeight-idlerOffset)/2+basePlateHeight+idlerOffset])
                    rotate([90,0,0])
                        cylinder(r=springRadius+2, h=springHullLength, $fn=fn);    
            
            intersection() {
                basePlate();
                baseIntersection();
            }
        }
        driveGearCutout();
        idlerCutout();
        spring();
        filamentTunnel();
        screwHolesBase();
        
        //translate([0, -drivegearOuterRadius-1, basePlateHeight])
        //    cube([100, drivegearOuterRadius+2, 100]);           // straight cut
        
        translate([0, 0, -0.1])    
            cylinder(r=23/2, h=3);                         // nema17 center-cutout
    }
}

module idlerComplete() {
    difference() {      // idler
        union() {
            // spring-hull
            translate([motorWidth/2-springRadius-3, 11.6-1, (baseHeight-basePlateHeight-idlerOffset)/2+basePlateHeight+idlerOffset])
                    rotate([90,0,0])
                        cylinder(r=springRadius+2, h=springHullLength+2, $fn=fn);
            
            intersection() {
                idler();
                baseIntersection();
            }
        }
        driveGearCutout();
        spring();
        filamentTunnel();
        screwHolesIdler();
        
        //translate([0,0,0])
//            cube([100, drivegearOuterRadius, 100]);   // straight cut
        
        translate([0, 60, -0.1])
            cylinder(r=41, h=100, $fn=fn);      // abrundung
        
        translate([-bearingRadius-drivegearHobbedRadius-filamentRadius*2, 0, -50]) 
            cylinder(r=idlerScrewRadius, h=100, $fn=fn);   // m3-bearing-fix
    }
}

module screwHolesIdler() {
    translate(motorHoles[1]) translate([0,0,-0.1])
            cylinder(r=motorScrewRadius, h=100, $fn=fn);
    translate(motorHoles[1]) translate([0,0,basePlateHeight+idlerHeight])
            cylinder(r=motorScrewHeadRadius, h=100, $fn=fn);
}

module screwHolesBase() {
    translate(motorHoles[0]) translate([0,0,-0.1])
            cylinder(r=motorScrewRadius, h=100, $fn=fn);
    translate(motorHoles[0]) translate([0,0,basePlateHeight])
            cylinder(r=motorScrewHeadRadius, h=100, $fn=fn);
    
    translate(motorHoles[3]) translate([0,0,-0.1])
            cylinder(r=motorScrewRadius, h=100, $fn=fn);
    translate(motorHoles[3]) translate([0,0,basePlateHeight])
            cylinder(r=motorScrewHeadRadius, h=100, $fn=fn);
    
    translate(motorHoles[1]) translate([0,0,-0.1])
            cylinder(r=motorScrewRadius, h=100, $fn=fn);
    
    translate(motorHoles[2]) translate([0,0,-0.1])
            cylinder(r=motorScrewRadius, h=100, $fn=fn);
    translate(motorHoles[2]) translate([0,0,2])
            cylinder(r=motorScrewHeadRadius, h=100, $fn=fn);
}

module filamentTunnel() {
    // entrance
    hull() {
        translate([-drivegearHobbedRadius-filamentRadius, motorWidth/2+0.1, basePlateHeight+idlerHeight+bearingHeight/2])
            rotate([90, 0, 0])
                cylinder(r=filamentRadius*3, h=0.1, $fn=fn);                          
        translate([-drivegearHobbedRadius-filamentRadius, motorWidth/2-10, basePlateHeight+idlerHeight+bearingHeight/2])
            rotate([90, 0, 0])
                cylinder(r=filamentRadius, h=0.1, $fn=fn);
    }
    
    translate([-drivegearHobbedRadius-filamentRadius, 50, basePlateHeight+idlerHeight+bearingHeight/2])
        rotate([90, 0, 0])
            cylinder(r=filamentTunnelRadius, h=100, $fn=fn);                    // filament tunnel
    
    translate([-drivegearHobbedRadius-filamentRadius, -motorWidth/2+pneufitHeight-0.1, basePlateHeight+idlerHeight+bearingHeight/2])
        rotate([90, 0, 0])
            cylinder(r=pneufitRadius, h=pneufitHeight, $fn=fn);             // pneufit
}

module filament() {
    translate([-drivegearHobbedRadius-filamentRadius, 50, basePlateHeight+idlerHeight+bearingHeight/2])
        rotate([90, 0, 0])
            color("green", 0.4) cylinder(r=filamentRadius, h=100, $fn=fn);
}

module spring() {
    translate([motorWidth/2-springRadius-3, springLength-drivegearOuterRadius-2, (baseHeight-basePlateHeight-idlerOffset)/2+basePlateHeight+idlerOffset])
        rotate([90,0,0])
            cylinder(r=springRadius, h=springLength, $fn=fn);
}

module idlerCutout() {
    translate([-bearingRadius-drivegearHobbedRadius-filamentRadius*2, 0, basePlateHeight])
        cylinder(r=bearingRadius+1, h=100, $fn=fn);
}

module idler() {
    difference() {
        union() {
            hull() {
                translate(motorHoles[1])   
                    translate([0,0,basePlateHeight+idlerOffset])
                        cylinder(r=bearingInnerRadius+3, h=baseHeight-basePlateHeight-idlerOffset, $fn=fn);    // idler_umlenk
                
                translate(motorHoles[2])   
                    translate([0,0,basePlateHeight+idlerOffset])
                        cylinder(r=bearingInnerRadius+3, h=baseHeight-basePlateHeight-idlerOffset, $fn=fn);    // idler_umlenk
            }
            
            hull() {
                translate([-bearingRadius-drivegearHobbedRadius-filamentRadius*2, 0, basePlateHeight+idlerOffset]) 
                    cylinder(r=bearingInnerRadius+3, h=baseHeight-basePlateHeight-idlerOffset, $fn=fn);
                
                translate(motorHoles[1])   
                    translate([0,0,basePlateHeight+idlerOffset])
                        cylinder(r=bearingInnerRadius+10, h=baseHeight-basePlateHeight-idlerOffset, $fn=fn);    // idler_umlenk
            }
        }
        
        translate([-bearingRadius-drivegearHobbedRadius-filamentRadius*2, 0, basePlateHeight+idlerHeight+idlerOffset-0.5])
            cylinder(r=bearingRadius+1, h=50, $fn=fn);                                 // bearing-cutout
    }
    
    translate([-bearingRadius-drivegearHobbedRadius-filamentRadius*2, 0, basePlateHeight+idlerHeight+idlerOffset-0.5]) 
        cylinder(r=6, h=0.5, $fn=fn);                                // lager-spacer
    
    translate([-bearingRadius-drivegearHobbedRadius-filamentRadius*2, 0, basePlateHeight+idlerHeight+idlerOffset]) {
        //%cylinder(r=bearingRadius, h=bearingHeight, $fn=fn);    // 608-dummy
        difference() 
            cylinder(r=bearingInnerRadius, h=bearingHeight, $fn=fn);    // 608-innendurchmesser
    }
}

module driveGearCutout() {
    cylinder(r=drivegearOuterRadius+1, h=100, center=true, $fn=fn);
}

module basePlate() {
    polyArray = [[-100, 0], [0, 0], [0, -drivegearOuterRadius-1], [100, -drivegearOuterRadius-1], [100, -100]];     // fester teil
    
    translate([0, 0, baseHeight/2])
        linear_extrude(height = baseHeight, center = true, convexity = 20) 
            polygon(polyArray);                                         // fester teil
    
    translate([0, 0, basePlateHeight/2])
        cube([motorWidth, motorWidth, basePlateHeight], center=true);   // baseplate
    
    translate(motorHoles[1])
        cylinder(r=motorScrewRadius+1, h=basePlateHeight+idlerOffset, $fn=fn);    // spacer baseplate/idler
    
    translate(motorHoles[0])
        cylinder(r=6, h=baseHeight, $fn=fn);                                    // ecke links unten
}

module baseIntersection() {
    edgeRadius = 27;
    
    translate([0,0,-1])
        intersection() {
            cube([motorWidth, motorWidth, 100], center=true, $fn=fn);
            cylinder(r=edgeRadius, h=100, center=true, $fn=fn);
        }
}