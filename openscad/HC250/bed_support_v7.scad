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

/**/
hotbed_support();
/**
translate([55,0,0])
mirror([1,0,0]) hotbed_support();
/**/
*front_support();

/*
mirror([1,0,0])
hotbed_extension();

translate([-80,0,0])
hotbed_extension();
/**/

module hotbed_support(){
    c=5.5;
    
    difference(){
        union(){
            cube([t,40,20]);
        }
        //--------------------------------------
        translate([-1,7.5,10]) rotate([0,0,90])
        vcylinder(h=30, d=m5);  // 5mm bolt 
        
        translate([-1,32.5,10]) rotate([0,0,90])
        vcylinder(h=30, d=m5);  // 5mm bolt    
    }
    
    translate([t,14,10-c/2]) 
    cube([4,12,c]);

    // support
    translate([t+.5,14,.2]) 
    support(3.5,12,10-c/2-.4,0.4);    
    

    difference(){
        union(){
            translate([-19,13,0]) rcube(22,15,12,2);           
            hull(){
                translate([-19,13,0]) rcube(22,15,5,2);           
                translate([0,0,0]) cube([4,28,5]);
            }
        }   
        
        // Screw hole
        //translate([-22.5,8,-5]) oblong(6.5,m3,20);
        translate([-10,6+15,15]) Mscrew(30);
    }
}

module front_support(){
    difference(){
        union(){
            translate([-31, 0, 0])
            rotate_z(15,[-12, -12, 0])
            b90();
            translate([-31, 0, 0])
            rotate_z(15,[-1, -10.55, 0])
            cube([t,10,25]);
            
            mirror([1,0,0]){
                translate([-31, 0, 0])
                rotate_z(15,[-12, -12, 0])
                b90();        
                translate([-31, 0, 0])
                rotate_z(15,[-1, -10.55, 0])
                cube([t,10,25]);
            }
            
            hull(){
                translate([-34, 2, 0])
                scube(68,10,4.5);
                translate([-17, 20, 0])
                scube(34,10,4.5);
            }
            
            //
            translate([-7.5, 2, 0])
            scube(15,28,15);    

            // Front
            //color("orange")
            difference(){
                translate([-33.9, 1.6, 0])
                rcube(67.8,t,25,5);
                
                translate([-35, 2, -.1])
                scube(70,15,26);
            }   
        }
        
        // Hole
        translate([0, 8,-10])
        cylinder(d=3, h=50);
    }

/*#    translate([0, 8, 8])
    cylinder(d=10, h=5);
/**/
}

module b90(holes=1){
    difference(){
        union(){
            cube([24.5,30,25]);
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

    // support
    translate([t+1,18,t+.2]) 
    support(3.5,12,12.2-t-.4,0.4);
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

