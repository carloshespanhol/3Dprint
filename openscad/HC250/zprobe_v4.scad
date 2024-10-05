use <../lib.scad>
$fn=200;

sih=3.6;
siw=9;
st=3;

h=60;
w=siw+st*2;
y=6;

sh=st*3+sih;
sl=15;
c=4;    // chamfer
swh=20.5;
print=0;
pos=2;

cl=0.5;

if(print){
    translate([-5,-55,w]) rotate([-90,0,0])  zprobe_support();
    
    rotate([90,0,0]) switch_support();
}else{
    zprobe_support();
    
    color("cyan") 
    if(pos==2){
        translate([37,-13.5,30.5+cl])
        rotate([0,-90,0])
        switch_support();
    }else{
        switch_support();
    }
}    

     
       
module zprobe_support(){
    translate([0,0,34]){        
        translate([0,w-1.5,0])        
        scube(y/2+c, 1.5, y/2+c-.5);

        hull(){
            translate([y/2+c-cl,0,0])
            scube(cl, w, y/2+c-cl);
            
            translate([y/2+cl,0,0])
            scube(.1, w, y/2);

        }
        translate([y/2,0,0])
        scube(1, w, y/2);
    }
    
    // pos 2
    color("red")
    translate([38,-13.5,31])
    rotate([0,-90,0])
    translate([0,0,35]){        
        hull(){
            translate([y/2+c-cl,0,0])
            scube(cl, w, y/2+c-cl);
            
            translate([y/2+cl,0,0])
            scube(.1, w, y/2);
        }
        translate([y/2,0,0])
        scube(1, w, y/2);
    }

    difference(){
        union(){
            translate([y/2,0,34])
            rotate([0,0,90])
            vrcube(w,y,18,.01,0);

            translate([-y/2,0,h-sh])
            vrcube(w+3,sl,sh-3,3,0);            
        }
        
        translate([(w-siw)/2, 5,h-st-sih])
        scube(siw,sl,h);
        
        // Screw
        translate([w/2, sl-4, h-23])
        Mnut(false);        
    }    
}

module switch_support(){
    
    translate([0,0,34+cl/2]){        
        hull(){
            translate([y/2+cl/2,0,y/2+cl/2])
            scube(cl/2, w-1.5, c-.5);
            
            translate([y/2+c-cl-cl/2,0, y/2+c-cl])
            scube(.1, w-1.5, cl/2);

        }
        translate([y/2+cl/2,0,y/2+c-cl])
        scube(y+c, w-1.5, c-cl);

        translate([-y/2+1,0,-5])
        scube(y+c+7, w-1.5, 5-cl);

        translate([y/2+c+cl/2,0,-5])
        scube(8.75, w-1.5, 15);
    }
    
    /**/
    %translate([11, 46, 27.5])
    rotate([0,180,0])
    rotate([90,0,-90])
    import("stl/Endstop.stl");
    /**/    
    
    translate([11, 51, 12])
    rotate([180,-90,0])
    difference(){
        union(){
            
            translate([0,4,-1])
            rcube(21,47,y, 1.5);
        }

        translate([-.5,19.5,-1])
        union(){
            translate([3,3.5,-1])
            cylinder(h=10, d=3.5);

            translate([3,22.5,-1])
            cylinder(h=10, d=3.5);

            translate([8,5.5,1])
            cube([3,15,10]);
        }
        translate([2.5,15.5,0])
        cube([11,3,10]);
        
        translate([-0.5, 3, 2])
        cube([18,45,y]);
    }
}

