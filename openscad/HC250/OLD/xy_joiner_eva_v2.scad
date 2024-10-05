include <config.scad>
use <../lib.scad>
use <parts.scad>
use <x_carriage_EVA_v1.scad>
use <linear_bearing.scad>
$fn= 100;
lh=0.3;

print= 1;

// nema 17 dimensions
nema17_width = 42.3;
nema17_hole_offsets = [
	[-15.5,  15.5, -5],
	[-15.5, -15.5, -5],
	[ 15.5, -15.5, -5],
	[ 15.5,  15.5, -5]
];
//spacer(3.5, 10, 1.5);

/*
- Modelo: LM8LUU;
- Diâmetro interno: 8mm;
- Diâmetro externo: 15mm;
- Comprimento: 45mm.
*/
bix=43.5;    // back idler X
fix=53.7;    // front idler X
w=45;
h=30;
r=1;
t=thick_min;
dy=60;
depth=20;
bd=15; //bush diameter
fatiador=0;

/* Fatiador */
lineHeight = 0.32;
lineWidth  = 0.8;
supportWidth = 0.5;
firstlayer = 0.24;
fatias = multiple(h*3,lineHeight);
if(fatiador){
    for(i=[0:fatias]){
        translate([-l,-w,firstlayer+i*lineHeight])
       % cube([l*1.5,w*2, 0.1]);
    }    
}




/*******************************/
if(print==1){
    // Left
    *translate([-4,0,7.2]) 
    rotate([0,0,0,]) 
    xy_joiner();
    // Right
    *translate([-4,0,7.2]) 
    mirror([1,0,0,])     
    xy_joiner("R");
    
    /* Back axis */
    // Left
    rotate([0,90,0])  back_axis();
    // Right
    *rotate([0,90,0])  
    mirror([1,0,0]) back_axis(0);
    
    // Left
    *rotate([-90,0,0,]) 
    back_support();
    // Right
    *mirror([1,0,0])
    rotate([-90,0,0,]) 
    back_support();
    
    //left motor
    *rotate([90,0,0,])
    motor_fixing();
    // right motor
    *mirror([1,0,0])
    rotate([90,0,0,])
    motor_fixing(0.5);
    
}else{    
    // washer
    *difference(){
        cylinder(d=6, h=.6);
        
        translate([0,0,-.1])
        cylinder(d=3, h=1);        
    }
    
    // left joiner
    rotate([0,0,0]){
        color("orange") 
        translate([12,0,0]) 
        back_axis();

        xy_joiner("L");
        
        // test
        *difference(){
            intersection(){

                translate([44,-37,-5])
                cube([30,30,30]);
            }
            
            translate([40,-30,15])
            cube([30,30,30]);
        }
        
        // Idlers 
       * translate([fix,-16.75, belt_distance/2-1]) 
        %f623zz_idler();
        *translate([bix, 16.75, -belt_distance/2-8+1]) 
        %f623zz_idler();    
    }

    
    // right joiner
    *translate([150,0,0])
    //rotate([0,0,90])
    {
        mirror([1,0,0]){
        color("orange") 
        translate([12.1,0,0]) 
        back_axis(0);

        union(){
            xy_joiner("R");
                
            // Idlers 
           * translate([fix,-16.75, -belt_distance/2-8+1]) 
            %f623zz_idler();
            *translate([bix, 16.75, belt_distance/2-1]) 
            %f623zz_idler();    
        }
        }
    }
    
    /* Stepper */
    *translate([41.6+9.5-9,-dy+1.3,15.5]) 
    rotate([0,0,90])
    stepper();

    *belt_path();
    
    *back_support();
    *translate([150,0,0]) mirror([1,0,0]) back_support();
    
    *motor_fixing();
    *translate([150,0,0]) mirror([1,0,0]) motor_fixing(0.5);
    
    *references();
    *axis_x();
    *framey(dy);

    /* Left Y axis */
    *color("grey")
    translate([24,-dy-20-6,0])
    rotate([-90,0,0])
    cylinder(d=8, h=dy*2+40);
    
    *translate([90,-9,0])
    eva_xcarriage();        
}



/*************/
ud = upper_distance;
module motor_fixing(zdif=6){
    t=5.5;
    nw=nema17_width;
    z=30;
    
