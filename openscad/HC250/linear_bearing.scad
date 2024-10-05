use <../lib.scad>

//cli=0.50;  // internal cleareance PLA
//clo=0.0;  // external cleareance PLA
cli=0.1;  // internal cleareance PETG
clo=0.0;  // external cleareance PETG

/*
- Modelo: LM8LUU;
- Diâmetro interno: 8mm;
- Diâmetro externo: 15mm;
- Comprimento: 45mm.
*/

// outer diameter in mm
outerD=15;
thick=2.4;
// inner diameter in mm
innerD=8;

// height in mm
Height=40; //45;   // 45 y40 e x74
base_height=0;//0.3;//1.5;
base_width=outerD+10;

/******************************************/
D=outerD-thick*2;
gap=0;

// number of spikes
N = 8;

// twist of blades in deg
blade_twist = 45;

//resolution
$fn  = 200;
/******************************************/
// Axis
//%cylinder(d=innerD, h= H);

//bushing(20);
bearing(Height);



module spike() {
    w=2.3;
    //translate ([innerD/2+cli/2+w/2, 0,0])
    translate ([innerD/2+cli/2, 0,0])
    {
       // circle(d=w);
        translate([0,-w/2,0])
        square([(D-innerD),w]);
    }
}
   
module bearing(H){
    difference()
    {
        union(){
            /* body */
            translate([0,0,base_height])
            difference(){ 
                hull(){
                    cylinder(d=outerD-clo, h=H-.1);
                    translate([innerD/2,-outerD/2,0])
                    rcube(5.5,outerD,H-.1, 2.5);
                }
                
                translate([0,0,-.01])        
                bushing(H);
            }
            
            /* base */
            difference(){
                cylinder(d=base_width, h=base_height);

                translate([0,0,-.1])
                cylinder(d=(outerD-thick*2), h=base_height*2);
            }
        }
        
        /* Axis */
        translate([0,0,-.1])
        cylinder(d=innerD+cli, h= H+base_height);
    }
}

module bushing(height) {
    H=height;
    translate([0,0,H/2]){
    /* base */
    translate([0,0,-H/2])
    cylinder (d1 = (D+innerD)/2+cli, d2 = innerD+cli, h = .6, center = false); 
    /* top */
    translate([0,0,H/2-.3])
    cylinder (d1 = innerD+cli, d2 = D, h = 1, center = false); 
    
    if(gap && H>15){            
        /* middle */
        hull(){
            translate([0,0,-H/6-((D-innerD)/2)])
            cylinder (d1 = innerD+cli, d2 = D, h = (D-innerD)/2, center = false); 
            translate([0,0,H/6])
            cylinder (d1 = D, d2 = innerD+cli, h = (D-innerD)/2, center = false); 
        }
        /* lower */
        translate([0,0,-H/6])
        linear_extrude(height = 2*H/3, center = true, convexity = 10, twist = blade_twist, slices = 100)
        difference() {
            circle (d = D);
             
            for ( i = [0 : 360/N : 360] ) {
               rotate ([0,0,i]) spike();
            }
        }
        /* upper */
        ang=5;
        translate([0,0,H/6])
        linear_extrude(height = 2*H/3, center = true, convexity = 10, twist = blade_twist, slices = 100)
        difference() {
            circle (d = D);
             
            for ( i = [0 : 360/N : 360] ) {
               rotate ([0,0,i+ang]) spike();
            }
        }   
        /**************/
    }else{
        linear_extrude(height = H, center = true, convexity = 10, twist = blade_twist, slices = 100)
        difference() {
            circle (d = D);
             
            for ( i = [0 : 360/N : 360] ) {
               rotate ([0,0,i]) spike();
            }
        }
    }  
    }  
} 
