include <config.scad>
use <../lib.scad>
use <parts.scad>
use <x_carriage_EVA_v1.scad>
use <linear_bearing.scad>
$fn= 50;
lh=0.32;
slack = 0.2;   

print = 0;

/*
- Modelo: LM8LUU;
- Diâmetro interno: 8mm;
- Diâmetro externo: 15mm;
- Comprimento: 45mm.
*/
fip=19.95;  // position
ih=10;      // height
ph=belt_distance+belt_size*2+4;
bfi=belt_distance/2+3-ih/2;   // base
bbi=-belt_distance/2-3-ih/2;   // base
sb=-(ph+10)/2+5;    // spacer base
ad=axis_diam;
bw=bush_width;

fix=57.5;    // front idler X
//bix=43.5;    // back idler X
bix=fix;    // back idler X
joiner_width =50;
w=joiner_width;
h=ph+10;
r=1;
t=thick_min;
dy=60;
depth=20;
wh=1; // washer height
bd=15; //bush diameter
fatiador=0;


/* Fatiador *
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
    
    *rotate([0,90,0])
    y_endstop();
    
    //mirror([01,0]) // Right Joiner
    /* Left Joiner *
    {
        *translate([-23,0,16.5]) 
        xy_joiner("L");
        
        translate([20,0,-11.5]) 
        //rotate([0,180,0]) 
        xy_joiner("H");
    }


    /* Spacer *
    translate([0, 0, 0])
    washer();
    translate([0, 8, 0])
    washer();
    translate([8, 0, 0])
    washer();
    translate([8, 8, 0])
    washer();

    
    /* Back Support *
    // Left
    *rotate([-90,0,0,]){ 
        back_support();
        idlers_support();
    }
    // Right
    translate([150,0,0])
    rotate([-90,0,0,]){
        mirror([1,0,0])
        back_support();
        
        translate([-bix*2+bxd,0,0])
        idlers_support();
    } 
    
    /* Motor Fixing *
    //left motor
    *rotate([90,0,0,])
    motor_fixing(6);
    
    // right motor
    translate([-20,0,0])
    mirror([1,0,0])
    rotate([90,0,0,])
    motor_fixing(-5.5);
    /**/
}else{    

    /* carriage */
    translate([90,-11.5,0]){
        
        *translate([-50, 23+10, 51]) 
        rotate([0,90,0])
        cylinder(d=8, h=100);

        eva_xcarriage();        
        xcarriage();
        duct_eva_volcano();
        HX_extruder();
        // X Bush
        translate([-20, 23+10, 51]) 
        bush(xbush_len);
        belts(50,50);
    }

    *tension_slider();
    *y_endstop();   
    
    /* Y Bush */
    *translate([24,-ybush_len/2,0])
    rotate([0,0,90])
    bush(ybush_len);
    
    
    /* right joiner *        
    translate([180,-5,0])
    mirror([1,0,0]){
        /* left joiner */
        spacer();
        mirror([0,0,1])
        mirror([0,1,0])
        spacer();

        xy_joiner("L");

        xy_joiner("H");
    //}
    
    /* Idlers */
    translate([fix,-tbd/2-1.25-5-belt_thick , belt_distance/2-1]) 
    %f623zz_idler();
    translate([bix, tbd/2+1.25+5+belt_thick, -belt_distance/2-8+1]) 
    %f623zz_idler();    

    /* motor_fixing *
    //left
    translate([41.6+9.5-9+2.5,-dy+1.3,15.5]) 
    rotate([0,0,90])
    stepper();

    motor_fixing(5);

    /* right *
    *translate([41.6+9.5-9+2.5+91,-dy+1.3, 4.5]) 
    rotate([0,0,90])
    stepper();
        
    *translate([180,0,0])
    mirror([1,0,0]) 
    motor_fixing(-5);
    
    
    /* Back support *
    // left
    back_support();
    // right
    translate([180,0,0]) mirror([1,0,0]) back_support();
    /**
    *axis_x();
    frame_front(dy);
    framey(dy);

    /* Right Y axis *        
    translate([180,-5,0])
    mirror([1,0,0]){
    /* Left Y axis *
    color("grey")
    translate([24,-dy-20-6,0])
    rotate([-90,0,0])
    cylinder(d=8, h=dy*2+40);
    //}
    /**/
}

