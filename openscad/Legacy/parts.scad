include <config.scad>
use <../lib.scad>
$fn=200;

/*
    Diameters
    belt            1.5 / 0.8    
    pulley          11.90
    pulley w/ belt  13.25
    
    idler           12
    idler w/ belt   14.5
    
    idler w/ teeth  12
    idler w/ t & b  13.5
*/
//idler_pulley("top", "flat");

module belts(dy){               
    /* X Belt Left *
    color("black")
    translate([23,0,1.25])
    union(){
        translate([15,-1.5,belt_distance/2])
        cube([100,1.5,6]);
        
        translate([0,-1.5,-belt_size-belt_distance/2])
        cube([100,1.5,6]);
    }
    
    /* Y Belt */
    color("black")
    translate([20,0,0])
    rotate([0,0,90])
    union(){
        translate([-dy-2,-5,belt_distance/2 ])
        cube([dy*2+57.6,2,6]);        

        translate([-dy-2,-16.5,belt_distance/2 ])
        cube([dy+2.6,2,6]);        

        translate([-0.6,-16.5,-belt_size-belt_distance/2 ])
        cube([dy+11.4,2,6]);        
        
        /* Stepper belt */
        translate([dy+2.6,-16.5,belt_distance/2 ])
        cube([53,2,6]);        
    }

    /* Back Belt *
    color("black")
    translate([-37,158,d+height/2])
    union(){
        translate([0,0,belt_size/2+1.75])
        cube([120,3,6],center=true);
        translate([0,0,-belt_size/2-1.75])
        cube([120,3,6],center=true);
    }
    /**/
}


module idler_pulley(pos="both",type="flat"){
    /* GT2 */
    {
        if(pos == "both" || pos == "top"){
            translate([0,0,.5]) 
            gt2_idler(type);
        }
        if(pos == "both" || pos == "bottom"){
            mirror([0,0,1]){
                translate([0,0,.5]) 
                gt2_idler(type);
            }
        }
    }    
}

module gt2_idler(type="flat"){ 
    // 12 x 3 x 6.5mm
    /*
    if(type=="flat"){
        translate([-14.5/2-.2, -5, 0]) 
        #scube(.2, 10, 8);
    }
    else if(type=="teeth"){
        translate([-13.5/2-.2, -5, 0]) 
        #scube(.2, 10, 8);
    }
    /**/
    if(type=="flat"){
        %translate([0,0,1.25])
        cylinder(h=6,d=14.5);
    }
    else if(type=="teeth"){
        %translate([0,0,1.25])
        cylinder(h=6,d=13.5);
    }
    /**/
    color("silver") 
    difference(){
        union(){
            cylinder(h=1,d=18);
            cylinder(h=8,d=12);
            translate([0,0,6.5+1])
            cylinder(h=1,d=18);
        }
        
        /*---------------------*/
        translate([0,0,-2])
        cylinder(d=3,h=15);
        // bearing
        difference(){
            translate([0,0,8.2])
            cylinder(d=6,h=2);
            
            translate([0,0,8])
            cylinder(d=4,h=2);
        }
        difference(){
            translate([0,0,-1])
            cylinder(d=6,h=1.3);
            
            translate([0,0,-1])
            cylinder(d=4,h=2);
        }
    }
}        

module stepper(){
    union(){
        color("white")
        translate([0,-0, 18.5]) 
        rotate([0,90,0])
        import("stl/GT2_Pulley_5mm.stl");

        %translate([0,0,4.5])
        cylinder(h=6,d=13.25);

        color("silver")
        translate([4.4,1,-10]) 
        rotate([0,0,-90])
        import("stl/Nema17_Stepper.stl");
    }
}

module motor_support(){
    t=13;
    nw=nema17_width;
    b=false;

    /* Sacrifice Bridge */
    translate([-nw/2,-nw/2,7.5-.32])
    rcube(nw,nw/3,.32,7);
    translate([-nw/2,-nw/2+nw/3*2,7.5-.32])
    rcube(nw,nw/3,.32,7);

