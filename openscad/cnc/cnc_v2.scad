$fn=200;
fit=.3;
/*
Ideias

- Caixa de redução para nema17 (aumenta o torque)
- Painel de acabamento frontal
- reforço diagonal do eixo Z
- adaptador para aspirador de pó
- batente para proteger o rolamento do motor

*/
xw=20;  // Profile width X
yw=40;
zw=40;

bx=300; // Bed X
by=240; // Bed Y
clear=80; // clearance

zhp=clear+110;
dx=10;
dz=110;     // Height X axis

x=350;  // Frame X
y=400;
z=zhp+dz+10+20;
ref=400-z;

zp=y/2+119; // Z axis position
zh=150;
    
t=10;
xpos= x/2-40; //x-80+7;  //-4;
ypos = -40; //by-40; // -40;

f=50;

// height
*hull(){
    translate([-32-f/2,y/2,0])
    cube([390+80+f,by+10+f/2,z+145+f/2]);
    translate([-32-f/2,-42-f/2,0])
    cube([390+80+f,490+f,zhp]);
}

echo("Z:",z);
echo("Ref:",ref);
echo( "X:",(390+80+f), "Y:",(490+f) );
echo( "Zf:",(zhp), "Zb:",(z+145+f/2) );
echo("Yp:",by+10+f/2);


ysl=x/4;
ysr=x/4*3;

md=55;  // motor diameter
ml=164; // motor length
rl=46;  // rotor length

sd=70;      // z axis distance
sl=40-sd/2;
sr=80-sl;

zcd=54;

cAlu=[1,1,1];
cSte=[0.8,0.8,0.8];
/*
c3dp=[0.5,0.5,0.5];
c3dp=[0.7,0.7,0.7];
c3dp=[0.2,0.2,0.2];
c3dp=[0.1,0.1,0.1];
c3dp=[0,0,1];   // blue
/**/
c3dp=[0,0.8,0.8];

dn=32;  // distance of y motion tnuts

//-------------------------------------    
/**
corners();
color(cAlu) frame();
/**
translate([0,0,20]) x_motion();
color(cSte) translate([0,0,20]) x_axis(xpos);
/**
color(cSte) y_axis();
translate([0,-35,0]) y_motion();
translate([0,ypos,0]) bed();
/**/
translate([xpos, zp-zcd, zhp-35+20]) carriage();


*zTop();
*zBottom();

*translate([xpos, zp-zcd, zhp-35+20]) 
zBack();
//-------------------------------------
//corner(t=5,w=20,lx=20,lz=20)
//corner(8,40,43.5,40); //4
//corner(8,40,30,20);  //10 
//corner(8,20,30,20);  // 4
//corner(8,20,30,30);  // 4
//x_motor_support();
        
module corners(){
    /* upper
    translate([-20,zp,zhp+dz+30])
    hull(){
        rcube(20,40,5);
        translate([20,0,0])
        rcube(40,20,5);
    }
    translate([x,zp,zhp+dz+30])
    hull(){
        rcube(20,40,5);
        translate([-30,0,0])
        rcube(40,20,5);
    }
    /**/
    // z upper
    translate([0,zp+20,zhp+30])
    rotate([-90,0,0])
    corner(8,40,30,20);
    translate([x,zp+20,zhp-10])
    rotate([-90,180,0])
    corner(8,40,30,20);
    
    translate([0,0,dz]){
        translate([0,zp+20,zhp+30])
        rotate([-90,0,0])
        corner(8,40,30,20);
        translate([x,zp+20,zhp-10])
        rotate([-90,180,0])
        corner(8,40,30,20);
    }
    
    /*translate([0,zp+20,zhp+dz-10])
    rotate([180,0,0])
    corner(8,20,30);
    /**/
    
    translate([0,zp+20,zhp-10])
    rotate([180,0,0])
    corner(8,20,30,30);
    translate([0,zp,zhp-10+40])
    corner(8,20,30,30);
    
    translate([x,0,0])
    mirror([1,0,0]){
        /*translate([0,zp+20,zhp+dz-10])
        rotate([180,0,0])
        corner(8,20,30);
        /**/
        translate([0,zp+20,zhp-10])
        rotate([180,0,0])
        corner(8,20,30,30);
        translate([0,zp,zhp-10+40])
        corner(8,20,30,30);
    }
    
    // z
    translate([0,zp,20+40])
    corner(8,40,20,30);
    translate([x,zp+40,20+40])
    rotate([0,0,180])
    corner(8,40,20,30);
    
    // xz
    translate([0,zp,20])
    rotate([90,0,-90])
    corner(8,40,30);
    
    translate([x,0,0])
    mirror([1,0,0]){
        translate([0,zp,20])
        rotate([90,0,-90])
        corner(8,40,30);
    }
    translate([0,zp+40,20+40])
    rotate([-90,0,90])
    corner(8,40,30);
    
