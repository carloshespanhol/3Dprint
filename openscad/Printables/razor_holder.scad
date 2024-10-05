use <../lib.scad>

$fn=200;
fit=0.2;
t=3;
x=116;
y=38;
z=10+t;


 d=61;
difference(){
    union(){
        translate([0.5,-5,1.85])
        import("/home/hespanhol/3D Print/stl_files/RAZOR_HOLDER.stl");
        
       
        translate([d/2,11,0])
        cylinder(d=d, h=5.01);
    }
    //----------------------------
    translate([0,-d/2,-.1])
    cube([d,d/2,10]);
    
}    


module mini(){
    difference(){
        union(){
            rcube(x,y,z, 10);

            translate([0,-4,0])
            rcube(x-20,y+4,z, 10);

            translate([0,-4,2])
            rcube(x,y+4,z-2, 10);
        }
        //------------------
        // board
        translate([(x-45)/2, -1, -.1])
        rcube(45,36,10,1);
        
        // cut
        translate([(x-30), 4, -.1])
        rcube(20,36-10,10,3);
        translate([10, 4, -.1])
        rcube(20,36-10,10,3);
        
        // battery
        translate([(x-65)/2, y/2-2+4, -8])
        rotate([0,90,0])
        cylinder(d=19 , h=65);
        
        miniScrewFix();
        
        // conector
        translate([(x-45)/2+7, -5, z-t-5-3])
        cube([20,10,5]);
        
    }
}    
module miniScrewFix(){
    dx=104;
    dy1=28;
    dy2=22;
    px=(x-dx)/2;
    py=(y-dy1)/2;
    pz=3;
    
    translate([px, py-2, pz]){
        Mscrew(d=2,b=1);
        
        translate([0, dy1, 0])
        Mscrew(d=2,b=1);
        
        
        translate([dx, dy1-dy2, 0])
        Mscrew(d=2,b=1);
        translate([dx, dy1, 0])
        Mscrew(d=2,b=1);
    }
}    