    translate([-nw/2,-nw/2,7.5])
    rcube(nw/3,nw,.32,7);
    translate([-nw/2+nw/3*2,-nw/2,7.5])
    rcube(nw/3,nw,.32,7);
    /**/
    difference(){
        union(){
            translate([-nw/2,-nw/2,7.5])
            rcube(nw,nw,t,6);
            // reinforce
            hull(){
                translate([-nw/2,-6,7.5+t])
                rcube(nw,12,.1,1);
                translate([-4.8,-6,7.5+t+10])
                rcube(12,12,.1,1);
            }
            /* mounting poles */
            for (a = nema17_hole_offsets) {
                translate(a)
                {
                    cylinder(d = 11, h = 15);
                    
                    hull(){
                        translate([0,0, 8])
                        cylinder(d = 11, h = 1);
                        
                        translate([-a[0]/8, -a[1]/8, 13])
                        cylinder(d = 15, h = 1);
                    }

                    /* Washers */
                    difference(){
                        %color("grey"){
                            cylinder(d = 14, h = 3);
                            translate([0,0,14.5])  
                            cylinder(d = 14, h = 3);
                        }
                        
                        translate([0,0,-.1])
                        cylinder(d=4, h=20);
                    }
                    /**/
                }
            }    
            
            /* Frame fixing */
            translate([7.2,-43.5, 7.5])
            rotate([0,0,90])
            vrcube(64.65,12,44.5);
            hull(){
                translate([7.2-12,-43.5, 8])
                scube(12, 32, .1);

                translate([7.2-12,-43.5, -5])
                scube(12, 20, .1);
            }
        }
        
        /*****************/
        /* Washers holes */
        translate([0,0,25.5-11])
        for (a = nema17_hole_offsets) {
            translate(a)
            {
                cylinder(d = 16, h = 20);
            }
        }    

        translate([0,0,1])
        nema17_holes(5);

        translate([15,0,3])
        rccube(20,10,20);
        
        // M5 screws
        translate([2,10,42])
        rotate([0,90,0])
        Mscrew(10,5.5);

        translate([2,-33.5,42])
        rotate([0,90,0])
        Mscrew(10,5.5);
        translate([2,-33.5,8])
        rotate([0,90,0])
        Mscrew(10,5.5);
        
        // Cut base
        s=100;
        translate([-s/2,-s/2,-12])
        scube(s,s,10);
        
    }
}

module axis_x(s){  
    d=20;
    translate([15,0,0]){
        // Front
        color("silver") 
        translate([0,-d,-d]) 
        rotate([0, 90, 0]) 
        cylinder(s,4,4);
        // Back
        color("silver") 
        translate([0, d, d]) 
        rotate([0, 90, 0]) 
        cylinder(s,4,4);
    }
    
    /* X Bushing *
    color("white") 
    translate([75,-27.5,0]) 
    rotate([0, 90, 0]) 
    cylinder(d=d, h=car_width+4);
    
    color("white") 
    translate([75,27.5-15, axis_distance/2]) 
    rotate([0, 90, 0]) 
    cylinder(d=d, h=car_width+4);
    /**/    
}


// nema 17 dimensions
nema17_width = 42.3;
nema17_hole_offsets = [
	[-15.5,  15.5, -5],
	[-15.5, -15.5, -5],
	[ 15.5, -15.5, -5],
	[ 15.5,  15.5, -5]
];
Tnut_holes_offsets =[
	[-5.65, -5.65, -5],
	[-5.65,  5.65, -5],
	[ 5.65, -5.65, -5],
	[ 5.65,  5.65, -5]
];

// Parts
module nema17_holes(sd=m3){
    // center hole
    cylinder(d = 22.5, h = 40, center = true);

    /* mounting holes */
    for (a = nema17_hole_offsets) {
        translate(a)
        {
            cylinder(d = sd, h = 50, center = true);
        }
	}    
}