    translate([x,0,0])
    mirror([1,0,0]){
        translate([0,zp+40,20+40])
        rotate([-90,0,90])
        corner(8,40,30);
    }

    // bottom
    translate([0,40,20])
    rotate([180,0,90])
    corner(8,20,30);
    translate([x,40,20])
    mirror([1,0,0])
    rotate([180,0,90])
    corner(8,20,30);
    
    translate([0,y,0])
    mirror([0,1,0]){
        translate([0,40,20])
        rotate([180,0,90])
        corner(8,20,30);
        translate([x,40,20])
        mirror([1,0,0])
        rotate([180,0,90])
        corner(8,20,30);
    }

    // front & back
    translate([20,0,20])
    corner(8,40,43.5,40);
    translate([x-20,0,20])
    mirror([1,0,0])
    corner(8,40,43.5,40);

    translate([0,y-40,0]){
        translate([20,0,20])
        corner(8,40,43.5,40);
        translate([x-20,0,20])
        mirror([1,0,0])
        corner(8,40,43.5,40);
    }
}

module corner(t=5,w=20,lx=20,lz=20){
    vt=4.5;
    color("lightgrey")
    difference(){
        union(){
            cube([lx,w,t]);
            cube([t,w,lz]);
            for ( i = [0 : 20 : w-1] ){
                translate([0,i,0])
                hull(){
                    cube([lx,vt,t]);
                    cube([t,vt,lz]);
                }
                translate([0,20-vt+i,0])
                hull(){
                    cube([lx,vt,t]);
                    cube([t,vt,lz]);
                }
            }
        }
        //--------------------------------
        for ( i = [10 : 20 : w] ){
            translate([(lx-t)/2+t,i,5])
            Mscrew(20,5.4,v=1);
            
            if(lz == 20){
                translate([5,i,lz/2])
                rotate([0,90,0])
                Mscrew(20,5.4,v=1);
            }else{
                translate([5,i,(lz-t)/2+t])
                rotate([0,90,0])
                Mscrew(20,5.4,v=1);
            }
        }        
    }
}

//========================================
//      3D Printed 
//========================================
module zTop(){
    bt=10;
    // Bridges
    #translate([0,-42,zh+15+46+3])
    rcube(80,45,.2,10);

    // top
    color(c3dp)
    difference(){
        union(){
            translate([0,0,zh-bt])
            cube([10,38,40]);
            translate([70,0,zh-bt])
            cube([10,38,40]);
            // top
            translate([-5,-42,zh+15+46+3])
            rcube(90,45,12,10);
            // left
            *hull(){
            translate([16-10,-42+16,zh+15])
            cylinder(d=32, h=15+46);

            translate([-7,-42,zh+15])
            rcube(20,45,15+46,10);
            }
            // right
            *translate([65,-42,zh+15])
            rcube(20,45,15+46,10);
            // bottom
            translate([0,0,zh+15])
            hull(){
                // front
                translate([-10,-42,0])
                rcube(sd+30,40,15,16);

                translate([10,38-9.52*2,0])
                cube([60,9.52*2,15]);
            }
        }
        //------------------------
        translate([40,-20, zh+12])
        cylinder(d=14, h=20);

        translate([40,-20, zh+7])
        cylinder(d=22+fit, h=10);

        translate([40,-20, zh+30-6.9])
        608zz(fit);        

        // motor
        translate([40,-20,zh+30.1+46+3])
        rotate([0,180,0])
        nema17_holes(50);
        
        // shafts
        translate([sl,-20,50+1])
        cylinder(d=12+fit, h=zh);
        translate([sr,-20,50+1])
        cylinder(d=12+fit, h=zh);
        
        // bolts M6
        translate([0,10,zh+20]){
            translate([20,0,0])
            Mscrew(20,6.3);
            translate([40,0,0])
            Mscrew(20,6.3);
            translate([60,0,0])
            Mscrew(20,6.3);
        }
        // bolts M5
        translate([5,10,zh+2])
        rotate([90,0,0])
        rotate([0,-90,0])
        Mscrew(20,5.3,v=1);
        translate([80-5,10,zh+2])
        rotate([90,0,0])
        rotate([0,90,0])
        Mscrew(20,5.3,v=1);
    }
}
module zBottom(){
    bt=3;
    