    // support
    if(print==1){
        translate([20, -dy-10-m5/2+.3, -16]) 
        rotate([-90,-90,0])
        support(5.5,4.9,m5-.6,0.4);

        translate([25.5, -dy-20+.37, -4.5]) 
        rotate([-90,-90,0])
        support(7+zdif, 5.4, 9.8-.35,0.4);
    }
    
    // chanel
    color("orange")
    {
        translate([10-fc/2, -dy-20, 10])
        scube(fc,5,15);
    }
    
    color("lime")
    translate([0,-dy-20,4])
    difference(){
        union(){
            // front
            hull(){
                translate([0, -t, 6])
                vrcube(nw+22+t, t, 14+ud-4, 1);
                translate([0, -t,-20])
                vrcube(nw+16+t, t, 26, 1);
            }
            // axis support
            translate([20, 10,-20])
            rcube(11, 10, 20+zdif, .5);
            translate([20, -t,-20])
            rcube(5, 20+t, 20+zdif, .5);

            // reinforce
            translate([66,0,zdif]) 
            rotate([-90,90,0])
            fillet(8,34.5);

            // mount base
            color("lime")
            translate([0,0, zdif]){
                translate([20, -t,0])
                rcube(nw+t, nw+t, t, 1);
                //right
                hull(){
                    translate([22+nw, -t,0])
                    rcube(t, nw+t, t, 1);
                    
                    translate([22+nw,,-t,0])
                    vrcube(t, t, 40);
                }
            }
        }
        
        //--------------------------------
        translate([18, 5, -7])
        scube(fc,20,5.75);
        
        translate([21+nw/2,nw/2+.2,-5+.01]){
            rotate([0,0,180])
            nema17_holes(h=20);
            translate([0,0, zdif]){
                translate([0,0,8.5])
                rotate([0,180,180])
                nema17_holes(sd=6);
                
                // reccess
                translate([-10, 0,4])
                rcube(20, nw+t, 2, 1);            
            }
        }
        
        // frontal holes
        translate([10, 10, -4])
        rotate([90, 0,0])
        cylinder(d=m5, h=nw);
        translate([10, 10, 30])
        rotate([90, 0,0])
        cylinder(d=m5, h=nw);
        
        // lateral hole
        translate([10, 10, -14])
        rotate([0, 90,0])
        cylinder(d=m5, h=20);
        translate([19, 10-m5/2, -21])
        scube(15,m5,7);
        
        translate([25, 10, -14])
        rotate([0, 90,0])
        cylinder(d=10, h=20);
        translate([25, 9, -20.1])
        scube(10,12,6);
        
        // axis
        translate([20+4, -t-1, -4])
        rotate([-90, 0,0])
        rpol(d=8+pressfit, h=40);
        
        // axis support
        translate([19, 0,-8])
        scube(12, 10, 8);
    }
}    


module m5_screw(){
    cylinder(d=9, h=3.5, $fn=6);
    cylinder(d=5, h=28.8);
}    
module m5_nut(){
    difference(){
        cylinder(d=9, h=3.5, $fn=6);
        
        translate([0,0,-.1])
        cylinder(d=5, h=28.8);
    }
}    
module axis_x(){  
    translate([43+5,0,0]){
        // Front
        color("silver") 
        rotate([0, 90, 0]) 
        cylinder(220,4,4);
        
        // Back
        color("silver") 
        translate([0, 37, 51]) 
        rotate([0, 90, 0]) 
        cylinder(220,4,4);
    }    
}

/*******************************/
module references(){
    //translate([-20, -0.75, -20]) #scube(50, 1.5, 50);

    translate([20+9.5+28.2, -dy-20, -20]) 
    #scube(.1, 40, 50);
    translate([20+50, -dy-20, -20]) 
    #scube(.1, 40, 50);
    
/*
    translate([-21.25, -20, -20]) 
    %scube(.1, 10, 50);
    translate([-7.25, -20, -20]) 
    %scube(.1, 10, 50);
       
    translate([-3, -12, -20]) 
    %scube(.2, 10, 50);    

    translate([-1+3.05, 5, -20]) 
    %#scube(.2, 10, 50);    
    translate([-25.25+ 36-.2, -12, -20]) 
    %#scube(.2, 10, 50);
    /**/
}

