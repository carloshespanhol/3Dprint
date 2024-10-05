include <config.scad>
use <../lib.scad>
use <parts.scad>
use <x_carriage_v11.scad>
$fn= 100;

// nema 17 dimensions
nema17_width = 42.3;
nema17_hole_offsets = [
	[-15.5,  15.5, -5],
	[-15.5, -15.5, -5],
	[ 15.5, -15.5, -5],
	[ 15.5,  15.5, -5]
];
//spacer(3.5, 10, 1.5);

w=40;
h=30;
r=1;
dy=40;
depth=20;

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

*zfix();
*references();
*belts(dy);

/* Left */
color("grey")
translate([24,-dy-20-t-1,-24])
rotate([-90,0,0])
cylinder(d=8, h=dy*2+40);
/*
color("silver")
translate([24,-ybush_len/2,-23])
rotate([-90,0,0])
cylinder(d=bush_width, h=ybush_len);
/**/

translate([85,0,0]){
//voron_xcarriage();
    
//translate([0,0,15])    
//mswitch2();
}

translate([41.75,0,0])
{
    xy_joiner();
    %pulley();
}
// Stepper 
translate([29.7,dy+50,13]) rotate([0,180,0])
stepper();

//framey(dy);
front_support();
front_idler();

back_idler();
translate([41.75,0,0])
translate([0,dy+7,0])
mirror([0,0,1])
%pulley();


/* Right *
translate([150,0,0])
mirror([1,0,0])
{
    color("grey")
    translate([24,-dy-20-t-1,-23])
    rotate([-90,0,0])
    cylinder(d=8, h=dy*2+40);
    
    translate([41.75,0,0])
    {
        xy_joiner(1);

        mirror([0,0,1])
        %pulley();
    }
    // Stepper 
    translate([29.7,dy+50,13-11.2]) rotate([0,180,0])
    stepper();

    //framey(dy);
    //color("orange")  front_support(-belt_distance/2-8);
    //front_idler(-belt_distance/2-8);

    back_idler(-11.2);
    
    translate([41.75,0,0])
    translate([0,dy+7,0])
    //mirror([0,0,1])
    %pulley();
}

/**
fatia = 100;

    echo(h/2-firstlayer-(fatia-1)*lineHeight);
    translate([-l,-w*1.5,h/2-firstlayer-(fatia-1)*lineHeight-50])
    cube([l*2,w*3, 50]);
/**/
//=============================================
module back_idler(m=0){ 
    hb=73.5+11.2;
    ph=9; //pole height
    
    /* stepper mounting */
    translate([30,dy+50,15-ph+m])
    for (a = nema17_hole_offsets) {
        translate(a)
        {
            // Washers 
            difference(){
                %color("grey"){
                    translate([0,0,-3])  
                    cylinder(d = 14, h = 3);
                    translate([0,0,ph])  
                    cylinder(d = 14, h = 3);
                }
                
                translate([0,0,-.1])
                cylinder(d=4, h=20);
            }
        }
    }
    // fixing    
    a = nema17_hole_offsets;
    translate([30,dy+50,15-ph+m]){
        hull(){
            translate(a[0])
            cylinder(d = 11, h = ph);
            
            translate([0,-9,0])
            translate(a[1])
            cylinder(d = 11, h = ph);
        }
        hull(){
            translate([0,-9,0])
            translate(a[2])
            cylinder(d = 11, h = ph);
            
            translate(a[3])
            cylinder(d = 11, h = ph);
        }
        hull(){
            translate(a[0])
            cylinder(d = 11, h = ph);
            
            translate(a[3])
            cylinder(d = 11, h = ph);
        }
    }
    translate([0,dy+6.9,m]){        
        hull(){
            translate([15,13.1,-20])
            rcube(30,t,t, 2);

            translate([22,53.1,-20])
            rcube(16,11,t, 2);
        }

        hull(){
            translate([22,53.1,1])
            rcube(16,11,t, 2);

            translate([22,53.1,-20])
            rcube(16,11,t, 2);
        }
    }
    