    color(c3dp)
    difference(){
        union(){
            translate([0,0,-bt])
            cube([10,38,40]);
            translate([70,0,-bt])
            cube([10,38,40]);
            hull(){
                translate([-10,-36,-bt])
                rcube(sd+30,35,15+bt,16);

                translate([10,38-9.52*2,-bt])
                cube([60,9.52*2,15+bt]);
            }
        }
        //-------------------------
        translate([40,-20, 0])
        cylinder(d=14, h=20);

        translate([40,-20, 15-6.9])
        608zz(fit);        

        // shafts
        translate([sl,-20,-1])
        cylinder(d=12+fit, h=zh);
        translate([sr,-20,-1])
        cylinder(d=12+fit, h=zh);

        // bolts M6
        translate([0,10,5])
        rotate([180,0,0]){
            translate([20,0,0])
            Mscrew(20,6.3,1);
            translate([40,0,0])
            Mscrew(20,6.3,1);
            translate([60,0,0])
            Mscrew(20,6.3,1);
        }

        // bolts M5
        translate([5,10,25])
        rotate([90,0,0])
        rotate([0,-90,0])
        Mscrew(20,5.3,v=1);
        translate([80-5,10,25])
        rotate([90,0,0])
        rotate([0,90,0])
        Mscrew(20,5.3,v=1);
    }
}
module zBack(){
    thick=9.52;
    
    translate([(80-30.5)/2+.25, 28, zh/2-2])
    T8_sup();
    
    color(c3dp)
    difference(){
        union(){
            translate([10+fit/2,38-(thick*2),15+fit/2])
            cube([60-fit,thick,zh-fit]);
            /* lateral 
            translate([10,20,15])
            cube([10-fit,thick,zh-fit]);
            translate([60+fit,20,15])
            cube([10-fit,thick,zh-fit]);
            /**/
            // block
            translate([10+fit/2,38-thick,14.8+zh-40.6])
            cube([60-fit,thick,40.6]);
            translate([10.1,38-thick,15+fit/2])
            cube([60-fit,thick,40.6]);
            /**/
        }
        
        //----------------------
        translate([20, 28, zh/2-19.4])
        cube([40,28,68.8]);
        // Tnut support screws
        translate([(80-18)/2, 19+4, zh/2+3])
        rotate([90,0,0]){
            Mscrew(10,4.2,1);
            translate([18,0,0])
            Mscrew(10,4.2,1);
            translate([18,24,0])
            Mscrew(10,4.2,1);
            translate([0,24,0])
            Mscrew(10,4.2,1);
        }        
        // back bolts
        translate([-20,20+5,zh/2-14])
        rotate([-90,0,0]){
            translate([40,0,0])
            Mscrew(20,5.3);
            translate([40,-58,0])
            Mscrew(20,5.3);
        }       
        translate([0,20+5,zh/2-14])
        rotate([-90,0,0]){
            translate([40,0,0])
            Mscrew(20,5.3);
            translate([40,-58,0])
            Mscrew(20,5.3);
        }       
        translate([20,20+5,zh/2-14])
        rotate([-90,0,0]){
            translate([40,0,0])
            Mscrew(20,5.3);
            translate([40,-58,0])
            Mscrew(20,5.3);
        }       
       
        // rail bolts upper
        translate([39.5-12.5,30-5,132.5])
        rotate([90,0,0]){
            translate([0,0,0])
            Mscrew(20,3.2,1);
            translate([25,0,0])
            Mscrew(20,3.2,1);
        }
        translate([39.5-12.5,30-5,132.5+25])
        rotate([90,0,0]){
            translate([0,0,0])
            Mscrew(20,3.2,1);
            translate([25,0,0])
            Mscrew(20,3.2,1);
        }
        // rail bolts lower
        translate([39.5-12.5,30-5,22.5])
        rotate([90,0,0]){
            translate([0,0,0])
            Mscrew(20,3.2,1);
            translate([25,0,0])
            Mscrew(20,3.2,1);
        }
        translate([39.5-12.5,30-5,22.5+25])
        rotate([90,0,0]){
            translate([0,0,0])
            Mscrew(20,3.2,1);
            translate([25,0,0])
            Mscrew(20,3.2,1);
        }

    }
}
module bearingSupport(){
    // Bearings
    %translate([0,0,0]){
        translate([0,-2,8.1])
        608zz();
        translate([0,-2,-5])
        608zz();
        
        translate([0,-2,-5-8])
        cylinder(d=14, h=8);
    }
    
    // Sacrifice Bridge
    #translate([0,-2, 2])
    cylinder(d=20,h=.4);