module back_axis(endstop=1){
    y=37;
    z=51;
    
    difference(){
        union(){
            // encaixe
            translate([47-13+1, 8.95, 11.5])
            rcube(12,11.8, 4, .25);

            translate([0,0,12.5])
            hull(){
                translate([47-13+1, 2.1, 1.6])
                rcube(12,24, 3, 2);

                translate([47-12, 16, 8])
                rcube(12,13.5, 3, 2);
            }
            
            hull(){
                translate([47-16, y, z]) 
                rotate([0,90,0])
                cylinder(d=15.5, h=16);

                translate([47-16, 17, 8+12.5])
                rcube(5,14,5, 1);

                translate([47-12, 14, 5+12.5])
                rcube(12,14,4, 2);
            }
        }
        //-------------------------------
        translate([47-13, y, z]) 
        rotate([0, 90, 0]) 
        rpol(d=8+pressfit,h=220);        

        // mount screw
        translate([41.6, 16.75, belt_distance/2]){ 
            translate([0,0,15])
            rotate([0,0,30])
            Mnut(b=0,l=20);
        }
    }
}

// Front Idler
fip=19.95;  // position
ih=10;      // height
bfi=belt_distance/2+3-ih/2;   // base
bbi=-belt_distance/2-3-ih/2;   // base
    
module path_right(side="R"){
    // Belt path back
    if(side=="R"){
        translate([30-8-5,8.85,bfi])
        cube([w/2+5,4.5,ih]);
    }
    
    // back idler screw
    translate([bix-20, 16.75, bfi]){ 
        if(side=="R"){
            translate([0,0,13.5])
            Mscrew(25);            
        }
        translate([0,0, 0])
        cylinder(d=15, h=ih);
    }

    // belt path front
    translate([0,0,bbi]){
        translate([34.4-7.9,-w/2-16,0])
        cube([4,w/2,ih]);
        translate([42-8,-13.6,0])
        cube([w/2,4,ih]);
    }
    
    // front idler screw
    translate([fix-20, -16.75, bbi]){ 
        translate([0,0,-3])
        rotate([180,0,180])
        Mscrew(20);            
    
        cylinder(d=14.5, h=ih);
    }   

    // remove bottom front
    if(side=="L"){
        translate([fix-20, -16.75, -belt_distance/2-11.5+1-5]){ 
            translate([0,0,3.2])
            cylinder(d=14.5, h=8.5);
        }
       translate([0,0,-10.8-5]){
             translate([34.4-7.9,-w/2-16,0])
            cube([4,w/2,8.5]);
            translate([42-8,-13.6,0])
            cube([w/2,4,8.5]);
        }
    }
}    

module path_left(side="L"){
    // Belt path BACK
    translate([23-9,16,bbi])
    cube([14,w/2,ih]);    
    if(side=="L"){
        translate([30-12, 8.85,bbi])
        cube([w/2,6,ih]);
        translate([30-8, 8.85,bbi])
        cube([15,8,ih]);    
    }
    
    // back idler screw 
    translate([bix-20, 16.75, 0]){ 
        if(side=="L"){
            translate([0,0, -14])
            rotate([180,0,180])
            Mscrew(20,b=1);            
        }
        translate([0,0,bbi])
        cylinder(d=15, h=ih);
    }

    // belt path FRONT
    translate([fix-20-7.5,-w/2-16,bfi])
    cube([4,w/2,ih]);
    translate([fix-20,-16.75+7.5-4,bfi])
    cube([w/2,4,ih]);

    // front idler screw
    translate([fix-20, -16.75, 0]){ 
        translate([0,0,-belt_distance/2-11+1+28])
        Mscrew(20);  
        
        translate([0,0,bfi])
        cylinder(d=15, h=ih);
    }
        
    if(side=="R"){
        translate([fix-20, -16.75, -belt_distance/2-11+1]){ 
            translate([0,0,15.7])
            cylinder(d=15, h=15);
        }
        // belt path front
        translate([34-7.8,-w/2-16,2.2])
        cube([4,w/2,15]);
        translate([42-8,-13.25,2.2])
        cube([w/2,4,15]);

    }    
}    

