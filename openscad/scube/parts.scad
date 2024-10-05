include <config.scad>
use <../lib.scad>
$fn=200;
//motor_support();
//stepper();
//idler();

module idler(){
    color("silver") 
    translate([21,4, 25.5]) {
        gt2_idler();
        translate([0,0,9.5]) 
        gt2_idler();        
    }

    translate([-st,ss-st,-ss+st])    
    mirror([0,1,0])
    difference(){
        union(){
            nccube(ss,ss,ss);
            
            translate([0,ss-st-t/2,ss])
            nccube(50,t/2+st,15);            

            translate([0,ss-t-st*2,ss])
            nccube(50,t/2+st,15);            
                        
        }
        // axis
        translate([t*2+st+3.5,ss+st,ss-1])
        ycylinder(8.5,40);
        // M3
        translate([t*2+st+3.5,ss-st/2-t,ss])
        zcylinder(3.5,20);
        translate([ss/2,ss+st,ss/2])
        ycylinder(3.5,40);
        translate([-st,ss/2,ss/2])
        xcylinder(3.5,40);
        
        translate([t+st*2,-t-st*2,-.1])
        nccube(ss,ss,ss+1);
        
        translate([st,-.1,-.1])
        nccube(t,ss-st,ss-st);
        translate([st,ss-st-t,-.1])
        nccube(ss,t,ss-st);        
    }
}    

motor_support();
module motor_support()
{
    translate([-st,-ss+st,-ss+st])
    difference(){
        union(){
            nccube(ss,ss,ss);
            
            translate([0,ss-st-t/2,ss+20]){
                translate([26,33.5,0])
                nema17_mount(st, false);
         //   nccube(50,41+t,st);
            }
            translate([0,ss-st-t/2,ss+25])
            rotate([-90,0,0])
            xrtriangle(50,st);
            
            translate([0,ss-t-st*2,ss])
            nccube(50,t+st*2,25);            
        }
        // axis
        translate([st*2,ss-st*2,ss+14])
        ycylinder(8.5,40);        
         // stepper
        //translate([st+21,ss+21,ss+15])        zcylinder(25,20);
        // frame
        translate([t+st*2,-t-st*2,-.1])
        nccube(ss,ss,ss+1);
        translate([st,-.1,-.1])
        nccube(t,ss-st,ss-st);
        translate([st,ss-st-t,-.1])
        nccube(ss,t,ss-st);        
        // M3
        translate([t+st+1,ss-t-st/2,ss+27])
        rotate([180,0,0])
        Mscrew(18);
       //zcylinder(3.5,28);
        // Slot
        translate([st*2,ss/2-2,ss+14])
        nccube(ss,t+st/2,3);        
        translate([st*2-axis/2,ss-t/2-st/2,ss+14])
        nccube(ss,1,20);        
        translate([st*2+t+st,ss/2-2,ss+14])
        nccube(ss/2,t+st/2,20);       
       // Nut
       translate([t+st+1,ss-t-st/2,ss+6])
       rotate([0,0,180])
      MnutPocket(); 
    }
}    
module stepper(){
    translate([21,21+st,15]) 
    rotate([0,0,180])
    union(){
        color("white")
        translate([0,0,17]) 
        rotate([0,-90,0])
        import("stl/GT2_Pulley_5mm.stl");

        color("silver")
        translate([-1,4.25,0]) 
        import("stl/Nema17_Stepper.stl");
    }
}
module frame(){
    color("white") {
        translate([-w/2,-l/2+t,0])
        nccube(t,l-t*2,h);
        translate([w/2-t,-l/2+t,0])
        nccube(t,l-t*2,h);

        translate([-w/2,l/2-t,0])
        nccube(w,t,h);
        //translate([-w/2,-l/2,0]) nccube(w,t,h);
    }
}
module bushing(){
    #cylinder(d=bush_width,h=bush_len);
    cylinder(d=bush_width+thick_min*2,h=bush_len);
}

module yaxis(){
    %translate([-w/2+st,l/2, h+bush_width/2+thick_min+17])
    {
        ycylinder(axis,l,false);  
        translate([0,-l/2+bush_len/2,0])
        rotate([90,0,0])
        bushing();
    }  
    %translate([w/2-t,l/2,h+bush_width/2+thick_min+12+st])
    {
        ycylinder(axis,l,false);    
        translate([0,-l/2+bush_len/2,0])
        rotate([90,0,0])
        bushing();
    }    
}
module xaxis(){
    translate([-w/2,axis_distance/2,h+bush_width+thick_min+1])
    {
        %xcylinder(axis,l,false);    
        translate([w/2-bush_len/2,0,0])
        rotate([0,90,0])
        bushing();
    }    
    translate([-w/2,-axis_distance/2,h+bush_width+thick_min+1])
    {
        %xcylinder(axis,l,false);    
        translate([w/2-bush_len/2,0,0])
        rotate([0,90,0])
        bushing();
    }    
}
/**************************/
module joiner_pulley(){
    /* Idler */
    color("silver") 
    translate([30,-7, 29.5]) 
    gt2_idler();
    
    color("silver") 
    translate([20,8,20]) 
    gt2_idler();    
}    
module idler_pulley(top_screw){
    /* GT2 */
    %color("silver") 
    translate([10,0,top_screw-26.5])
    {
        gt2_idler();
        translate([0,0,9.5]) 
        gt2_idler();
    }    
}

module belts(){           
    belt_size=6;
    /* X Belt Left */
    color("black")
    translate([-42,0,d+height/2])
    union(){
        translate([0,0,belt_size/2+1.5])
        cube([120,3,6],center=true);
        translate([-4,0,-belt_size/2-1.5])
        cube([120,3,6],center=true);
    }
    /* Back Belt */
    color("black")
    translate([-37,158,d+height/2])
    union(){
        translate([0,0,belt_size/2+1.75])
        cube([120,3,6],center=true);
        translate([0,0,-belt_size/2-1.75])
        cube([120,3,6],center=true);
    }
    /* Y Belt */
    color("black")
    translate([-93.5,0,d])
    rotate([0,0,90])
    union(){
        translate([65,5,height-4])
        rotate([0,0,-1])
        cube([210,3,6],center=true);

        translate([-20,-6,height-4])
        cube([37,3,6],center=true);

        translate([80,4,4])
        cube([170,3,6],center=true);        
    }
    /**/
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
    rotate([0,0,90])
    import("stl/50_mm_blower_fan_placeholder.stl");
}

module endstop(){
    color("green")
    translate([-3,-4,23.5]) 
    rotate([-90,-90,180])
    import("stl/microswitch.stl");
}


module e3d() {
	difference() {
		union() {
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,6]) fncylinder(r=6,h=8);
			translate([0,0,13]) fncylinder(r=8,h=8);
			translate([0,0,20]) fncylinder(r=11.15,h=26);
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,45]) fncylinder(r=2,h=12);
            translate([0,0,hotend_height-65]){
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
			cylinder(r=r,r2=r2,h=h,$fn=2*r*3.14/fnresolution);
		}
	} else {
		if (r2==undef) {
			cylinder(r=r,h=h,$fn=fn);
		} else {
			cylinder(r=r,r2=r2,h=h,$fn=fn);
		}
	}
}