    color(c3dp)
    difference(){
        union(){
            hull(){
                cylinder(d=30, h=15);
                
                translate([15,dx,0])
                mirror([1,0,0])
                rcube(40,40-.1,15);
            }
        }
        //-------------------        
        translate([0,-2,-.1])
        cylinder(d=14, h=15+1);

        translate([0,-2,7.5])
        cylinder(d=22, h=10);

        translate([0,-2,-7+2])
        608zz();
        
        // Chamfer
        translate([-30,10,5])
        cube([50,50,20]);
        
        // Bolts
        translate([-25+10,dx+10+20,0.1])
        rotate([0,180,0])
        Mscrew(20,5,0);

        translate([-25+30,dx+10,0.1])
        rotate([0,180,0])
        Mscrew(20,5,0);
    }
}
module spindleSupport(){   
    color(c3dp)
    difference(){
        union(){
            // bearings support
            translate([sl,-20,15.1])
            cylinder(d=21+12, h=60);
            
            translate([sr,-20,15.1])
            cylinder(d=21+12, h=60);

            difference(){
                hull(){
                    translate([sl,-20,15.1])
                    cylinder(d=21+12, h=60);
                    
                    translate([sr,-20,15.1])
                    cylinder(d=21+12, h=60);

                    translate([40,-73,15])
                    cylinder(d=md+16, h=30*2);
                }
                //------------------------
                translate([-20,-20,10])
                cube([120,18,70]);
            }
            
            // Clamp
            translate([60,-73-15,15])
            cube([30,25,60]);
        }
        //---------------------------
        // clamp cut
        translate([60,-73-5,14])
        cube([35,5,70]);

        // bearings
        translate([sl,-20,0])
        cylinder(d=21+fit, h=80);
        translate([sr,-20,0])
        cylinder(d=21+fit, h=80);

        // T8 cut
        translate([21,-26,10])
        cube([38,25,70]);
        
        // tnut bolts
        translate([29.5,-26-7,37.5])
        rotate([0,90,0])        
        rotate([90,0,0]){
            translate([0,0,0])
            Mscrew(20,5.3);
            translate([0,21,0])
            Mscrew(20,5.3);
        }

        // clamp bolts
        translate([80,-73-15+5,15+15])
        rotate([90,0,0]){
            translate([0,0,0])
            Mscrew(20,5.3);
            translate([0,30,0])
            Mscrew(20,5.3);
        }
        // clamp nuts
        translate([80,-63-5,15+15])
        rotate([-90,0,0])
        {
            translate([0,0,0])
            nut(l=20,di=5);
            translate([0,-30,0])
            nut(l=20,di=5);
        }

        // Spindle
        translate([40,-73,-35])
        translate([0,0,rl])
        cylinder(d=md, h=ml-rl);
    }    
    
    // T8
    color("black")
    translate([22.75,-27,63])
    translate([34.75,0,-35])
    rotate([0,-90,0])
    import("stl/Anti-Backlash_Nut_Printable.stl");
}
/* Bed bearing support */
module bedSupport(){
    color(c3dp)
    difference(){
        union(){
            rotate([-90,0,0])
            bedBearingSupport();

            w=90;
            hull(){
                translate([-w/2,10,15])
                rcube(w,100,10,10);
                translate([-w/2+15,0,15])
                cube([w-30,120,10]);
            }
            
            translate([0,83,0])
            rotate([-90,0,0])
            bedBearingSupport();
        }
        //--------------------------------
        translate([-1,-.1,-30])
        cube([2,121,30]);

        translate([-25,40,5])
        rcube(50,40,30, 10);

        // Bolts
        translate([-35,20,20])
        rotate([180,0,0]){
            Mscrew(10,5.3);
            
            translate([0,-80,0])
            Mscrew(10,5.3);
        }
        translate([35,20,20])
        rotate([180,0,0]){
            Mscrew(10,5.3);
            
            translate([0,-80,0])
            Mscrew(10,5.3);
        }
    }
}    
module bedBearingSupport(){
    id=28;
    od=id+t*2;
    h=37;
    w=60;
    difference(){
        hull(){
            cylinder(d=od, h=h);
            
            translate([-w/2,-od/2-1,0])
            cube([w,t,h]);
        }
        translate([0,0,-0.1])
        cylinder(d=id, h=h+1);
    }        
}
module tnutSupport(){
    // T8 nuts
   translate([59,42,zh/2+15])
    rotate([0,-90,0])
    import("stl/TR8x2-4_Nut.stl");
   translate([21,42,zh/2+15])
    rotate([0,90,0])
    import("stl/TR8x2-4_Nut.stl");
    