    /* Idler Mounting */
    translate([0,dy+6.9,0])
    difference(){            
        union(){
            // back
            translate([0,13.1,-31.2])
            vrcube(55+10,t+.8,hb, 2);

            // horizontal
            translate([20,-w/2+13,-h/2-5-11.2])
            scube(12,w-13,t-1+5+11.2);
            translate([20,-w/2+13,h/2-t+1])
            scube(depth+3,w-13,t-1);

            // vertical
            translate([20,-w/2+13,h/2-t+1])
            scube(t,w-13,24.5-1);

            
            translate([26.75,0,0]){
                /* body */
                translate([2.5,-w/2,-h/2])
                rcube(depth+3,w-1,h, 2);
                    
                /* spacers */
                translate([15,-6.6, 0.55])
                %cylinder(d=5, h=.6);
                translate([15,-6.6, 9.82])
                %cylinder(d=5, h=.6);

                translate([15,6.6, -1.15])
                %cylinder(d=5, h=.6);
                translate([15,6.6, -10.42])
                %cylinder(d=5, h=.6);
            }            
            /**/
        }
        
        //----------------------------------
        if(m != 0){
            translate([26.75,0,0])
            {
                xy_space();
                bearing_fixing();
                
                translate([-6.5, 0, -belt_distance/2-belt_size-2]) 
                rcube(20,30,10,1);
                
            }
        }else{
            translate([26.75,0,0])
            mirror([0,0,1]){
                xy_space();
                bearing_fixing();
                
                translate([-6.5, 0, -belt_distance/2-belt_size-2]) 
                rcube(20,30,10,1);
                
            }
        }
        
        // chamfer
        translate([20+t+1,-w/2-5, 6])
        rotate([40,0,0])
        scube(depth+10,w-13,20);
        
        // screws
        translate([10,18,-21])
        rotate([-90,0,0])
        Mscrew(l=10, d=5.5);
        translate([10,18,45])
        rotate([-90,0,0])
        Mscrew(l=10, d=5.5);
        translate([55,18,45])
        rotate([-90,0,0])
        Mscrew(l=10, d=5.5);
        
        translate([25,3,25])
        rotate([0,90,0])
        Mscrew(l=15, d=5.5);
        translate([25,3,-23])
        rotate([0,90,0])
        Mscrew(l=15, d=5.5);
    /**/
    }
}


/* Belt Path Support*/
/********************/
t=6;
ud = upper_distance;
/* Front Support */
module front_idler(pz=0.75){
    /* Front Idler */
    translate([29.75,-dy+7,pz])
    %idler_pulley("top","teeth");
    
