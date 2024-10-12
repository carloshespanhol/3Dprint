

// Psu width
psuWidth = 115;

// Psu Depth
psuDepth = 49;

// Cover desired Height
coverHeight = 70;

screwInterCenter = 25;
screwDiameter    = 4.5;
screwX = 10;
screwY = 05;

// Cable out window depth
cableOutDepth = 10;

// Cable out window width
cableOutWidth = 80;


// Connector at front (else at side)
connIsAtFront = true;

// Connector Hole Width
connWidth  = 48;

// Connector hole Height
connHeight = 28;

// Connector XPos
connXPos = 25;

// Connector YPos
connYPos =7;

// Has screw holes
connHasScrewHoles = true;

// Connector screw diameteer
connScrewDiam = 4;

// Connector screwHole center distance 
connScrewCenterDst = 40;

// Connector screwhole rotation
connScrewHoleRotation =0;

// Ventilation lines
nVentilationLines = 8;
ventilationHeight = 3.9;
ventilationFrontLength = 100;
ventilationSideLength = 30;

// wallThick
wallThick =3;

$fn=50;

difference () {
    
    // Main Box
    // Outside
    minkowski()
    {
        cube ([psuWidth, coverHeight  , psuDepth -wallThick ], center = true);
        sphere(r=wallThick);
    }
    
    // Inside
    translate ( [0, wallThick, wallThick])
        minkowski()
        {
            cube ([psuWidth-2*wallThick, coverHeight  , psuDepth-wallThick ], center = true);
            sphere(r=wallThick);
        }
    
    // remove some round corners
    translate ( [0, coverHeight/2, wallThick])
        cube ([psuWidth , coverHeight  , psuDepth + wallThick ], center = true);
    
    // Connector hole
    if (connIsAtFront)
    {
        translate ([0,0,-(psuDepth ) /2])
        ConnectorHole();
    }
    else
    {
        translate ([-(psuWidth+wallThick)/2,0,0])
            rotate([0,90,0])
                ConnectorHole();
    }
 
    // Cable output
    translate([0,-(coverHeight +wallThick)/2,(psuDepth )/2 ])
        rotate ([90,0,0])
            minkowski()
            {
                cube ([cableOutWidth - 2* wallThick  , 2 *(cableOutDepth - wallThick),  2* wallThick ], center = true);   
                cylinder (r=wallThick, h =2*wallThick);
            }
            
    // Ventilation lines
    difference(){
        translate ([0,-(coverHeight +wallThick)/2+ 1.5*ventilationHeight,-(psuDepth )/2 ])
            VentilationHoles (ventilationFrontLength);
        if (connIsAtFront)
                
            translate([-connXPos,-connYPos,-(psuDepth ) /2])
                if (connScrewHoleRotation == 0)
                    cube ([connWidth + 4 *wallThick, connScrewCenterDst + 4 * wallThick, 3 *wallThick], center = true);    
                else
                    cube ([connScrewCenterDst + 4 *wallThick, connHeight + 4 * wallThick, 3 *wallThick], center = true);    
    }
    
    if (connIsAtFront)
        translate ([-(psuWidth+wallThick)/2,-(coverHeight +wallThick)/2+ 1.5*ventilationHeight,0])
            rotate ([0,90,0])
                  VentilationHoles (ventilationSideLength);
   
    translate ([(psuWidth+wallThick)/2,-(coverHeight +wallThick)/2+ 1.5*ventilationHeight,0])
        rotate ([0,90,0])
              VentilationHoles (ventilationSideLength);

    // screHoles
    translate ([0,coverHeight/2- screwY, psuDepth/2 - screwX ])
    {
        rotate ([0,90,0])
            cylinder (d=screwDiameter, h = 2* psuWidth, center = true );
        translate ([0,0,-screwInterCenter])
            rotate ([0,90,0])
                    cylinder (d=screwDiameter, h = 2* psuWidth, center = true );
    }
}

// connector hole to make difference in the wall to be placed
module ConnectorHole()
{
    translate([-connXPos,-connYPos,0])
    {
        cube ([connWidth, connHeight, 2 *wallThick], center = true);
        if (connHasScrewHoles)
        {
            rotate ([0,0,connScrewHoleRotation])
            {
                translate ([0,connScrewCenterDst/2,0])
                    cylinder (d= connScrewDiam, h= 2* wallThick, center = true);
                translate ([0,-connScrewCenterDst/2,0])
                    cylinder (d= connScrewDiam, h= 2* wallThick, center = true);
            }
        }
    }
}

module VentilationHoles (length)
{
    if (nVentilationLines>0)
        for (a =[0:nVentilationLines-1])
            translate ([0, a*2*ventilationHeight,0])
                minkowski ()
                {
                    cube ([length,0.01,0.01], center = true);
                   cylinder (r=ventilationHeight/2, h =2*wallThick, center = true);     
                }
}