    // tnut support
    color(c3dp)
    difference(){
        union(){
            hull(){
                translate([0, by/2-dn/2,27+xw])
                rotate([-90,0,0])
                cylinder(d=30, h=dn);
                
                translate([-20, by/2-dn/2,27+xw+15])
                cube([40,dn,10]);
            }
            
            hull(){
                translate([-35, by/2-dn/4,27+xw+15])
                rcube(70,dn/2,10,10);

                translate([-20, by/2-dn/2,27+xw+15])
                cube([40,dn,10]);
            }
        }
        //-----------------------------
        // Rebaixo tnut
        translate([0, by/2-dn/2-.1,27+xw])
        rotate([-90,0,0])
        cylinder(d=21, h=4);
        translate([0, by/2+dn/2-4,27+xw])
        rotate([-90,0,0])
        cylinder(d=21, h=4+1);
        
        // axis
        translate([0, by/2-dn/2-.1,27+xw])
        rotate([-90,0,0])
        cylinder(d=10, h=dn+1);

        // Bolts
        translate([-25,by/2,62+5])
        rotate([180,0,0]){
            Mscrew(10,5.3);
            
            translate([50,0,0])
            Mscrew(10,5.3);
        }
    }
}    
module ymotor(){
    color(c3dp)
    translate([x/2-25,y,0])
    difference(){
        union(){
            // front
            translate([-2.5,0,0])
            rotate([90,0,0])
            rcube(55,68,15,8);
            
            // lateral
            translate([-2.5,-15,20])
            hull(){
                cube([5,15,40]);
                cube([5,50,10]);
            }
            translate([40+7.5,-15,20])
            hull(){
                cube([5,15,40]);
                cube([5,50,10]);
            }
            
            // bottom
            wu= 127;
            hull(){
                translate([25-wu/2,-5+20,20])
                rcube(wu,20,8,3);
                translate([25-wu/4,-15,20])
                rcube(wu/4*2,20,8,3);
            }
        }
        //-----------------------------
        // motor
        translate([2.5,0,25])
        cube([45,40,10]);
        
        // motor holes
        translate([25,-4+10,27+xw])
        rotate([90,0,0])
        nema17_holes(52); 
        
        // bearings
        translate([25,-20-5,27+xw])
        rotate([-90,0,0])
        cylinder(d=28, h=20);
        
        //lower cut
        translate([-.1,-5, -.1])
        cube([60,55,20+fit]);
        
        // Bolts front
        translate([10,-15+5,10])
        rotate([90,0,0]){
            Mscrew(10,5.3);
            
            translate([30,0,0])
            Mscrew(10,5.3);
        }
        // Bolts upper
        translate([-10,-5+10,30-5])
        rotate([0,0,0]){
            Mscrew(10,5.3);
            
            translate([70,0,0])
            Mscrew(10,5.3);
        }
        translate([-30,-5+10+20,30-5])
        rotate([0,0,0]){
            Mscrew(10,5.3);
            
            translate([70+40,0,0])
            Mscrew(10,5.3);
        }
    }
}

module yfront(){
    color(c3dp)
    translate([x/2-25,0,0])
    difference(){
        union(){
            translate([0,15+30,0])
            rotate([90,0,0])
            rcube(50,68,15,8);
            
            // lateral
            *translate([0,-5,20+15])
            cube([10,40,25]);
            *translate([40,-5,20+15])
            cube([10,40,25]);
            
            // upper
            wu= 127;
            hull(){
                translate([25-wu/2,0,20])
                rcube(wu,20,8,3);
                translate([25-wu/4,20+5,20])
                rcube(wu/4*2,20,8,3);
            }
        }
        //-----------------------------
        // bearings
        translate([25,35-.1,27+xw])
        rotate([-90,0,0]){
            translate([0,0,8.1])
            608zz();
            translate([0,0,-5])
            608zz();
            
            translate([0, 0,-10])
            cylinder(d=14, h=30);
        }
        //cut
        translate([-.1,0, -.1])
        cube([60,40,20+fit]);
        
        // Bolts front
        translate([10,45-.1,10])
        rotate([-90,0,0]){
            Mscrew(10,5.3);
            
            translate([30,0,0])
            Mscrew(10,5.3);
        }
        // Bolts upper
        translate([-8,30,30-5])
        rotate([0,0,0]){
            Mscrew(10,5.3);
            
            translate([70-4,0,0])
            Mscrew(10,5.3);
        }
        translate([-30,10,30-5])
        rotate([0,0,0]){
            Mscrew(10,5.3);
            
            translate([70+40,0,0])
            Mscrew(10,5.3);
        }
    }
}

//========================================
//      Carriage 
//========================================
module carriage(){
    /* Alternative motor position
    color(cSte)
    translate([39,65,zh+33])
    rotate([0,0,180])
    import("stl/Nema17_Stepper.stl");
    /**/
    
    zBack();

    /* Motion */
    translate([0,0,-10]){
        *color(cSte)
        translate([39,-25,zh+96])
        rotate([180,0,0])
        import("stl/Nema17_Stepper.stl");
        
        translate([40,-20,zh+48])
        coupling();
        
        // leadscrew
        color(cSte)
        translate([40,-20, 10])
        cylinder(d=8, h=zh+50);        
    }
    
    zTop();
    
    zBottom();
    
    // Profile 
    *color(cAlu)
    translate([10,0,15])
    rotate([0,-90,-90])
    profile(zh,60);
    