module sg90(){
    rotate([0,90,180])
    import("/home/hespanhol/OneDrive/openscad/HC235/stl/MicroSG90 Servo Motor.stl");
}    
module belt_clamp(){
    w=6;
    h=6;
    i=2.2;
    t=1;
    difference(){
        union(){
            scube(i+t*2, w+t*2, h);           
        }
        
        translate([t,t,-.1])
        scube(i, w, h+1);
        
        translate([t,t,h-t])
        hull(){
            translate([-t/2,-t/2,t])
            scube(i+t, w+t, .1);
            
            scube(i, w, .1);
        }
//        linear_array( count=30, distance=1.76)  cube([stripes,height+border,1]);
        
    }
}
module linear_array( count, distance ) {
    for ( i= [1:1:count])  {
        translate([distance*i,0,0,]) 
        children();
    }
}
module 608zz(){  
    // 22 x 8 x 7mm plus 1mm cover
    difference(){
        union(){
            cylinder(d=22, h=7);
        }
        translate([0,0,-.1])
        cylinder(d=8, h=8);
    }
}        
module mk7_gear(){
    // 12 x 5 x 13mm plus 1mm cover
    difference(){
        union(){
            cylinder(d=12, h=13);
        }
        translate([0,0,-.1])
        cylinder(d=5, h=14);
    }
}    

module axis_y(dy=160){    
    translate([20+axis_diam/2,-dy-20,25]) 
    union(){
        /* Y Axis */
        color("silver") 
        rotate([0, 90, 90]) 
        cylinder(d=axis_diam, h=dy*2+40);
        
        /* Y Bushing *
        color("white") 
        translate([0,-ybush_len/2,0]) 
        rotate([0, 90, 90]) 
        cylinder(d=bush_width, h=ybush_len);
        /**/
    }
}

module joiner_pulley(){
    /* Idler */
    color("silver") 
    translate([30,-7,.5]) 
    gt2_idler();
    
    color("silver") 
    translate([20,8,-9.5]) 
    gt2_idler();    
}    

ud = upper_distance;
module framey(dy=50){
    h=100;
    color("silver") 
    translate([0,dy,-h+ud]) 
    cube([20,20,h+20]);
    
    color("silver") 
    translate([0,-dy-20,-h+ud]) 
    cube([20,20,h+20]);
    
    color("white") 
    translate([0,-dy,ud]) 
    cube([20,dy*2,20]);
    
}
module framex(dy=50){
    color("white") 
    translate([20,-dy-20,ud]) 
    cube([100,20,20]);
    
    color("white") 
    translate([20,dy,ud]) 
    cube([100,20,20]);
}




module nema17_leadscrew(){
    translate([30,20,5]) 
    union(){
        color("silver")
        translate([-30,-20,-5]) 
        cylinder(d=8, h=200);
        
        color("silver")
        translate([-31,-16.5,-15]) 
        import("stl/Nema17_Stepper.stl");
    }
}

module blower(){
    color("dimgray")
    rotate([0,58,-90])
    import("stl/50_mm_blower_fan_placeholder.stl");
}

module endstop(){
    color("green")     
    rotate([0,90,90])
    import("stl/microswitch.stl");
}


module e3d(detaillevel=1, socket_width=0) {
    // 11.5 x 16 x 23
    sw=socket_width;
    