    translate([20,-dy+7,pz])
    difference(){
        union(){ 
            translate([9.75,0,0])
            color("orange")
            hull(){
                translate([0,0,-t]) 
                cylinder(d=19,h=t*2+9.5);
                

                translate([-9.5,-20,-6]) 
                scube(19,9,21.5);
            }
        }
        //----------------------------------
        translate([10,0,0])
        translate([0,-10.5,5]) 
        rotate([90,0,0])
        m5_screw();

        // Inner
        translate([-2.5,-11,0]) 
        scube(22,25,9.5);

        // chamfer
        translate([-2.5, 7,-t*2]) 
        rotate([42,0,0])
        scube(22,25,t);
        
        // screw
        translate([9.75,0,-10]) 
        cylinder(d=3.5,h=30); 
    }
}    
module front_support(pz=0){
    // frame support
    translate([20,-dy+5, 0]){
        difference(){
            union(){ 
                //front
                translate([-20,-5-20-t,-22.5]) 
                scube(20,t,76);

                //side
                difference(){
                    translate([0,-5-20-t,-22.5]) 
                    scube(t,20+t,76);
                        
                    // Fillet
                    translate([t+.1,-5-20-t-.1,60])
                    rotate([-90,0,90])
                    fillet(t,100);
                }

            }
            //=================
            // frame
            translate([-20,-5-20,pz-t*2]) 
            scube(40,21,22+t*2);
           
             // screws
            translate([-10,-30,-14])
            rotate([90,0,0])
            Mscrew(l=10, d=5.5);
            translate([-10,-30,44])
            rotate([90,0,0])
            Mscrew(l=10, d=5.5);
            
            // top
            m5d=5.6;
            m5head=10.6;
            hull(){
                translate([-2,-15,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5d);
                translate([-2,-5,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5d);
            }
            hull(){
                translate([t-2,-15,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5head);
                translate([t-2,-5,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5head);
            }
        }
    }
    /**/
    translate([20,-dy+5,pz]){
        difference(){
            union(){ 
                translate([-t,-5-20-t,-t*2]) 
                vrcube(19.5+t*2,20+t,22+t*2, t);
            }
            //=================
             // front screw
            translate([-10,-30,-14-pz+.75])
            rotate([90,0,0])
            Mscrew(l=10, d=5.5);
            
            // frame
            translate([-20,-5-20,-27.25]) 
            scube(20,21,80);


            translate([-t-.1,-5-20,-t-.25]) 
            scube(19.5+t,20+t,22);


            // center mark
            for(i=[0:5]){
                translate([t+.1,-18.25-i,21.4]) 
                scube(9,.5,5);
            }
            
            translate([10,-10.5,5]) 
            rotate([90,0,0])
            m5_screw();
    
             // screws
            translate([-10,-30,-18])
            rotate([90,0,0])
            Mscrew(l=10, d=5.5);
            translate([-10,-30,44])
            rotate([90,0,0])
            Mscrew(l=10, d=5.5);
            
            // top
            m5d=5.6;
            m5head=10.6;
            hull(){
                translate([-2,-15,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5d);
                translate([-2,-5,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5d);
            }
            hull(){
                translate([t-2,-15,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5head);
                translate([t-2,-5,44])
                rotate([0,90,0])
                cylinder(h=10, d=m5head);
            }
            
            // bottom
            hull(){
                translate([-2,-15,-18])
                rotate([0,90,0])
                cylinder(h=10, d=m5d);
                translate([-2,-15,-27])
                rotate([0,90,0])
                cylinder(h=10, d=m5d);
            }
            hull(){
                translate([t-2,-15,-18])
                rotate([0,90,0])
                cylinder(h=10, d=m5head);
                translate([t-2,-15,-27])
                rotate([0,90,0])
                cylinder(h=10, d=m5head);
            }
            
            // slot
            translate([10-t/2,-5-20,-15]) 
            rcube(t,20-t,40,t/2);
        }
    }
    /**/
}

/**/    
/* Belt Path */
/*************/
module belt_path(){
    translate([0,0,0]){
        /* Front Idler *
        translate([29,-dy+5,0]){
            //translate([0,0,-9.5])     //Left
            %idler_pulley("top","teeth");
            difference(){
                union(){
                //translate([0,0,-9.5]) //Left
                }
                /*=================*
                // Cut
                translate([-19,-30,-60])
                scube(10,50,120);
                
                translate([0,0,-9.5])
                union(){
                    translate([0,0,9+t]) 
                    Mscrew(25);
                    translate([0,0,-11-t]) 
                    rotate([0,0,30])
                    Mnut(25);
                }
            }
        }
        
        /*Back Idler */
        translate([26+14.5,dy+10,0]){
            translate([0,0,0]) 
            idler_pulley("top");
            translate([0,0,0]) 
            idler_pulley("bottom","teeth");

            difference(){
                union(){
                    translate([0,0,9.5]) 
                    cylinder(d=19,h=t);
                    translate([0,0,-9.5-t]) 
                    cylinder(d=19,h=t);
                }
                /*=================*/
                translate([0,0,9+t]) 
                Mscrew(35);
                translate([0,0,-21-t]) 
                Mnut(30);
            }
        }
        /**/
    //translate([24.8,-dy+23.5,2.6]) motor_support();
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
    d=dax;
    translate([15,0,0]){
        // Front
        color("silver") 
        translate([0,-d,-d]) 
        rotate([0, 90, 0]) 
        cylinder(220,4,4);
        // Back
        color("silver") 
        translate([0, d, d]) 
        rotate([0, 90, 0]) 
        cylinder(220,4,4);
    }    
}


module pulley(){
    /* Idler */
    translate([0,-6.6, belt_distance/2-1.25]) 
    %gt2_idler();
    /**/
    translate([-.5, 6.2, -belt_distance/2-7.25]) 
    %gt2_idler("teeth");    
}    

module references(){
    //translate([-20, -0.75, -20]) #scube(50, 1.5, 50);

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
    
module xy_joiner(m=0){ 
    /* Y Carriage */
    translate([-15,0,0])
    difference(){            
        union(){            
            // Front axis
            hull(){
                translate([12.5,-dax,-dax])
                rotate([0,90,0])
                cylinder(d=13, h=10);
                    
                translate([9,-dax,-dax])
                sphere(13/2);
                
                translate([9-13/2, 6, -2])
                rotate([0,90,0])
                cylinder(d=24, h=depth);
            }
            // Back
            hull(){
                translate([12.5,dax,dax])
                rotate([0,90,0])
                cylinder(d=13, h=10);

                translate([9,dax,dax])
                sphere(13/2);

                translate([9-13/2, -6, 2])
                rotate([0,90,0])
                cylinder(d=24, h=depth);
            }

            /* body */
            translate([2.5,-w/2,-h/2])
            rcube(depth,w,h, 2);

            /* bush holder */
            hull(){
                translate([2.5,-w/2,-h/2])
                rcube(depth/2,w, 4.5+2, .5);
                
                translate([-2.5,-ybush_len/2+2,-24])
                rotate([-90,0,0])
                cylinder(d=bush_width+t, h=ybush_len-4);
            }
            
            /* spacers */
            translate([15,-6.6, 0.55])
            %cylinder(d=5, h=.6);
            translate([15,-6.6, 9.82])
            %cylinder(d=5, h=.6);

            translate([15,6.6, -1.15])
            %cylinder(d=5, h=.6);
            translate([15,6.6, -10.42])
            %cylinder(d=5, h=.6);
            /**/
        }
        
        //----------------------------------
        if(m==1){
            mirror([0,0,1])
            xy_space();
            
            mirror([0,0,1])
            mirror([0,1,0])
            bearing_fixing();
        }else{
            xy_space();
            bearing_fixing();
        }
        
        translate([-.1,0,0]) axis_x();

        // bush
        translate([-2.5,-ybush_len/2-10,-24])
        rotate([-90,0,0])
        cylinder(d=bush_width, h=ybush_len+20);
               
        translate([-20,-30,-50])
        cube([50,60,20]);

        translate([-4,-30,-50])
        cube([2,60,25]);
    }
}

module yclamp(){
    difference(){
        union(){
            /**/
            hull(){
                
                translate([-l/2+13, -w/4, -14.5])
                cube([1, w/2, 10]);
               
                difference(){
                    translate([-l/2-axis_diam/2,w/4,0]) 
                    rotate([90, 0, 0]) 
                    cylinder(h=w/2, d=bush_width+thick*3);

                   
                    translate([-l, axis_distance/2, -axis_diam-1.7])
                    rotate([180,0,0])
                    rcube(l, axis_distance, axis_diam,r);
                    
                /**/
                    translate([-l/2-axis_diam/2-9,0,-axis_diam/2]) 
                    cube([30,car_width,axis_diam*5],center=true);
                    
                }
/*
                translate([-l+22,0,-10])
                rotate([0,-90,0])
              #  cylinder(d=4, h=2);
  /**/             
            }
            
            /**/
            difference(){
            hull(){
                translate([-l+28,0,-10])
                rotate([0,-90,0])
                cylinder(d=10, h=20);
       
                translate([-l/2-axis_diam/2, 0, 3])
                rotate([180,0,0])
                rccube(bush_width+thick_min,40, h-6,r);
                
                
             
                difference(){
                    translate([-l/2-axis_diam/2,20,0]) 
                    rotate([90, 0, 0]) 
                    cylinder(h=40, d=bush_width+thick*2.5);

                    translate([-l, axis_distance/2, -axis_diam-2.5])
                    rotate([180,0,0])
                    rcube(l, axis_distance, axis_diam,r);
                }
            }  

                translate([-l/2+5.5, 0, -h/2-1]) 
                rotate([0,70,0])
                cube([5,w,15],center=true);        
            
            }
            /**/  
        }
    
        /* Y Bushing */
        translate([-l/2-axis_diam/2,w+.1,0]) 
        rotate([90, 0, 0]) 
        cylinder(h=car_width, d=bush_width);

        translate([-l/2-axis_diam/2,0,-axis_diam]) 
        cube([6,car_width,axis_diam*2],center=true);        

        translate([-l/2+4, 0, -h/2-2]) 
        rotate([0,40,0])
        cube([6,6.5,8],center=true);        
        
        translate([-l+10,0,-10])
        rotate([0,-90,0])
        Mscrew(22);
        
        translate([-l/2+4,0,-10])
        rotate([180,0,0])
        rotate([90,0,90])
        MnutPocket();
        /**/
    }
}    

module bearing_fixing(){
     /* Bearing screws */
    translate([15,-6.6,-10])
    rotate([180,0,0])
    Mscrew(25);            
    translate([14.5,6.25,10])
    rotate([0,0,0])
    Mscrew(25);
    
    /* Bearing Nut */        
    translate([15,-6.6,12])
    rotate([0,0,180])
    Mnut(l=20);
    translate([14.5,6.25,-32])
    Mnut(l=20, b=0);    
    /**/
}    

module xy_space(){
    /*  bearings */
    translate([6.5-6,-16.6,belt_distance/2-2]) 
    rcube(27.5,20,10,5);   
    translate([0,-4, -10-belt_distance/2+2]) 
    rcube(26,20.5,10,5);

    /*  x belts */
    translate([15,-3,belt_distance/2-2]) 
    rcube(30,6,10,1);
    translate([10,-3.5,-belt_distance/2-10+2]) 
    rcube(30, 6.9, 10,1);

    /* y belts */
    translate([6.5,-40, belt_distance/2-2]) 
    rcube(6.5,30,10,1);    
    translate([6.5, 0, -belt_distance/2-belt_size-2]) 
    rcube(6.5,30,10,1);
}

/**********************************************/

/***** YFix *****
module yfix(){
    difference(){

        hull(){
            translate([-18,-10,0])
            rcube(36,20,5,2);

            translate([-5,-7,12])
            rcube(10,14,1,2);
        }
        // axis
        translate([0,-15,4]){
            rotate([-90,0,0])
            cylinder(d=8.5,h=30);
            
            translate([-4.25,0,-10])
            cube([8.5,30,10]);
        }
        
        // screws
        translate([11,0,11])
        rotate([180,0,0])
        Mscrew(10,5.5,10);

        translate([-11,0,11])
        rotate([180,0,0])
        Mscrew(10,5.5,10);
    }
}    



/***** ZFix *****/
module zfix(){
    rod=12;
    d=rod+.5;
    x=rod*4;
    
    difference(){
        hull(){
            translate([-x/2,-10,0])
            rcube(x,20,5,2);

            translate([-rod/2-rod/6,-7,rod+4])
            rcube(rod+rod/3,14,1,2);
        }
        
        
        // axis
        translate([0,15,rod/2-1 ]){
            vcylinder(d=d,h=30);
            
            translate([-d/2,-30,-10])
            scube(d,30,10);
        }

        // screws
        translate([rod*1.25,0,4])
        Mscrew(10,5.5);

        translate([-rod*1.25,0,4])
        Mscrew(10,5.5);
    }
}    

module yfix2(){
    axis_totop = 33.25 + 20; // from top
    axis_tobottom = 26;
    h =12;
    r=2;
    ch=5.8;
    b=true;

    translate([0,10,-.5])
    difference(){
        union(){
            hull(){
                translate([-axis_tobottom,-10,0])
                rcube(axis_tobottom+axis_totop,20,5,r);

                translate([-axis_tobottom+5,-10,h])
                rcube(axis_tobottom+axis_totop-5,20,.001,r);
            }
            //top
            translate([axis_totop-20, 0, 0])
            rcube(20, 40,h,r);
            
            // Chanel fixer
            translate([axis_totop-25,-ch/2,-4])
            cube([20,ch,4]);
            translate([axis_totop-10-ch/2,12,-4])
            cube([ch,10,4]);
            
            //
            translate([axis_totop-20,10,0])
            rotate([90,0,180,])
            fillet(28,h);
        }
        
        // bottom cut
        translate([-axis_tobottom-.1,-15,-.1])
        cube([axis_tobottom+4,30,2.5]);

        // axis
        translate([0,-15,8.5/2])
        rotate([-90,0,0])
        cylinder(d=8.5,h=30);
            
        // screws
        translate([-15,0,5])
        Mscrew(10,5.5,b);
        translate([15,0,5])
        Mscrew(10,5.5,b);
        translate([axis_totop-10,30,5])
        Mscrew(10,5.5,b);
        
        // zip ties
        translate([-16.5,-28,0])
        rotate([-45,0,0])
        cube([3,6,30]);

        translate([-16.5,19,0])
        rotate([45,0,0])
        cube([3,6,30]);
        /**/
    }
}    

