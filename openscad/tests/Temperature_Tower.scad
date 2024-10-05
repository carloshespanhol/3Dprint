/* 
*  Copyright (c)..: 2018 janpetersen.com
*
*  Creation Date..:08/24/2018
*  Description....: Temperature Tower
*
*  Rev 1: Intitial Release
*
*  This program is free software; you can redxribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is dxributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  If used commercially attribution is required (janpetersen.com)
*
*
*   Thingiverse Customizer documentation:
*   http://customizer.makerbot.com/docs
*
*
*/

/* ----- customizer view ----- */
//preview[view:south east, tilt:side]

/* ----- parameters ----- */

// Degrees to change between each step
tempStep = 5;
// Minimum temperature for the tower
minTemp = 280; // [190:1:260]
// Maximum temperature for the tower
maxTemp = 280; // [190:1:260]
// Hight of the base
baseHeight = 1; // [0.4:0.2:3]

/* [Hidden] */
$fn=100; // recomended value for smooth circle is 60
sectionHeight=10;

/* ----- execute ----- */

rotate([0,0,180])
mainModule();

/* ----- modules ----- */
bp=7;
dx=40;
dy=5;
lw=0.48; //lineWidth
ew=0.6 + 0.01;  //external width

module mainModule() {
    z = baseHeight;
    secCount = floor((maxTemp - minTemp) / tempStep);
    
    base();
    
    for(i=[0:1:secCount]) {
        translate([0, 0, z+i*sectionHeight]) {
            difference() {
                raiserBlock(maxTemp);
                //emboss text
                translate([10, bp+2, 5])
                    rotate([90, 0, 180])
                        linear_extrude(height = 1.2)
                            text(text=str(maxTemp-i*tempStep), font="Arial:style=Narrow Bold", size=5, valign="center", halign="center");
            }
            
            backPoles();
            bridges();
            spike();
        }
    }

    translate([-dx-10, 0, 0])
    cube(size=[10, 20, 3]);
}


module base() {
    difference(){
        union(){
            translate([2.5, 0, 0])
            cube([20, 20, 3]);
       
            translate([-dx-bp-3, 0, 0])
            cube([bp+3, bp+dy, baseHeight]);
        
            translate([-dx-bp-3, 10, 0])
            cube([dx+20+5.5+bp, 10, baseHeight]);
        }
        
        translate([-dx+bp+1, 2.4, -.01])
        cube([dx, bp-2.4, 2]);        
        
        translate([-dx+bp+1, -.01, -.01])
        cube([dx, 2.5, 5]);        
    }
}
module backPoles() {
    translate([-dx-bp, 2.5, -1])
    cube(size=[15, bp, sectionHeight+1], center=false);
    
    /*
    translate([-dx+bp/2, dy+bp, 0])
        cylinder(d=bp, h=sectionHeight);
    */
}

module bridges() {
    f=0.6; //cylinder factor
    bh=2.5;
    cw=ew*2 - .1;
    
    /* Bridge - 1mm after temp change to give time to stabilize */
    translate([-dx, 2.5, 1])
    cube([dx+15, bp, 1]);
    
    /**
    translate([-dx/2, 2.5, 1])
    cube([2.5, cw, sectionHeight-3]);
    translate([-dx/2, bp+2.5-cw-ew*2, 1])
    cube([2.5, cw, sectionHeight-3]);
    translate([-dx/6*4, bp+2.5-cw-ew*2, 1])
    cube([2.5, cw, sectionHeight-3]);
    translate([-dx/6*4, bp+2.5-cw-ew*2, sectionHeight/2-.5])
    cube([dx/6, cw, 2]);
    translate([-dx/6*4, 2.5, 1])
    cube([cw, bp-ew*2, sectionHeight-3]);
    
    /**/
    translate([8,0,0]){
        translate([-dx/4*3, 2.5, 1])
        cube([ew, bp-ew*2, sectionHeight-3]);
        translate([-dx/4*3.5, 2.5, 1])
        cube([dx/4*.5, ew, sectionHeight-3]);
        translate([-dx/4*3.5, 2.5, 1])
        cube([ew, bp-ew*2, sectionHeight-3]);
    }
    /**/
    
    // Border
    difference(){
        union(){                
            translate([-dx, bp+2.5-ew, 1])
            cube([dx+3, ew, bh]);

            translate([-dx/3, bp-ew, 1])
            cylinder(d=lw+ew*2, h=bh);
            
            translate([-dx/3-(lw+ew*2)/2, bp-ew, 1])
            cube([lw+ew*2, bp/2-ew , bh]);
        }
        
        translate([-dx/3, bp-ew, .5])
        cylinder(d=lw-.1, h=bh*2);
        
        translate([-dx/3-(lw-.1)/2, bp-ew, .5])
        cube([lw-.1, bp , bh*2]);
    }
}

module spike() {
    translate([-dx/8, 2.5+bp/2-.25, 1])
        cylinder(d1=bp-1, d2=lw*2, h=sectionHeight-3);
}

module raiserBlock(temp) {

    // Right section of tower block
    translate([2.5, 2.5, 1])
    difference() {
        intersection() {
            cube([12.5, bp-2.5, sectionHeight]);
            translate([0, sectionHeight/2, 0])
                rotate(a=[0, 90, 0])
                    cylinder(h=12.5, r=sectionHeight/2);
        }
    }
    translate([bp+1, 2.5, -.01])
    cube([bp, bp-2.5, 2]);        
    
    //triangle
    translate([2.5, 2.5, sectionHeight])
     hull(){
         cube([13,bp-2.5,.01]);
         
         translate([0, bp-2.5, -3.5])
         cube([13,.01,.5]);
     }

    /* backBlock */
    translate([2.5, bp, 0])
    cube(size=[12.5, 2.5, sectionHeight], center=false);
    
    // Left section of tower block
    radius = 13; 
    intersection() {
        difference() {
            translate([14, 2.5, 0])
                cube(size=[12, bp, sectionHeight], center=false);
            translate([30, 1, -3])
                rotate(a=[-90,0,0])
                    cylinder(h=bp*2, r=radius);
        }
        union() {
            translate([bp*2-2.5, 2.5, 0])
                cube([2.5, bp-2.5, sectionHeight]);
            
            translate([bp*2+3.75, bp*1.75, 0])
                cylinder(h=13, d=bp*3);
        }
    }

}
// End Modules