    translate([0,0,hotend_height+.6])
    rotate([180,0,180]){
        color("grey")
        translate([0,0,hotend_height-65]){
               // Heat Cartridge
                translate([-8.5,8,55.6]) rotate([0,90,0]) fncylinder(r=3.05, h=20);
               // thermistor
                translate([-8.5,-5,55.6]) rotate([0,90,0]) fncylinder(r=3/2, h=20);
        }

      
	difference() {
		union() {
            color("silver"){
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,6]) fncylinder(r=6,h=8);
			translate([0,0,13]) fncylinder(r=8,h=8);
			translate([0,0,20]) fncylinder(r=11.15,h=26);
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,45]) fncylinder(r=2,h=12);
            }
            
            translate([0,0,hotend_height-65]){
            
            if(sw>0){ 
                color("cyan") 
                translate([-8-sw,-8-sw,49.5-sw]) 
                chamfercube([16+sw*2,23+sw*2,10.5+sw*2],side=[0.4,0.4,0.4,0.4],top=[0.4,0.4,0.4,0.4],bottom=[0.4,0.4,0.4,0.4]);
            }else{
                translate([-8-sw,-8-sw,48.7-sw]) 
                chamfercube([16+sw*2,23+sw*2,11.5+sw*2],side=[0.4,0.4,0.4,0.4],top=[0.4,0.4,0.4,0.4],bottom=[0.4,0.4,0.4,0.4]);
            }
            
            }
            
            color("silver")
            translate([0,0,hotend_height-65]){
                translate([0,0,58.6]) fncylinder(r=2.5,h=3);
                translate([0,0,60.6]) fncylinder(r=4.03,h=3,fn=6);
                translate([0,0,62.6]) fncylinder(r=3,r2=0.5,h=3);
            }
            
            }
            
		
        color("silver"){
		if(detaillevel==1) {
			translate([0,0,62.1]) fncylinder(r=0.25,h=4,fn=10);
			translate([0,0,16]) fnpipe(r=9,r2=4.475,h=1.5); 
			translate([0,0,18.5]) fnpipe(r=9,r2=4.475,h=1.5); 
			for ( i = [0 : 9] ) {
				translate([0,0,21+i*2.5]) fnpipe(r=12.15,r2=4.475+i*0.15,h=1.5); 
			}
            translate([0,0,hotend_height-65]){
			    translate([0,0,-1]) fncylinder(r=1.6,h=64.1);
               // Heat Cartridge
                translate([-9,8,55.6]) rotate([0,90,0]) fncylinder(r=3.05, h=18);
               // thermistor
                translate([-9,-5,55.6]) rotate([0,90,0]) fncylinder(r=3/2, h=18);

                translate([-9,8,54.6]) cube([18,8.5,2]);
                translate([0,13,47.1]) fncylinder(r=1.4, h=13.5);
            }
		}
        }
	}
}
}

module e3d_volcano() {
	difference() {
		union() {
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,6]) fncylinder(r=6,h=8);
			translate([0,0,13]) fncylinder(r=8,h=8);
			translate([0,0,20]) fncylinder(r=11.15,h=26);
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,45]) fncylinder(r=2,h=12);
            
            translate([0,0,hotend_height-65]){
                
                translate([-9,-4.5,42])  chamfercube([18,20,19]);

                translate([-8,-4.5,48.1]) chamfercube([16,20,11.5],side=[0.4,0.4,0.4,0.4],top=[0.4,0.4,0.4,0.4],bottom=[0.4,0.4,0.4,0.4]);
                
                translate([0,0,58.6]) fncylinder(r=2.5,h=3);
                translate([0,0,60.6]) fncylinder(r=4.03,h=3,fn=6);
                translate([0,0,62.6]) fncylinder(r=3,r2=0.5,h=3);
            }
		}
		if(detaillevel==1) {
			translate([0,0,62.1]) fncylinder(r=0.25,h=4,fn=10);
			translate([0,0,16]) fnpipe(r=9,r2=4.475,h=1.5); 
			translate([0,0,18.5]) fnpipe(r=9,r2=4.475,h=1.5); 
			for ( i = [0 : 9] ) {
				translate([0,0,21+i*2.5]) fnpipe(r=12.15,r2=4.475+i*0.15,h=1.5); 
			}
            translate([0,0,hotend_height-65]){
			    translate([0,0,-1]) fncylinder(r=1.6,h=64.1);
                translate([-9,8,55.6]) rotate([0,90,0]) fncylinder(r=3.05, h=18);
                translate([-9,8,54.6]) cube([18,8.5,2]);
                translate([0,13,47.1]) fncylinder(r=1.4, h=13.5);
                translate([4.45,-1,54.8]) rotate([0,90,0]) fncylinder(r=1.4, h=4.45);
                translate([3.45,-2.5,57.6]) rotate([0,90,0]) fncylinder(r=1.15, h=5.45);
            }
		}
	}
}

