include <config.scad>
use <../lib.scad>
use <parts.scad>
$fn= 100;

/*
translate([50,-43,0])

rotate([180,0,0])
translate([-100,-150,0])

/**/

l=42.5;
w=40;
h=29;
r=1;

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

/*
rotate([0,180,0])
mirror([1,0,0])
yfix2();
/**/
*zfix();
*references();


/* Left */
fatia = 100;
// translate([0,0,h/2])  rotate([180,0,0]) 
difference(){
    {
        xy_joiner();
        %pulley();
    }
    echo(h/2-firstlayer-(fatia-1)*lineHeight);
   
    translate([-l,-w*1.5,h/2-firstlayer-(fatia-1)*lineHeight-50])
    cube([l*2,w*3, 50]);
}

/* Right *
fatia = 100;
// translate([0,0,h/2])  rotate([180,0,0]) 
difference(){
    rotate([0,0,180])
    {
        xy_joiner(1);

        mirror([0,0,1])
        mirror([0,1,0])
        %pulley();
    }
    echo(h/2-firstlayer-(fatia-1)*lineHeight);
   
    translate([-l,-w*1.5,h/2-firstlayer-(fatia-1)*lineHeight-50])
    cube([l*2,w*3, 50]);
}
/**/
//=============================================
module pulley(){
    /* Idler */
    translate([16+.75,-6.75, .5]) 
    %gt2_idler();
    /**/
    translate([9, 6, -9.5]) 
    %gt2_teeth();    
}    

module sacrifice_bridge(m){
    /* Sacrifice Bridges */
    translate([5.5,-w/2,-10.38])  cube([25.25, w, lineHeight]);
    
    /* Right */
    if(m==1){   
        translate([-9.3, -w/2, -0.14]) cube([40, w, lineHeight]);
      //  translate([6, -w/2, -10.06])  cube([4.35+14, w, lineHeight]); 
        
        difference(){            
           union(){
                // nut
                translate([7,-7,12.75])
                cylinder(d=10,h=lineHeight);
                // screw
                translate([16,7,8])
                cylinder(d=10,h=lineHeight);
            }
        
            xy_space();  
        }
    }
    
    /* Left */
    else{          
        translate([14.75-9, -20, -.14]) cube([25, w,lineHeight]);
        
        difference(){            
           union(){
                // nut
                translate([17,-7,12.75])
                cylinder(d=10,h=lineHeight);
                // screw
                translate([8,7,8])
                cylinder(d=10,h=lineHeight);
            }
        
            xy_space();  
        }
    }    
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
    yclamp();
    
    sacrifice_bridge(m);
    
    // X fixing support
    difference(){
        union(){
            translate([14.76,-38.6, -0.98]) 
            support(axis_diam*2, 7, axis_diam/3+0.15-lineHeight*2,  supportWidth, 1);
            /**/
            mirror([0,1,0])
            translate([14.76,-38.6, -0.98]) 
            support(axis_diam*2, 7, axis_diam/3+0.15-lineHeight*2,  supportWidth, 1);
            /**/
        }
        
        
        /* side chamfer */
        translate([l/4-2,-axis_distance/2-39,-h/2-.1])
        rotate([0,0,40])
        rcube(25,30,h+1,r);
        /**/
        mirror([0,1,0])
        translate([l/4-2,-axis_distance/2-39,-h/2-.1])
        rotate([0,0,40])
        rcube(25,30,h+1,r);
        /**/
    }
    /* Fillets */
    translate([l/2+9.5,-axis_distance/2+1,-h/4-3.25])
    rotate([-180,0,-90])  
    fillet(s=4, t=16);
    /**/
    mirror([0,1,0])
    translate([l/2+9.5,-axis_distance/2+1,-h/4-3.25])
    rotate([-180,0,-90])  
    fillet(s=4, t=16);
    /**/
    