module y_endstop(){
    //color("red")
    %translate([156,-49,-44])
    rotate([0,-90,0])
    import("/home/hespanhol/OneDrive/openscad/HC230/stl/Endstop.stl");

    translate([160,-32,-59])
    rotate([0,-90,0])
    rotate([0,0,-90])
    difference(){
        union(){
            translate([.5,8,0])
            rcube(16.5,46.5,8);

            translate([1,8,0])
            rcube(21,34.5,8);
            
            translate([7,22.5,0])
            rcube(40.5,20,5, 1);
        }
        //----------------------------
        translate([1,28,0])
        union(){
            translate([3,3.5,-10])
            rotate([0,0,30])
            Mnut();

            translate([3,22.5,-10])
            rotate([0,0,30])
            Mnut();

            translate([7.5,5.5,-1])
            cube([3,15,10]);
            
            translate([2.5,-4,-1])
            cube([10,3,10]);
        }    
        
        // 5mm screw
        translate([38,33,-5])
        cylinder(h=15, d=5.7);    
        
        
        translate([-0.01,12,6])
        cube([18,57.01,8]);

    }
}


    
module tension_slider(){

    difference(){
        union(){
            translate([25/2, 0, 2.5+1])
            rotate([-90,0,0])
            import("EVA_stl/tension_slider_6mm_belt_M3s.stl");

            hull(){
                c=1;
                translate([0,c,0])
                scube(25, 13.5-c*2, .1);

                translate([0,0,1.5])
                scube(25, 13.5, .1);
            }
            
            translate([0,0,1.5])
            scube(25, 8.95, 7.7);
        }
        //------------------------------
        translate([-1.85,0,-.1])
        rotate([0,0,-45])
        cube([2,2,10]);

        translate([-1.85,13.5,-.1])
        rotate([0,0,-45])
        cube([2,2,10]);
        
        translate([10,4.6,4.6])
        rotate([0,90,0])
        rotate([0,0,30])
        Mnut(b=0,l=20);
    }
}

module frame_front(dy){
    color("white") 
    translate([20,-dy-20,-36]) 
    cube([200,20,20]);    
}    

/*************/
ud = upper_distance;
module motor_fixing(zdif=5){
    t=5.5;
    nw=nema17_width;
    z=30;
    
    // support
    if(print==1){
        translate([27.5, -dy-20+.37, -5]) 
        rotate([-90,-90,0])
        support(5+zdif, 5.4, 9.8-.35,0.4);

        translate([26, -dy-20+.37, zdif]) 
        rotate([-90,-90,0])
        support(3, 7, 9.8-.35,0.4);
    }
    
    // chanel fix
    color("orange")
    {
        translate([10-fc/2, -dy-20, 0])
        scube(fc,5,20);
    }
    
