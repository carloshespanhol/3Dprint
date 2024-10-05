use <../lib.scad>
$fn=100;

cgd=8;
cgh=4;
cgt=1;
h=10;
t=4.5;    //thick
cl=.5;

m3=3.3;
m5=5.4;
e=0.01;

dist=200;

//translate([-11.5,31,20]) rotate([180,0,0]) nut_knob();

//hotbed_support();

front_support();

/*
translate([55,0,0])
mirror([1,0,0]) hotbed_support();

/*
mirror([1,0,0])
hotbed_extension();

translate([-80,0,0])
hotbed_extension();
/**/

module front_support(){
    translate([-31, 0, 0])
    rotate_z(15,[-12, -12, 0])
    b90();
    mirror([1,0,0])
    translate([-31, 0, 0])
    rotate_z(15,[-12, -12, 0])
    b90();
    
    hull(){
        translate([-34, 3, 0])
        scube(68,10,4.5);
        translate([-17, 20, 0])
        scube(34,10,4.5);
    }
    translate([-7.5, 3, 0])
    scube(15,27,10);    
}

module b90(holes=1){
    difference(){
        union(){
            cube([25,30,25]);
        }
        
        //extrusion
        translate([t,-0.1,t]) cube([30,100,30]);  
     
        if(holes == 1){
            translate([-1,10,15]) rotate([0,0,90])
            vcylinder(h=30, d=m5);  // 5mm bolt  
                        
            translate([15,20,-1]) 
            cylinder(h=30, d=m5);  // 5mm bolt     
            translate([15-m5/2,20,-0.01]) 
            scube(m5,12,50);    
        }
    }
    
    translate([t,18,12.2]) 
    cube([4,12,5.5]);
}

module hotbed_support(){
    translate([0,-15,0]) b90();
    
    difference(){
        union(){
            hull(){
                translate([-25,4,0]) rcube(28,11,10,2);           
                translate([0,-15,0]) cube([4,30,10]);
            }
        }   
        
        // Screw hole
        //translate([-22.5,8,-5]) oblong(6.5,m3,20);
        translate([-19.5,9.75,15]) Mscrew(30);
    }
}

module hotbed_extension(){
    
    difference(){
        union(){
            translate([0,-9,0]) rcube(37,37,5+2.8+3,2);           
            hull(){
                translate([-8,-3.5,0]) rcube(21,11,5+2.8,2);
                translate([0,-9,0]) rcube(t,25,5+2.8,2);
            }
        }    
        // rebaixo
        translate([t,-12-t,5]) rcube(40,40,5,5);           
        
        // cut
        translate([-3,-7-t,5+2.8]) rcube(43,40,5,1);           
        
        // Screw hole
        translate([-2, 6.5-t, 4])   Mscrew();
        
        translate([21+t,6.5-t,-8]) Mnut();
    }
}