module xy_joiner(side="L"){ 
    /* bush
    if(print==0){
        difference(){
            color("lime")
            translate([24,-ybush_len/2-.01,0])
            rotate([-90,0,0])
            cylinder(d=15, h=ybush_len+.02);
        
            // Y axis
            translate([24,-dy,0])
            rotate([-90,0,0])
            cylinder(d=8, h=dy*2);
        }
    }
    
    /* Support */
    // back
    translate([41, 11, bfi+lh])
    support(6,11.5,ih-lh*2, 0.4);

    translate([35, 10, bbi+lh])
    support(13,12,ih-lh*2, 0.4);
    translate([35-.5, -21.8, bbi+lh])
    support(5,14+2,ih-lh*2, 0.4);
    
    // front
    if(side=="L"){
        translate([49, -w/2, bfi+lh])
        support(10,10,ih-lh*2, 0.4);
        
        translate([49, -w/2, -15.5])
        support(10,10,4+ih-lh, 0.4);
    }else{
        translate([49, -w/2, -11.5+lh])
        support(10,10, ih-lh*2, 0.4);
    }
    
    /* Sacrifice Bridges*/
    bh=.3;  // bridge height
    // back
    translate([bix, 16.75, bbi+ih])
    cylinder(d=15, h=bh);
    translate([bix, 16.75, bfi+ih])
    cylinder(d=3.8, h=bh);
    // front
    translate([fix, -16.75, bbi+ih])
    cylinder(d=10, h=bh);
    if(side=="L"){
        translate([fix, -16.75, bfi+ih])
        cylinder(d=10, h=bh);
    }
    
    
    /* Center cut ramp */
    translate([32.4,0,0])
    difference(){
        translate([10-.1,-w/8,-5+.75])
        rotate([0,-45,0])
        scube(4,w/4,4);
        
        translate([5,-8,-1.5])
        cube([10,w/4+5,10]);

        translate([10,-8,-5])
        cube([10,w/4+5,10]);
        
        rotate([0,90,0])
        cylinder(d=3.6, h=30);
    }

    /* Y Carriage */
    //color("grey")
    translate([20,0,0])
    difference(){      
        union(){  
            /* body */
            translate([8,-w/2,0]){
                translate([-5,0,-15.5])
                rcube(31+5,w+3, 17+1, 4);

                translate([10, 0,-15.5])
                rcube(31-10,w+3, 17+12.5+2, 4);
            }
            
            /* endstop */
            if(side=="L"){
                translate([21,-15,11])
                rcube(4,24,13, .5);
            }
            
            /* bush fix */
            translate([4,-w/2,0])
            rotate([-90, 0, 0])
            difference(){
                cylinder(d=22, h=w);
                
                translate([0,0,-.1]){
                    cylinder(d=15, h=w+1);
                    
                    translate([-28,-15,-.1])
                    cube([30,30,w+1]);
                }
            }
                        
            /*axis fixing */
            translate([43-22,0,0]){
                rotate([0, 90, 0])
                cylinder(r=4+3.4, h=18);
            }
        }
        
        //----------------------------------
        
        if(side=="R"){
            translate([13.5, 8.9, belt_distance/2+ 10]) 
            rotate([0,60,0])
            scube(10,14.5,6);    
        }
        // bush
        translate([4,-ybush_len/2-.01,0])
        rotate([-90,0,0])
        cylinder(d=15, h=ybush_len+10);
        
        translate([-8,0,0]){ 
            
        // X Axis
        translate([43+5-20+8,0,0])
        rotate([0, 90, 0]) 
        rotate([0, 0, 30]) 
        rpol(d=8+pressfit,h=220);   
        
        //Center Nut
        translate([31,0,0])
        rotate([0,90,0])
        rotate([0, 0, 30]) 
        Mnut(b=false);
      
        //Center cut
        translate([6+1.5,-w/8,-7/2])
        scube(20,w/4,30);

        /* Bush fixing*/
        translate([12,w/3-3,0])
        rotate([-90,0,0])
        ring(12,10,4);
        translate([12,-w/3-1,0])
        rotate([-90,0,0])
        ring(12,10,4);
     
        /* back axis */
        translate([47-13-fit/2+1, 2, 1.5+12.5])
        rcube(15+fit, 26, 20, 2);
        *translate([47-13-fit/2+1, 9, 10.75+1])
        rcube(15+fit, 26, 20, 2);
        // encaixe
        translate([35-.15, 8.85, 11.4])
        cube([w/2, 4+8, 8.5]);
        translate([35-.15, 8.85, 11.4])
        cube([3, 20, 8]);
        /**/
        
        // bush
        translate([-2.5,-ybush_len/2-10,-24])
        rotate([-90,0,0])
        cylinder(d=bush_width, h=ybush_len+20);
                       
        }

        path_right(side);
        path_left(side);
        
        /* Belt path side */
        translate([23-9,-w/2-1,bfi])
        cube([7,w+5,15]);

        translate([23-9,-w/2-1,bbi])
        cube([7,w+10,ih]);
        
        // mount screw
        translate([33.6, 16.75, bbi+ih+.2 +2.5]){ 
            rotate([180,0,180])
            Mscrew(20,b=1);            
        }        
    }
}