    color("lime")
    translate([0,-dy-20,4])
    difference(){
        union(){
            // front
            translate([0, -t,-40.4])
            vrcube(73, t, 90, 2);

            // axis support
            hull(){
                translate([20, 10,-10])
                rcube(13, 20, 10+zdif, .5);
                translate([20, 10,-20])
                rcube(5, 20, 20+zdif, .5);
            }
            translate([20, -t,-20])
            rcube(5, 20+t+10, 20+zdif, .5);

            // reinforce
            translate([72.3,0,zdif]) 
            rotate([-90,90,0])
            fillet(6,38);

            // mount base
            color("lime")
            translate([0,0, zdif]){
                translate([20, -t,0])
                rcube(nw+t+2.5, nw+t, t, 1);
                //right
                hull(){
                    translate([24.5+nw, -t,0])
                    rcube(t, nw+t, t, 1);
                    
                    translate([24.5+nw,,-t,0])
                    vrcube(t, t, 40);
                }
            }
        }
        
        //--------------------------------
        // axis support
        translate([18, 0, -8.1])
        scube(fc,50,8.2);
        
        // stepper holes
        translate([21+nw/2+2.5,nw/2+.2,-5+.01]){
            rotate([0,0,180])
            nema17_holes(h=20);
            translate([0,0, zdif]){
                translate([0,0,8.5])
                rotate([0,180,180])
                nema17_holes(sd=6);
                
                // reccess
                translate([-10, 0,4])
                rcube(20, nw+t, 4, 1);            
            }
        }
        
        // frontal holes
        translate([10, 10, 38])
        rotate([90, 0,0])
        cylinder(d=m5, h=nw);
        translate([10, 10, -30])
        rotate([90, 0,0])
        cylinder(d=m5, h=nw);

        translate([65, 10, -30]){
            rotate([90, 0,0])
            cylinder(d=m5, h=nw);
            translate([0, -18, -m5/2])
            scube(15,10,m5);
        }
        
        // lateral hole
        translate([10, 10, -14])
        rotate([0, 90,0])
        cylinder(d=m5, h=20);
        
        translate([25, 10, -14])
        rotate([0, 90,0])
        cylinder(d=9.5, h=20);
        translate([25, 5, -20.1])
        scube(10,10,6);
        
        // axis
        translate([20+4, -t-1, -4])
        rotate([-90, 0,0])
        rpol(d=8+pressfit, h=dy);
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

module back_axis(){
    y=21.5;
    z=51;
    wx=12.5;

    translate([xs-23.5,0,0]) 
    difference(){
        union(){
            // endstop
            translate([38-4,-10,16])
            rotate([0,0,90])
            vrcube(25, 5, 16);
            
            // sphere
            difference(){      
                translate([47-9-4, y, z]) 
                sphere(d=16.3);
                
                translate([47-11.5-4, y-12, 40]) 
                cube([26,25,ph]);
            }
                
            // top
            hull(){
                translate([31.5, y, z]) 
                rotate([0,90,0])
                cylinder(d=15.5, h=wx+4);

                translate([29.5, 12, z-13])
                rcube(wx+6,15.5, .1, 2);
            }
            // base
            hull(){
                translate([29.5, 12, z-13])
                rcube(wx+6,15.5, .1, 2);

                translate([19, 10, 16.5])
                rcube(wx+6, 15, .1, 2);
            }
        }
        //-------------------------------
        /* X axis*/
        translate([-15.5+69-20, y, z]) 
        rotate([0, 90, 0]) 
        rpol(d=8+pressfit,h=220);        
    }
}

module washer(){
    difference(){
        union(){
            cylinder(d1=7, d2=6, h=wh);  
        }
        //--------------------------
        translate([0,0,-.1]){
            cylinder(d=3.5, h=ph);  
        }
    } 
}

module spacer(){
    translate([fix, -tbd/2-1.25-5-belt_thick, sb]) 
    difference(){
        union(){
            translate([0,0,ph-10])
            cylinder(d1=7, d2=6, h=wh);  

            cylinder(d=10, h=ph-8-2);  
        }
        //--------------------------
        translate([0,0,-.1]){
            cylinder(d1=7.2, d2=3, h=wh+3);  

            cylinder(d=3.5, h=ph);  
        }
    } 
}

xs=40;
module encaixe(sl){
    translate([0,0,ph/2]){
        translate([20+ad/2+bw/2-1-sl,-tbd+5-sl,-sl])
        cube([4+(sl*2),10+(sl*2),5+(sl*2)]);
        translate([20+ad/2+bw/2-1-sl,tbd-15-sl,-sl])
        cube([4+(sl*2),10+(sl*2),5+(sl*2)]);
        
        translate([29+ad/2+xs-17.5-sl,-5-sl,-sl])
        scube(4+(sl*2),10+(sl*2),5+(sl*2) );
    }
}

module xy_joiner(side="L"){   
    
    if(side=="L"){
        encaixe(0);
    }else{
        back_axis();
    }
        
    /* Y Carriage */
    translate([20,0,0])
    difference(){      
        union(){  
            /* body */
            difference(){      
                translate([ad/2,-w/2,-16.5])
                rcube(xs,w, ph+10, 4);
                
                translate([ad/2+bw/2+3,-w/2-1,bbi])
                cube([xs,w+2,ph]);
            }
            
            translate([ad/2+xs-17.4, -tbd/2,-15.5])
            rcube(17.4, tbd, ph+8, 2);
            
            /* spacer */
            //bottom
            translate([fix-20, -tbd/2-1.25-5-belt_thick, sb]) 
            cylinder(d1=7, d2=5.5, h=wh);  
            translate([bix-20, tbd/2+1.25+5+belt_thick, sb])
            cylinder(d1=7, d2=5.5, h=wh);  
            
            /* top
            translate([fix-20, -tbd/2-1.25-5-belt_thick, sb+ph-wh]) 
            cylinder(d1=5.5, d2=7, h=wh);  
            translate([bix-20, tbd/2+1.25+5+belt_thick, sb+ph-wh])
            cylinder(d1=5.5, d2=7, h=wh);  
            
            /* bush fix */
            translate([ad/2,-w/2,0])
            rotate([-90, 0, 0])
            difference(){
                translate([0,0,0.5])
                cylinder(d=22, h=w-1);
                
                translate([0,0,-.1]){
                    cylinder(d=15, h=w+1);
                    
                    translate([-28,-15,-.1])
                    cube([30,30,w+1]);
                }
            }                        
        }
    
        //-------------------------------
        /* bush */
        translate([4,-ybush_len/2,0])
        rotate([-90,0,0])
        cylinder(d=bw, h=ybush_len);
        translate([4,-ybush_len/2-10,0])
        rotate([-90,0,0])
        cylinder(d=bw-4, h=ybush_len+20);

        // X Axis
        translate([49-20,0,0])
        rotate([0, 90, 0]) 
        rotate([0, 0, 30]) 
        rpol(d=8+pressfit,h=220);   

        /* Bush fixing*/
        translate([18-21,-2,0])
        rotate([-90,0,0])
        ring(19,16.5,4);
     
        /* Belt path side */
        translate([ad/2+bw/2+3,-w/2-1,bbi+1])
        cube([11,w+2,ph-2]);

        /* cut */
        cut = ph/2;
        if(side == "L"){
            translate([0,-w/2-1,cut-.1])
            cube([50,w+2,ph]);

            // front idler screw
            translate([fix-20, -tbd/2-1.25-5-belt_thick, -16.5]) 
            rotate([180,0,0])
            Mscrew(35,b=0);  
            // back idler screw
            translate([fix-20, tbd/2+1.25+5+belt_thick, -16.5]) 
            rotate([180,0,0])
            Mscrew(35,b=0);  
        }else{
            translate([0,-w/2-1,cut-ph-10])
            cube([50,w+2,ph+10]);

            translate([-20,0,0])
            encaixe(slack);

            translate([fix-20, -tbd/2-1.25-5-belt_thick, 15]) 
            Mnut(0);  
            translate([bix-20, tbd/2+1.25+5+belt_thick, 15])
            Mnut(0);  
        }        
    }    
}

/* Idlers support */
bxd=11.5;    // belt x distance
fy=10;
sbw=19.5;  // base width
fl=5;

module suph(){
    difference(){
        union(){
            translate([sbw/2,fy,6]) 
            rotate([90,-90,0])
            fillet(fl,sbw);
            hull(){
                cylinder(d=15,h=6);
                translate([-sbw/2,fy-5,0])
                scube(sbw,5,6);
            }
            translate([-sbw/2,fy,6-6]) 
            rotate([90,90,0])
            fillet(fl,sbw);
            
            //top
            translate([0, 0, -wh]) 
            cylinder(d1=5.5, d2=7, h=wh);
        }

        //---------------------
        rotate([180,0,0])
        translate([0,0,-17]) 
        Mnut(b=0);
    }
} 
module supl(){
    difference(){
        union(){
            translate([sbw/2,fy,6]) 
            rotate([90,-90,0])
            fillet(fl,sbw);
            hull(){
                cylinder(d=15,h=6);
                translate([-sbw/2,fy-5,0])
                scube(sbw,5,6);
            }
            translate([-sbw/2,fy,6-6]) 
            rotate([90,90,0])
            fillet(5,sbw);

            //bottom
            translate([0, 0, 6]) 
            cylinder(d1=7, d2=5.5, h=wh);      
            
        }
        //------------------------------
        translate([0,0,-11]) 
        Mnut(b=0);
    }    
}
module middle_sup(){
    difference(){
        union(){
            translate([0,0,-1.7]){ 
                translate([sbw/2,fy,3.4]) 
                rotate([90,-90,0])
                fillet(fl,sbw);
                hull(){
                    cylinder(d=15,h=3.4);
                    translate([-bxd,0,0])
                    cylinder(d=15,h=3.4);
                    translate([-sbw/2,fy-5,0])
                    scube(sbw,5,3.4);
                }
                translate([-sbw/2,fy,6-6]) 
                rotate([90,90,0])
                fillet(fl,sbw);
            }
            translate([-bxd,0,-1.7]){ 
                translate([sbw/2,fy,3.4]) 
                rotate([90,-90,0])
                fillet(fl,sbw);
                hull(){
                    cylinder(d=15,h=3.4);
                    translate([-sbw/2,fy-5,0])
                    scube(sbw,5,3.4);
                }
                translate([-sbw/2,fy,6-6]) 
                rotate([90,90,0])
                fillet(fl,sbw);
            }
        }
    }
}    
module idlers_support(){
    difference(){
        union(){
            translate([bix,dy+6,0]){
                // upper
                translate([-bxd,0,10.5+.9])
                suph();
                /* middle */
                middle_sup();        
                // lower
                translate([0,0,-14.5-.9-2])
                supl();
            }
            
            /* middle spacer */
            translate([fix, dy+6, sb+9.8-wh]) 
            cylinder(d1=5.5, d2=7, h=wh);
            // Idler
            translate([fix, dy+6, sb+wh]) 
            %f623zz_idler();
            
            translate([-bxd, 0, 13.2]){
                translate([fix, dy+6, sb]) 
                cylinder(d1=7, d2=5.5, h=wh);            // Idler
                translate([fix, dy+6, sb+wh]) 
                %f623zz_idler();
            }
        }
        //------------------
        
        // Idler screws
        translate([bix,dy+6,0])
        rotate([0,0,180]){
            translate([0,0,1.5]) 
            Mscrew(5);
        }
        translate([bix-bxd,dy+6,0])
        rotate([180,0,0]){
            translate([0,0,1.5]) 
            Mscrew(5);
        }
    }
}    
        
module back_support(){
    
    // support
    if(print==1){
        translate([20, dy+10-m5/2+.27, -22.5]) 
        rotate([-90,-90,0])
        support(5.5,4.9,m5-.5);
    }
    
    difference(){
        union(){
            /* chanel */
            color("orange")
            {
                translate([38, dy+15, 53.5-10-fc/2])
                scube(12,5,fc);

                translate([10-fc/2, dy+15, 35])
                scube(fc,5,12);
                translate([10-fc/2, dy+15, -4])
                scube(fc,5,18);
            }
            
            // back
            translate([0,dy+20,-22.5])
            vrcube(70,5,76);
            
            //back idlers support
            translate([20,dy+6+fy,-22.5])
            vrcube(50,5,76-20);
            
            // axis support
            translate([20,dy,-10])
            vrcube(11,20,20);

            // latteral fix
            translate([20+5,dy,-22.5])
            rotate([0,0,90])
            vrcube(20,5,25);            
            /**/
        }
        //-----------------------
        // axis
        translate([20+4, 0, 0])
        rotate([-90, 0, 0])
        rpol(d=8, h=dy+14);

        translate([15, dy-6, -2.5])
        scube(10,20,5);

        // frontal holes
        // vertical
        translate([10, dy+30, -13])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);
        translate([10, dy+30, 25])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);
        // horizontal
        translate([28.5, dy+30, 53.5-10])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);
        translate([60, dy+30, 53.5-10])
        rotate([90, 0,0])
        cylinder(d=m5, h=20);
        
        // lateral hole
        translate([24.5, dy+10, -17])
        rotate([0, 90,0])
        Mscrew(10, 4.7);
        translate([15, dy+10-m5/2, -24])
        scube(15,m5,7);
                
    }
}    
