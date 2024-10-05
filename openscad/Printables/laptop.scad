$fn = 200;
// Diameter of bottom cyclinder (mm)
bottomDiameter = 30;
bottomRadius = bottomDiameter/2;
// Height of bottom cyclinder (mm)
bottomHeight = 22;

// Diameter of top cyclinder (mm)
topDiameter = 5;
// Height of top cyclinder (mm)
topHeight = 17;

// Space between two cyclinders (mm) 
clearance = 20;

// Tolerance of cutted piece from bottom cyclinder (mm)
tolerance = 0.5;
rubber =0.4;

correction = clearance - (bottomRadius + tolerance);
spaceX = correction >= 0 ? -tolerance : correction;
baseHeight = bottomHeight - topHeight;
base = [ [(clearance / 2) + bottomRadius, 0, bottomRadius], [-((clearance / 2) + topDiameter), 0, topDiameter] ];
topDiameterDifference = topDiameter + tolerance + rubber;
baseDifference = [ [-((clearance / 2) + topDiameterDifference), 0, bottomRadius], [(clearance / 2) + bottomRadius, 0, topDiameterDifference] ];

linear_extrude (height = baseHeight) rounded_polygon(base);

difference(){
    translate([(clearance / 2) + bottomRadius, 0, 0]) cylinder(bottomHeight + baseHeight, bottomRadius, bottomRadius);
    union(){
        translate([(clearance / 2) + bottomRadius + spaceX, 0, baseHeight]) 
        cylinder(topHeight + baseHeight, topDiameterDifference, topDiameterDifference);
        
        translate([spaceX, 0, topHeight + baseHeight]) linear_extrude (height = baseHeight + 0.01) rounded_polygon(baseDifference);
    }
}

translate([-((clearance / 2) + topDiameter), 0, 0]) cylinder(topHeight + baseHeight, topDiameter, topDiameter);

/* from http://forum.openscad.org/Script-to-replicate-hull-and-minkoswki-for-CSG-export-import-into-FreeCAD-td16537.html#a16556 */
/* Thanks to nophead */
module rounded_polygon(points)
    difference() {
        len = len(points);
        union() {
            for(i = [0 : len - 1])
                if(points[i][2] > 0)
                    translate([points[i].x, points[i].y])
                        circle(points[i][2]);

            polygon([for(i  = [0 : len - 1])
                        let(ends = tangent(points[i], points[(i + 1) % len]))
                            for(end = [0, 1])
                                ends[end]]);
        }
        for(i = [0 : len - 1])
            if(points[i][2] < 0)
                translate([points[i].x, points[i].y])
                    circle(-points[i][2]);
     }

function tangent(p1, p2) =
    let(
        r1 = p1[2],
        r2 = p2[2],
        dx = p2.x - p1.x,
        dy = p2.y - p1.y,
        d = sqrt(dx * dx + dy * dy),
        theta = atan2(dy, dx) + acos((r1 - r2) / d),
        xa = p1.x +(cos(theta) * r1),
        ya = p1.y +(sin(theta) * r1),
        xb = p2.x +(cos(theta) * r2),
        yb = p2.y +(sin(theta) * r2)
    )[ [xa, ya], [xb, yb] ];