// ######################################################################################################################
module chamfercube(xyz=[0,0,0],side=[0,0,0,0],top=[0,0,0,0],bottom=[0,0,0,0],x=false,y=false,z=false) {
	translate([x==true?-xyz[0]/2:0,y==true?-xyz[1]/2:0,z==true?-xyz[2]/2:0]) difference() {
		cube(xyz);
		if(side[0]>=0) translate([0,0,xyz[2]/2]) rotate([0,0,45]) cube([side[0]*2,side[0]*3,xyz[2]+2],center=true);
		if(side[1]>=0) translate([xyz[0],0,xyz[2]/2]) rotate([0,0,-45]) cube([side[1]*2,side[1]*3,xyz[2]+2],center=true);
		if(side[2]>=0) translate([xyz[0],xyz[1],xyz[2]/2]) rotate([0,0,45]) cube([side[2]*2,side[2]*3,xyz[2]+2],center=true);
		if(side[3]>=0) translate([0,xyz[1],xyz[2]/2]) rotate([0,0,-45]) cube([side[3]*2,side[3]*3,xyz[2]+2],center=true);
		if(top[0]>=0) translate([xyz[0]/2,0,xyz[2]]) rotate([-45,0,0]) cube([xyz[0]+2,top[0]*2,top[0]*3,],center=true);
		if(top[2]>=0) translate([xyz[0]/2,xyz[1],xyz[2]]) rotate([45,0,0]) cube([xyz[0]+2,top[2]*2,top[2]*3,],center=true);
		if(top[3]>=0) translate([0,xyz[1]/2,xyz[2]]) rotate([0,45,0]) cube([top[3]*2,xyz[1]+2,top[3]*3,],center=true);
		if(top[1]>=0) translate([xyz[0],xyz[1]/2,xyz[2]]) rotate([0,-45,0]) cube([top[1]*2,xyz[1]+2,top[1]*3,],center=true);
		if(bottom[0]>=0) translate([xyz[0]/2,0,0]) rotate([45,0,0]) cube([xyz[0]+2,bottom[0]*2,bottom[0]*3,],center=true);
		if(bottom[2]>=0) translate([xyz[0]/2,xyz[1],0]) rotate([-45,0,0]) cube([xyz[0]+2,bottom[2]*2,bottom[2]*3,],center=true);
		if(bottom[3]>=0) translate([0,xyz[1]/2,0]) rotate([0,-45,0]) cube([bottom[3]*2,xyz[1]+2,bottom[3]*3,],center=true);
		if(bottom[1]>=0) translate([xyz[0],xyz[1]/2,0]) rotate([0,45,0]) cube([bottom[1]*2,xyz[1]+2,bottom[1]*3,],center=true);
	}	
}

// ######################################################################################################################
fnresolution = 0.4;
detaillevel = 1; 

module fnpipe(r,r2,h,fn){
	if (fn==undef) {
		difference() {
			fncylinder(r=r,h=h,$fn=2*r*3.14/fnresolution);
			translate([0,0,-1]) fncylinder(r=r2,h=h+2,$fn=2*r*3.14/fnresolution);
		}
	} else {
		difference() {
			fncylinder(r=r,h=h,fn=fn);
			translate([0,0,-1]) fncylinder(r=r2,h=h+2,fn=fn);
		}
	}
}

// ######################################################################################################################
module fncylinder(r,r2,h,fn){
	if (fn==undef) {
		if (r2==undef) {
			cylinder(r=r,h=h,$fn=2*r*3.14/fnresolution);
		} else {
			cylinder(r1=r,r2=r2,h=h,$fn=2*r*3.14/fnresolution);
		}
	} else {
		if (r2==undef) {
			cylinder(r=r,h=h,$fn=fn);
		} else {
			cylinder(r=r,r2=r2,h=h,$fn=fn);
		}
	}
}