    /* Y Carriage */
    difference(){            
        union(){
            /* top */
            translate([2.5,0,h/2-2.5])
            rotate([180,0,0])
            rccube(l+5,w,5,r);            
            // body
            rotate([180,0,0]) 
            rccube(l,w,h,r);
            // front
            translate([l/2+1+.5,0,0])
            rotate([180,0,0])
            rccube(15+1,axis_distance+22, h,r);
            // back
            hull(){
                translate([-l/2-axis_diam/2,0, 0])
                rotate([180,0,0])
                rccube(bush_width+thick_min,40, h,r);
                translate([-l/2-axis_diam/2,20,0]) 
                rotate([90, 0, 0]) 
                cylinder(h=40, d=bush_width+thick*2.5);
            }
            
        /* top axis fix *
        translate([15, 5, 9])
        rcube(15.75, 15, h,.1);
        /**/    
        }
/*************************************************/
        translate([-l/2+4,0,-10])
        rotate([180,0,0])
        rotate([90,0,90])
        MnutPocket();
        
        /* back cut *
        translate([20,30, 0])
        rccube(l, 20, h+10,.1);
        
        /* front reccess */
        translate([35,0, 0])
        rccube(l/2, 10, h-6,.5);

        if(m==1){
            rotate([180,0,0])
            xy_space();
            
            mirror([0,0,1])
            mirror([0,1,0])
            bearing_fixing();
        }else{
            xy_space();
            bearing_fixing();
        }
        
       // translate([-30,0,0]) axis_x();


        /* bottom chamfer front */
        translate([l/4,-axis_distance/2-40,-h/2-.1])
        rcube(25,41,4,r);
        mirror([0,1,0])
        translate([l/4,-axis_distance/2-40,-h/2-.1])
        rcube(25,41,4,r);

        /* side chamfer */
        translate([l/4-2,-axis_distance/2-39,-h/2-.1])
        rotate([0,0,40])
        rcube(25,30,h+1,r);
        mirror([0,1,0])
        translate([l/4-2,-axis_distance/2-39,-h/2-.1])
        rotate([0,0,40])
        rcube(25,30,h+1,r);

        /* X axis fixing */                
        translate([l/2,-33, 0.025]) 
        cube([axis_diam*3, axis_diam*2, axis_diam/3+0.15],center=true);
        
        translate([l/2,33,  0.025]) 
        cube([axis_diam*3, axis_diam*2, axis_diam/3+0.15],center=true);

        /* Y Bushing */
        translate([-l/2-axis_diam/2,w+.1,0]) 
        rotate([90, 0, 0]) 
        cylinder(h=car_width, d=bush_width);

        translate([-l/2-axis_diam/2,0,-axis_diam]) 
        cube([6,car_width,axis_diam*2],center=true);
        
        /**/
        translate([-l/2-3,0,-12]) 
        cube([32,car_width,10],center=true);
        
        translate([-l/2-4,0,-10])
        rotate([0,-90,0])
        cylinder(d=6.6,h=20);
        
        /* X axis screw */
        translate([0,0,0]){
            translate([l/2+1.5,-car_width/2+4,h/2-7])
            Mscrew(20,b=true);
            translate([l/2+1.5,-car_width/2+4, -h/2+2])
            Mnut(l=3, b=0);
        }
        /**/
        mirror([0,1,0]){
            translate([l/2+1.5,-car_width/2+4,h/2-7])
            Mscrew(10,b=true);
            translate([l/2+1.5,-car_width/2+4, -h/2+2])
            Mnut(l=3, b=0);
        }
    /**/
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
    translate([16+.75,-6.75,-h/2+7])
    rotate([180,0,0])
    Mscrew(20);            
    translate([9,6,h/2-7])
    rotate([0,0,0])
    Mscrew(25);
    
    /* Bearing Nut */        
    translate([16+.75,-6.75,13])
    rotate([0,0,180])
    Mnut(0);
    translate([9,6,-15.5])
    Mnut(l=3, b=0);    
    /**/
}    

module xy_space(){
    /*  bearings */
    translate([6.5,-16.6,0]) 
    rcube(27.5,20,10.5,5);
    
    echo(-belt_distance/2-belt_size-1.8);
    translate([0,-4, -belt_distance/2-belt_size-2]) 
    rcube(33,20.6,10.5,5);

    /*  x belts */
    translate([15,-3,belt_distance/2-2]) rcube(30,6,10,1);
    translate([10,-3.5,-belt_distance/2-belt_size-1.5]) rcube(30, 6.9, 10,1);

    /* y belts */
    translate([6.5,-40, belt_distance/2-2]) 
    rcube(6.5,30,10,1);
    
    translate([-6.5,-40,-10.38]) 
    rcube(8,80,20,1);    
    translate([-7.5+4,-40,-10.38]) 
    rotate([0,0,-4])
    rcube(5,80,20,1);
    /**/
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