module back_support(){
    // washer 0.8

    // support
    if(print==1){
        translate([20, dy+10-m5/2+.27, -27]) 
        rotate([-90,-90,0])
        support(5.5,4.9,m5-.5,0.4);
    }
    
    difference(){
        union(){
            /**/
            // chanel
            color("orange")
            {
                translate([43, dy+15, 53.5-10-fc/2])
                scube(14,5,fc);

                translate([10-fc/2, dy+15, 35])
                scube(fc,5,12);
                translate([10-fc/2, dy+15, -5])
                scube(fc,5,20);
            }
            
            hull(){
                translate([0,dy+20,-27])
                vrcube(61,5,20);

                translate([0,dy+20,53.5-20])
                vrcube(75,5,20);
            }
            
            // axis support
            translate([20,dy,-10])
            vrcube(11,21,20);

            translate([20+5,dy,-27])
            rotate([0,0,90])
            vrcube(22,5,25);
                
            translate([bix,dy+6,0]){
                translate([0,0,10.5+.9]){ 
                    translate([25/2,14,6]) 
                    rotate([90,-90,0])
                    fillet(5,25);
                    hull(){
                        cylinder(d=15,h=6);
                        translate([-12.5,9,0])
                        scube(25,5,6);
                    }
                    translate([-25/2,14,6-6]) 
                    rotate([90,90,0])
                    fillet(5,25);
                }
                translate([0,0,-1.7]){ 
                    translate([25/2,14,3.4]) 
                    rotate([90,-90,0])
                    fillet(5,25);
                    hull(){
                        cylinder(d=15,h=3.4);
                        translate([-12.5,9,0])
                        scube(25,5,3.4);
                    }
                    translate([-25/2,14,6-6]) 
                    rotate([90,90,0])
                    fillet(5,25);
                }
                translate([0,0,-14.5-.9-2]){ 
                    translate([25/2,14,6]) 
                    rotate([90,-90,0])
                    fillet(5,25);
                    hull(){
                        cylinder(d=15,h=6);
                        translate([-12.5,9,0])
                        scube(25,5,6);
                    }
                    translate([-25/2,14,6-6]) 
                    rotate([90,90,0])
                    fillet(5,25);
                }
            }
            /**/
        }
        //-----------------------
        translate([bix,dy+6,0])
        rotate([0,0,180]){
            translate([0,0,10.5+3.5+1]) 
            Mscrew(32);
            translate([0,0,-26-1]) 
            Mnut(30);
        }

        // axis
        translate([20+4, 0, 0])
        rotate([-90, 0, 0])
        rpol(d=8, h=dy+14);

        // frontal holes
        translate([10, dy+30, -15])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);
        translate([10, dy+30, 25])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);

        translate([35, dy+30, 53.5-10])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);
        translate([65, dy+30, 53.5-10])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);
        
        // lateral hole
        translate([10, dy+10, -22])
        rotate([0, 90,0])
        cylinder(d=m5, h=20);
        translate([15, dy+10-m5/2, -29])
        scube(15,m5,7);
                
    }
}    