    // Shafts 
    color(cSte){
        // shafts
        translate([sl,-20,0])
        cylinder(d=12, h=zh+50);
        translate([sr,-20,0])
        cylinder(d=12, h=zh+50);
    }
    // Shaft Bearings 
    *translate([0,0,35]){
        translate([sl,-20,46])
        lm12uu();
        translate([sr,-20,46])
        lm12uu(); 
        
        translate([sl,-20,15])
        lm12uu();
        translate([sr,-20,15])
        lm12uu();  
        
        color(cAlu)        
        translate([40,-73,-35])
        spindle();
         
        spindleSupport();
    }
    /*****/
}
/*******************/
/*      X Axis     */
/*******************/
module x_motor_support(){
    // motor support    
    color(c3dp)
    translate([x+5,zp-31,zhp+dz/2-21])
    difference(){
        translate([18+11,0,0])
        rotate([0,-90,0])
        hull(){
            translate([0,30,0])
            rcube(dz/2+31,41,18+11,3);

            translate([-1,-2,0])
            rcube(dz/2-10,71,18+11,3);
            
            translate([-30,30,0])
            rcube(dz/2+31,41,18+11,3);
        }
        //-------------------------
        translate([-5,-5,-40])
        cube([20,100,150]);

        translate([-.1,-2.1,-.1])
        cube([8+10,46,40]);
        translate([-.1,-13,-31])
        cube([8+10,44,50]);
        
        translate([22+10,21-2,21])
        rotate([0,-90,0]){
            nema17_holes(30); 
            translate([0,0,3+5])
            cylinder(d=28,h=25);
        }
        
        // Bolts
        translate([20,31+10,76]){
            rotate([0,90,0])
            Mscrew(20,5,1);
            translate([0,20,0])
            rotate([0,90,0])
            Mscrew(20,5,1);
        }
        translate([20,31+10,-20]){
            rotate([0,90,0])
            Mscrew(20,5,1);
            translate([0,20,0])
            rotate([0,90,0])
            Mscrew(20,5,1);
        }
    }
}
module T8_sup(){
    difference(){
        cube([30,28,34]);
        //---------------------------
        translate([5,28/2,34/2])
        rotate([0,-90,0])
        cylinder(d=22, h=10);

        translate([40,28/2,34/2])
        rotate([0,-90,0])
        cylinder(d=8, h=50);
        
        translate([(30-18)/2, 8, (34-24)/2])
        rotate([90,0,0]){
            cylinder(d=4, h=10);
            translate([18,0,0])
            cylinder(d=4, h=10);
            translate([18,24,0])
            cylinder(d=4, h=10);
            translate([0,24,0])
            cylinder(d=4, h=10);
        }
    }    
}    
module x_motion(){

    *x_motor_support();
    
    // X motor
    *translate([x+30+30-11-15,zp-8-4,zhp+dz/2])
    rotate([0,-90,0])
    translate([-1,4.2,-10]) {
        color(cSte){
        import("stl/Nema17_Stepper.stl");
        translate([0,0,34-60])
        import("stl/Nema17_Stepper.stl");
        }
        // coupling
        translate([1,-4.3,19.2])
        coupling();
        // bearing
        translate([1,-4.3,12.1])
        cylinder(d=22,h=7);
    }
    
    // T8 nut
    *color("black")
    translate([xpos+30,zp-15-4,-17.5+zhp+dz/2])
    import("stl/Anti-Backlash_Nut_Printable.stl");

    *color("silver")
    translate([xpos+(80-30)/2,zp-26,-17+zhp+dz/2])
    T8_sup();
    
    
    *translate([xpos+61,zp-8-4,zhp+dz/2])
    rotate([0,-90,0])
    import("stl/TR8x2-4_Nut.stl");
    
    // Leadscrew
    color(cSte)
    translate([-22-15,zp-8-4,zhp+dz/2])
    rotate([0,90,0])
    cylinder(d=8, h=x+50);

    // Bearings support
    *translate([x-5,zp-8-2,zhp+dz/2])
    rotate([0,90,0])
    bearingSupport();

    translate([5,zp-8-2,zhp+dz/2])
    mirror([1,0,0])
    rotate([0,90,0])
    bearingSupport();
}


// X Linear Rails 
module x_axis(xpos){
    translate([0,zp-10,zhp-7.5+dz])
    linearRail(xpos);

    translate([0,zp-10,zhp-7.5])
    linearRail(xpos);
}

/*******************/
/*      Frame      */
/*******************/
module frame(){
    zl=400;
    
    // X
    translate([0,0,0])
    rotate([0,0,0])
    profile(x,xw*2);
    translate([0,y-40,0])
    rotate([0,0,0])
    profile(x,xw*2);
    
    // Y
    translate([0,0,20])
    rotate([90,0,90])
    profile(y,yw);
    translate([x-20,0,20])
    rotate([90,0,90])
    profile(y,yw);
    /*
    translate([0,y-ref,60])
    rotate([90,0,90])
    profile(ref,yw);
    translate([x-20,y-ref,60])
    rotate([90,0,90])
    profile(ref,yw);
    */
    // Z
    translate([0,zp,20])
    rotate([0,-90,0])
    profile(z,zw);
    translate([x+20,zp,20])
    rotate([0,-90,0])
    profile(z,zw);
    
