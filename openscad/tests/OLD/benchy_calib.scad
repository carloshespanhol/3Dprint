difference()
{
    translate([0,0,-16])
    import("/home/hespanhol/OneDrive/openscad/calibration/3DBenchy.stl");
    
    translate([-50,-50,-50])
    cube([100,100,50]);
}
