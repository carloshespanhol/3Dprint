cli=-0.15;   // internal cleareance
clo=0.2;    // external cleareance

// outer diameter in mm
outerD=13;
thick=1;
// inner diameter in mm
innerD=8;

// height in mm
Height=76;   //  y40 e x76
base_height=1.5;
base_width=outerD+4;

/******************************************/
D=outerD-thick*2;
H=Height+10;  

// number of spikes
N = 8;

// twist of blades in deg
blade_twist = 45;

//resolution
$fn  = 200;
/******************************************/
//bushing();

bearing();

   
module bearing(){
    //translate([-outerD/2-1, 0, 0])
    {
        /* body */
        translate([0,0,base_height])
        difference(){          
            cylinder(d=outerD-clo, h=H-.1);
            
            translate([0,0,H/2-.01])        
            bushing();
        }
        
        /* base */
        difference(){
            cylinder(d=base_width, h=base_height);

            translate([0,0,-.1])
            cylinder(d=(outerD+innerD)/2, h=base_height*2);
        }
        /**/
    }
}

module bushing() {
    /* base */
    translate([0,0,-H/2])
    cylinder (d1 = D, d2 = innerD+cli, h = (D-innerD)/2, center = false); 
    /* top */
    translate([0,0,H/2-((D-innerD)/2)])
    cylinder (d1 = innerD+cli, d2 = D, h = (D-innerD)/2, center = false); 
    
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
    /**/
} 
module spike() {
    w=1;
    translate ([innerD/2+cli/2+w/2, 0,0])
    {
        circle(d=w);
        translate([0,-w/2,0])
        square([(D-innerD)/2,w]);
    }
}