    // Upper
    translate([0,zp+20,z-20])
    rotate([90,0,0])
    profile(x,40);    
    translate([0,zp+20,z-40-dz])
    rotate([90,0,0])
    profile(x,40);    
}

/*******************/
/*      Y Axis     */
/*******************/
module y_axis(){
    ysl=x/4;
    ysr=x/4*3;
    // Y Shaft Support 
    {
        translate([ysl,2,xw])
        sk16();
        translate([ysr,2,xw])
        sk16();
        
        translate([ysl,y-20+2,xw])
        sk16();
        translate([ysr,y-20+2,xw])
        sk16();
    }
    // Y shaft 
    color(cSte){
        translate([ysl,1,27+xw])
        rotate([-90,0,0])
        cylinder(d=16, h=y);
        translate([ysr,1,27+xw])
        rotate([-90,0,0])
        cylinder(d=16, h=y);
    }
}
module y_motion(){   
    // Y motor
    translate([x/2,y,27+xw])
    rotate([90,0,0]){
        color(cSte)
        translate([-1,4.2,-10]){
        import("stl/Nema17_Stepper.stl");
        translate([0,0,34-60])
        import("stl/Nema17_Stepper.stl");
        }
        // coupling
        translate([0,0,2.1+7])
        coupling();
    }
    
    // leadscrew
    color(cSte)
    translate([x/2,20-55+14,27+xw])
    rotate([-90,0,0])
    cylinder(d=8, h=y);

    // tnut support
    *color(c3dp)
    translate([x/2,by/2-dn/2, 0])
    tnutSupport();

    //t8 nut
    *translate([x/2,y/2+5, 0]){
        translate([0,dn+6,27+xw])
        rotate([90,0,0])
        import("stl/TR8x2-4_Nut.stl");
        translate([0,0,27+xw])
        rotate([-90,0,0])
        import("stl/TR8x2-4_Nut.stl");
    }
    
    *yfront();
    ymotor();
    
    // Bearings
    *translate([x/2,y-40-10,27+xw])
    rotate([-90,0,0])
    color(cSte){
        translate([0,0,8.1])
        608zz();
        translate([0,0,-5])
        608zz();
        
        translate([0,0,-5-8])
        cylinder(d=14, h=8);
    }
}

// Bed
module bed(){
    // Bed
    //color(cAlu)
    %translate([(x-bx)/2,0,xw+27+20+5])
    cube([bx,by,20]);
    
    translate([20+(x-bx)/2,0,27+xw+20+20+5])
    #cube([bx/2,by,clear]);
    
    // Bearings
    color(cSte){
        translate([ysl,by/4-.1,27+xw])
        rotate([-90,0,0])
        lm16uu();
        translate([ysl,by/4*3-37.1,27+xw])
        rotate([-90,0,0])
        lm16uu();
        
        translate([ysr,by/4-.1,27+xw])
        rotate([-90,0,0])
        lm16uu();
        translate([ysr,by/4*3-37.1,27+xw])
        rotate([-90,0,0])
        lm16uu();
    }
    
    translate([ysl,by/4,27+xw])
    bedSupport();
    translate([ysr,by/4,27+xw])
    bedSupport();
}


//=======================================

//=======================================
module linearRail(pos=0){
    cube([x,10,15]);

    color(cSte)
    translate([15+pos,10,7.5]) 
    rotate([90,0,0])
    import("stl/MGN15H.stl");
}
   
module coupling(){
    color("blue")
    difference(){
        cylinder(d=14, h=25);
        
        translate([0,0,-1])
        cylinder(d=5, h=27);
        
        translate([0,0,-.1])
        cylinder(d=8, h=25/2);

        translate([0,-1,5])
        rotate([90,0,0])
        cylinder(d=3,h=7);

        translate([0,-1,25-5])
        rotate([90,0,0])
        cylinder(d=3,h=7);
    }      
}    
module nema17_holes(h=16){
    nema17_hole_offsets = [
        [-15.5,  15.5, -5],
        [-15.5, -15.5, -5],
        [ 15.5, -15.5, -5],
        [ 15.5,  15.5, -5]
    ];    
    
    // center hole
    pcylinder(d = 22.5, h = h-1);

    /* mounting holes */
    translate([0,0,16])
    for (a = nema17_hole_offsets) {
        translate(a)
        {
            //cylinder(d = sd, h = h);
            Mscrew(h);
        }
	}    
}

module spindle(){
    cylinder(d=15, h=ml);
    
    translate([0,0,rl])
    cylinder(d=md, h=ml-rl);

