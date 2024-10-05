/* [PSU Mount] */

// distance between mount holes in mm
m3HoleDist = 95;

// distance from bottom of the extrusion
extrusionDistFromBottomHole = 5;

// bolt head diameter in mm
boltHeadDiameter = 5.5;

// bolt thread diameter in mm
boltThreadDiameter = 3;

// thickness of outside walls in mm
wallWidth=6;

// extrusion profile base in mm (e.g. 20 for V-Slot 2020 or 2040, 15 for Misumi 1515)
profileSize=20;

// number of extrusion slots (width)
sectionCountWidth = 1;

// number of extrusion slots (depth)
sectionCountDepth = 1;

// extrusion slot outside width (9 for 20xx V-Slot, 6 for 20xx T-Slot)
indentWidthOutside = 9;

// extrusion slot inside width (7 for 20xx V-Slot, 6 for 20xx T-Slot)
indentWidthInside = 7;

// extrusion slot depth
vslotIndentHeight = 1;

// tolerance in mm
tolerance=0.5;
cl=0.5;

// distance between screw head and interior
screwHeight = 8;

// screw offset
screwOffset = 5;

/* [Hidden] */
use <../lib.scad>
$fn=100;

// ------------ Constants ------------------------
oversize = tolerance;
lengthHoleSpacing=20;
extrusionWidth=profileSize*sectionCountWidth;
extrusionDepth=profileSize*sectionCountDepth;
nema17Width = 42.3;
nema17HoleRadius = 11.05 + tolerance/2;
nema17Height = 3.5*extrusionWidth;
nema17BoltSpacing = 31;
nema17BeltHoleHeight = 8;
nema17BeltOffsetFromTopExtrusion = 8;
nema17BeltHeightWidth = 15;
wallSpacing=5;
largeHoleIndent = screwHeight-screwOffset;

screwDiameter=boltThreadDiameter;
m3HoleDepth = 4;
m3HoleRadius = screwDiameter/2;
outerRadius = boltHeadDiameter/2;
extrusionOffset = extrusionDistFromBottomHole + wallWidth+outerRadius*2;

// ---------------------------------------------
mirror([1,0,0])
PsuBracket();


module PsuBracket()
{
    h=wallWidth+m3HoleRadius*2;
    
    difference(){
        hull(){
          rcube(h*3,h*3,h,2);
            
            translate([-(m3HoleDist+wallWidth+m3HoleRadius),wallWidth,0])
            cylinder(d=wallWidth*2, h=h);
        
        }
    /***********************/
        translate([h*1.5,h*1.5,5])
       Mscrew(10,5);
        
        
        for (i = [0,m3HoleDist]) {
            translate([-(i + wallWidth + m3HoleRadius), wallWidth, m3HoleDepth]){

                    translate([0,0,-10]) 
                    cylinder(h=sectionCountDepth*profileSize+wallWidth, r=m3HoleRadius+cl);
        
                    cylinder(h=sectionCountDepth*profileSize+wallWidth, r=outerRadius+cl);
                       

            }   
           
        }
                  
    }
      
}