    // Bit
    translate([0,0,-60])
    cylinder(d=6, h=100);    
}    
module lm16uu(){
    // 16x28x37
    difference(){
        cylinder(d=28, h=37);
        
        translate([0,0,-1])
        cylinder(d=16, h=40);
    }        
}    
module lm12uu(){
    // 12x21x30
    difference(){
        cylinder(d=21, h=30);
        
        translate([0,0,-1])
        cylinder(d=12, h=40);
    }        
}    
module sk16(){
    bx=48;
    by=16;
    bz=8;
    x=25;
    z=40;
    d=16;
    h=27;
    
    translate([-bx/2,0,0])
    difference(){
        union(){
            cube([bx,by,bz]);
            translate([(bx-x)/2,0,0])
            cube([x,by,z]);
        }
        
        translate([bx/2,-.1,h])
        rotate([-90,0,0])
        cylinder(d=d, h=by+1);
    }
}
module sk12(){
    bx=42;
    by=14;
    bz=6;
    x=20;
    z=37.5;
    d=12;
    h=23;
    
    translate([-bx/2,0,0])
    difference(){
        union(){
            cube([bx,by,bz]);
            translate([(bx-x)/2,0,0])
            cube([x,by,z]);
        }
        
        translate([bx/2,-.1,h])
        rotate([-90,0,0])
        cylinder(d=d, h=by+1);
    }
}

module profile(s,w){
    cw=6; // chanel width
    cd=4; // chanel depth
    
    difference(){
        cube([s,w,20]);
        
        for(i=[0:w/20-1]){
            translate([-.1,i*20+10-cw/2,-.1])
            cube([s+1,cw,cd]);
            translate([-.1,i*20+10-cw/2,20-cd+.1])
            cube([s+1,cw,cd]);
        }
        // Top & Bottom
        translate([-.1,-.1,10-cw/2])
        cube([s+1,cd,cw]);
        translate([-.1,w-cd+.1,10-cw/2])
        cube([s+1,cd,cw]);
    }
}

module 608zz(fit=0){  
    // 22 x 8 x 7mm plus 1mm cover
    difference(){
        union(){
            cylinder(d=22+fit, h=7);
        }
        translate([0,0,-.1])
        cylinder(d=8, h=8);
    }
}    
//===================================
//            Lib
//===================================
module rcube(length,width,height,radius=.5,chamfer=0){    
    l=length-2*radius;
    w=width-2*radius;    
    difference(){
        translate([radius,radius,0])
        hull(){
            cylinder(r=radius,h=height);    
            translate([0,w,0])
            cylinder(r=radius,h=height);    
            translate([l,0,0])
            cylinder(r=radius,h=height);    
            translate([l,w,0])
            cylinder(r=radius,h=height);    
        }
        /*******************************/
        difference(){
            translate([-.1,-.1,-.1])
                cube([length+.2,width+.2,chamfer]);
            /*******************************/
            hull(){
                translate([-.1,-.1,chamfer])
                cube([length+.2,width+.2,.1]);
                translate([chamfer,chamfer-.1])
                cube([length-chamfer*2,width-chamfer*2,.1]);
            }
        }
    }
}
/* Cylinders */
//pcylinder(d=16.34, h=4*4, v=1);   
module pcylinder(d,h, v=1){
    if(v==1){
        rotate([-90,0,180])
        vcylinder(d,h);
    }else{
        cylinder(d=d,h=h);
    }
}
module vcylinder(d,h){
    rotate([90,0,0])
    difference(){
        hull(){
            translate([0,d*.6,0])
            cylinder(h=h,d=d/10);
            
            cylinder(h=h,d=d);
        }    
        
        translate([-d/2,d/2,-.1])
        cube([d,d,h+1]);
    }
}
module Mscrew(l=10, d = "undefined", b=false, v=0){
    // Cap Screw
    if (d == "undefined") {
        screw(l, 3, b, v);
    }else{
        screw(l, d, b, v);
    }
}    

module screw(length=10, d=3, b=false, v=0){    
    head_width = 2*d;  
    head_height = 1.2*d;

    difference(){
        union(){
    translate([0,0, head_height])
    rotate([180,0,0]){
        pcylinder(h=length+head_height, d=d+fit, v=v); 
        pcylinder(h=head_height, d=head_width+fit, v=v);
        
        translate([0,0,-length])
        pcylinder(h=length+head_height, d=head_width+fit, v=v);
    }
        }
    // Bridge
    if(b){
        translate([0,0,0])
        #pcylinder(h=.3, d=head_width+fit, v=v);        
    }
    }    
}

module nut(l=12, di=3, b=true){    
    do=2*di;
    difference(){
        union(){
            // Nut
            cylinder(h=l, d=do+fit, $fn=6);
            // screw
            translate([0,0,-l*2])
            cylinder(h=l*3, d=di+fit);
        }
        
        // Bridge
        if(b){
            cylinder(h=.3, d=do+fit);        
        }
    }
}
