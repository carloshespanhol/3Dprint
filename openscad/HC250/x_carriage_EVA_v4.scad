include <config.scad>
use <parts.scad>
use <linear_bearing.scad>
use <../sc.scad>
use <../lib.scad>
use <../timing_belts.scad>

$fs=0.2;
$fn=200;

t=thick;
tm=thick_min+.5;
w=car_width;
bt=belt_thick;
bs=belt_size;
bd=belt_distance;
//bw=bush_width;
eh=14; //extruder height

m2=2.5;

//Belt Support Height
bsh =belt_distance+belt_size*2+thick+1.2;  
// Belt Support Width
bsw =10;           
mw=23.5;
ts=1.5;

reccess=1.5;
ba=36; // bush angle
s=10;
lh=0.2;


print=1;

/*----------------------------------*/
// distance from nozle
//#translate([30,-3,-50]) scube(1,3,80);

if(print == 1){
    *adxl();
    fan_support();
    *Mx()
    Ry(90)
    fan_duct();
    *Ry(90)
    fan_duct();
    *klicky();
    *5020_fan(fd);
    //translate([0,0,12.5]) rotate([0,-90,45]) 
    *front_face();
    *back_face();
    *top_mgn9();
    
    //translate([0,-tbd/2-31,18.7])    
    //rotate([90+75,0,-90])
    *v6_face_4020();

    /* Hotend *
   translate([0,-tbd/2-18,64.9-hotend_height])
        hotend_e3d(1);
    /**/
}else{
    eva_xcarriage();
    carriage_parts();
    *HX_extruder();

    fan_support();
    
    *translate([-fd/2+(fd-45)/2,7,-45.3+7.5+1])
    klicky();
    translate([-fd/2+(fd-45)/2, 18.5, -35])
    adxl();
    
    *Rz(-30)
    T(-10,27,-2)
    {
        mirror([1,0,0])
        translate([-fd+8.5,-29,-41])
        Rz(-50)        
        fan_duct();    
        %5020_fan(fd);
    }

    Rz(30)
    T(10,27,-2)
    {
        translate([-fd+8.5,-29,-41])
        Rz(-50)        
        fan_duct();     
        mirror([1,0,0])
        %5020_fan(fd);
    }
     
    *belts_vz(60,60);
    *gantry();
}

//#translate([-40,-50,-21-24]) cube([80,100,.3]);

fd=75;
module template(){
    difference(){
        union(){
        }
        //-------------------------
    }
}
//=========================================================
module fan_support(){
    i=0;    //inclination
    
    %T(-20,7,-45)
    Cu(40,1,7.2);
    
    // Fan fix
    Ty(12) 
    difference(){
        union(){
            // front plate
            Ty(-12)
            difference(){    
                translate([-fd/2,7,-45.3+7.5])
                rcube(fd,3.5,15,1);
                //-----------------------
                translate([-17.5, 9, -30.4])
                rotate([90,0,0])
                Mnut(b=0);
                
                mirror([1,0,0])
                translate([-17.5, 9, -30.4])
                rotate([90,0,0])
                Mnut(b=0);        
            }   
            *translate([-fd/2+2,4.7,-37.8])
            Cy(r=8.1,h=21-4);
            //left
            hull(){
                translate([-fd/2+2,4.7,-37.8])
                Cy(r=8,h=21);
                
                translate([-fd/2-2.5, -5,-37.8])
                rcube(12.5,10.5,21);
            }
            
            //right
            hull(){
                mirror([1,0,0])
                translate([-fd/2+2,4.7,-37.8])
                Cy(r=8,h=21);
                
                mirror([1,0,0])
                translate([-fd/2-2.5, -5,-37.8])
                rcube(12.5,10.5,21);
            }
        }
        //--------------------------
        // left
        fs=1.05;
        translate([0,0,-1])
        rotate([0,i,0]){
            T(3.6,18.25,0)
            Rz(-32)
            S(fs,fs,fs)
            5020_fan(fd);
            
            // screw
            translate([-fd/2+2,4.7,-40]){
                //cylinder(d=4.5, h=30);
                cylinder(d=6, h=19);
            }
        }
               
        translate([-fd/2-12.6, -6,-37.8-4.2])
        rcube(12.5,12,21);
        
        // M4 nut
        translate([-fd/2+2, 4.75, -19])
        Mnut(di=4);         
        translate([fd/2-2, 4.75, -19])
        Mnut(b=1,di=4);         
               
        // right
        mirror([1,0,0]){
        translate([-fd/2-12.6, -6,-37.8-4.2])
        rcube(12.5,12,21);

        translate([0,0,-1])
        rotate([0,i,0]){
            T(3.6,18.25,0)
            Rz(-32)
            S(fs,fs,fs)
            5020_fan(fd);
            
            // screw
            translate([-fd/2+2,4.7,-40]){
                //cylinder(d=4.5, h=30);
                cylinder(d=6, h=19);
            }
        }
        }
    }
}

module 5020_fan(fd=70){   
    translate([59,-72, -19])
    rotate([-90,180,-40])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/50x20blower.stl");
    
    /*
    Tz(-10)
    #T(45,-15,-37)
    Rz(-40)
    My()
    rcube(22,50,16);
    */
}

module fan_duct(){
    t=1.6;  //thickness
    td=1;   //division thickness
    du=1;   //ducts
    a=50;
    in=3;
    l=28;
    w=26;
    ow=12;
    h=21;
    oh=4;
    outh=-2;
    cut=2.7;
    
    difference(){
        U(){
            // Suporte para impressao
            if(print == 1){
                hull(){
                    T(in+l+cut,w/2,oh+1)
                    Cu(.1,t,h-5.4);
                    T(in+w/4,w/2,h-.5)
                    Cu(.1,t,.1);    
                }
                T(in+l+cut-.8,w/2,oh-.5)
                Cu(t/2,t,t*3);   
                T(in+l/2+3,w/2,h/2+.5) 
                Cu(t/2,t,t*2);    
                T(in+w/4,w/2,h-2.5)
                Cu(t/2,t,t+.5);  
            }
            
            // Duct divisions
            if(du>1){
            di=w/du;
            do=ow/du;    
            hull(){
                T(in,t+(1*di-td/2)+0,0)
                cube([.1,td,h+t*1.9]);
                
                T(in+l-.7,t+(w-ow)/2+(1*do-td/2),outh+.1)
                Ry(90-a)
                cube([.1,td,oh+t*.9]);
            }
            hull(){
                T(in,t+(2*di-td/2)-0,0)
                cube([.1,td,h+t*1.9]);
                
                T(in+l-.7,t+(w-ow)/2+(2*do-td/2),outh+.1)
                Ry(90-a)
                cube([.1,td,oh+t*.9]);
            }
            }
            
            // Duct
            difference(){
                union(){
                    // fixacao
                    translate([-15,1.5,t+(h-16)/2])
                    Rz(-6)
                    vrcube(16,t,16,1);

                    // Entrada 
                    My()
                    Rz(-90)
                    vrcube(w+t*2,in,h+t*2,2);                
                 
                    // Corpo
                    hull(){
                        translate([in-.1,0,0])
                        rotate([0,-90,0])
                        rcube(h+t*2,w+t*2,.1,2);
                       
                        translate([in+l-.6,(w-ow)/2,outh])
                        Ry(-a)
                        rcube(oh+t+1,ow+t*2,.1, (oh+t+1)/2);
                    }  
                }
                //--------------------------------------
                // Parte interna da entrada
                translate([-.1,t,t])
                cube([in,w,h]);
                
                // Parte interna do corpo
                D(){
                    hull(){
                        translate([in-.1,t*1.5,t*1.5])
                        rotate([0,-90,0])
                        rcube(h-t,w-t,.1,1);
                       
                        translate([in+l+.5,t+(w-ow)/2,outh+.75])
                        Ry(-a)
                        rcube(oh,ow,.1, 1.5);
                    }
                    //--------------
                    Tx(-10)
                    Cu(1);
                    Tz(-l*1.5+t*1.6)
                    Tx(l/2+in-t*3.5)
                    Ty(w+t*2)
                    Rx(90)
                    CyH(r=l*1.535, h=w*3);
                }
                
                // slot
                translate([-9,-3,t+(h-4)/2])
                cube([10,10,4]);            

                /*/ fan air in
                translate([-26,30,-4])
                cylinder(d=46.2, h=30);
                // screw
                translate([-45.1,3.5,19])
                cylinder(d=4.5, h=4);
                translate([-30,-10.6,1])
                cylinder(d=4, h=20);
                /**/
            }
        }
        //------
        // Front cut
        T(in+l+cut,-ow,-1)
        Cu(10,w*2,h*2);
        
        /*/ Bottom cut 
        T(in+l+w/5, w/2+t, -h-1.3)
        Ry(35)
        intersection(){
            fcylinder(r=w/2+w/4,h=h,2);
            //----------------------
            T(-ow,-ow/2,0)
            rbox(ow*2,ow,h,2);
        }
        /**/
    }    
}
module fan_duct2(){
    t=1.6;  //thickness
    td=1;  //division thickness
    du=3;   //ducts
    a=50;
    in=3;
    l=25;
    w=26;
    ow=16;
    h=21;
    oh=h/3+1;
    outh=-2;
    
    difference(){
        U(){
            // Suporte para impressao
            if(print == 1){
                hull(){
                    T(in+l+w/4,w/2,5.5)
                    Cu(.1,t,h-t*3-.5);
                    T(in+w/4,w/2,h)
                    Cu(.1,t,.1);    
                }
                T(in+l+w/5-t/2-.4,w/2,5)
                Cu(t/2,t,t*3);    
                T(l-3,w/2,h/2+.2)
                Cu(t/2,t,t*2);    
                T(in+w/4,w/2,h-2)
                Cu(t/2,t,t+.5);  
            }
            
            // Duct divisions
            di=w/du;
            do=ow/du;    

            hull(){
                T(in,t+(1*di-td/2)+1,0)
                cube([.1,td,h+t*1.9]);
                
                T(in+l-.7,t+(w-ow)/2+(1*do-td/2),outh+.1)
                Ry(90-a)
                cube([.1,td,oh+t*.9]);
            }


            hull(){
                T(in,t+(2*di-td/2)-1,0)
                cube([.1,td,h+t*1.9]);
                
                T(in+l-.7,t+(w-ow)/2+(2*do-td/2),outh+.1)
                Ry(90-a)
                cube([.1,td,oh+t*.9]);
            }
                
            // Duct
            difference(){
                union(){
                    // fixacao
                    translate([-15,1.5,t+(h-16)/2])
                    Rz(-6)
                    vrcube(16,t,16,1);

                    // Entrada 
                    My()
                    Rz(-90)
                    vrcube(w+t*2,in,h+t*2,2);                
                 
                    // Corpo
                    hull(){
                        translate([in-.1,0,0])
                        rotate([0,-90,0])
                        rcube(h+t*2,w+t*2,.1,2);
                       
                        translate([in+l-.6,(w-ow)/2,outh])
                        Ry(-a)
                        rcube(oh+t,ow+t*2,.1, 2);
                    }  
                }
                //-------------------------
                // Parte interna da entrada
                translate([-.1,t,t])
                cube([in,w,h]);
                
                // Parte interna do corpo
                D(){
                    hull(){
                        translate([in-.1,t*1.5,t*1.5])
                        rotate([0,-90,0])
                        rcube(h-t,w-t,.1,1);
                       
                        translate([in+l+.5,t+(w-ow)/2,outh+.75])
                        Ry(-a)
                        rcube(oh-1,ow,.1, 2);
                    }
                    //--------------
                    Tx(-10)
                    Cu(1);
                    *Tz(-l*1.5+t*1.6)
                    Tx(l/2+in-t*3.5)
                    Ty(w+t*2)
                    Rx(90)
                    CyH(r=l*1.5, h=w*3);
                }
                
                // slot
                translate([-9,-3,t+(h-5)/2])
                cube([10,10,5]);            

                /*/ fan air in
                translate([-26,30,-4])
                cylinder(d=46.2, h=30);
                // screw
                translate([-45.1,3.5,19])
                cylinder(d=4.5, h=4);
                translate([-30,-10.6,1])
                cylinder(d=4, h=20);
                /**/
            }
        }
        //------
        // Front cut
        T(in+l+w/5-.5,-1,0)
        Cu(10,w*2,h*2);
        
        /*/ Bottom cut 
        T(in+l+w/5, w/2+t, -h-1.3)
        Ry(35)
        intersection(){
            fcylinder(r=w/2+w/4,h=h,2);
            //----------------------
            T(-ow,-ow/2,0)
            rbox(ow*2,ow,h,2);
        }
        /**/
    }    
}
module fan_duct1(){
    t=1.6;  //thickness
    td=1;  //division thickness
    du=3;   //ducts
    a=20;
    in=3;
    l=23;
    w=26;
    ow=20;
    h=21;
    oh=h/3;

    difference(){
        U(){
            // Suporte para impressao
            if(print == 1){
                hull(){
                    T(in+l+w/4,w/2,5)
                    Cu(.1,t,h-t*3);
                    T(in+w/4,w/2,h)
                    Cu(.1,t,.1);    
                }
                T(in+l+w/4-t/2,w/2,3.5)
                Cu(t/2,t,t*2);    
                T(l-3,w/2,h/2+1.5)
                Cu(t/2,t,t*2);    
                T(in+w/4,w/2,h-2)
                Cu(t/2,t,t+.5);  
            }
            
            // Duct divisions
            di=w/du;
            do=ow/du;    
            for(i=[1:du-1]){
                hull(){
                    T(in,t+(i*di-td/2),0)
                    cube([.1,td,h+t*1.9]);
                    
                    T(in+l-.7,t+(w-ow)/2+(i*do-td/2),.1)
                    Ry(90-a)
                    cube([.1,td,oh+t*.9]);
                }
            }
                
            // Duct
            difference(){
                union(){
                    // fixacao
                    translate([-15,.85,t+(h-16)/2])
                    Rz(-3)
                    vrcube(16,t,16,1);

                    // Entrada 
                    My()
                    Rz(-90)
                    vrcube(w+t*2,in,h+t*2,2);                
                 
                    // Corpo
                    hull(){
                        translate([in-.1,0,0])
                        rotate([0,-90,0])
                        rcube(h+t*2,w+t*2,.1,2);
                       
                        translate([in+l-.6,(w-ow)/2,0])
                        Ry(-a)
                        rcube(oh+t,ow+t*2,.1, 2);
                    }  
                }
                //-------------------------
                // Parte interna da entrada
                translate([-.1,t,t])
                cube([in,w,h]);
                
                // Parte interna do corpo
                D(){
                    hull(){
                        translate([in-.1,t,t])
                        rotate([0,-90,0])
                        rcube(h,w,.1,.2);
                       
                        translate([in+l+.1,t+(w-ow)/2,0])
                        Ry(-a)
                        rcube(oh,ow,.1, 2);
                    }
                    //--------------
                    Tz(-l+t*2+t/2)
                    Tx(l/2+in-t)
                    Ty(w+t*2)
                    Rx(90)
                    CyH(r=l, h=w*3);
                }
                
                // slot
                translate([-9,-3,t+(h-5)/2])
                cube([10,10,5]);            

                /*/ fan air in
                translate([-26,30,-4])
                cylinder(d=46.2, h=30);
                // screw
                translate([-45.1,3.5,19])
                cylinder(d=4.5, h=4);
                translate([-30,-10.6,1])
                cylinder(d=4, h=20);
                /**/
            }
        }
        //------
        // Front cut
        T(in+l+w/4,-1,0)
        Cu(10,w+2,h*2);
        
        /*/ Bottom cut 
        T(in+l+w/5, w/2+t, -h-1.3)
        Ry(35)
        intersection(){
            fcylinder(r=w/2+w/4,h=h,2);
            //----------------------
            T(-ow,-ow/2,0)
            rbox(ow*2,ow,h,2);
        }
        /**/
    }    
}

module eva_xcarriage(){
    /* V6 face */
    *translate([0,-tbd/2-17,.6])
    //rotate([90,0,180])
    v6_face_4020();
    
    *color("grey")
    translate([-36.8,48.7,-33.9])
    rotate([90,0,0])
    import("stl/sunon4020.stl");
    
    translate([0,0,-1]){

    /* front face */
    color("lime")
    translate([0,-tbd/2,8.5])
    rotate([90,0,0])        
    front_face();

    /* V6 clamp */
    color("lime")
    translate([0,-tbd/2-8,18.7])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/v6_face_clamp.stl");

    /* V6 support */
    translate([0,-tbd/2-52,-53.4])
    rotate([0,180,180])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/v6_support.stl");

    /* top */
    color("grey")
    translate([0,0,24]) 
    top_mgn9();
    
    // bottom
    color("grey")
    translate([0,17.6,-38.75])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/bottom_mgn12_short_duct.stl");

    /* back face */
    *color("lime")
    translate([-22.5,tbd/2,-43.4])
    rotate([-90,0,0])
    back_face();
    
    /* endstop */
    *color("lime")
    translate([-8,(tbd-10)/2 + 7,24.1])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/X_endstop_mount_VZboT.stl");
    }
}
module adxl(){
    x=45;
    t=5;
    r=4;
    difference(){
        union(){
            vrcube(8,t,15,r);
            hull(){
                vrcube(8,t,15,r);
                translate([0,t,12])
                vrcube(8,.1,5,r);
            }
            hull(){
                translate([37,0,0])
                vrcube(8,t,15,r);
                translate([37,t,12])
                vrcube(8,.1,5,r);
            }
            xl=58;
            translate([(x-xl)/2,5,14])
            vrcube(xl,5,16,3);   
   
            translate([8,5,14])
            rotate([-90,90,0])
            fillet(5,8);
            translate([x,5,14])
            rotate([-90,90,0])
            fillet(5,8);
        }
        //-------------------------
        *translate([(x-7.5)/2,-18+3.7,-.1])
        rcube(7.5,11,15,r);
        *translate([(x-11.5)/2,-18.1,t])
        rcube(11.5,11+3.8,15,r);
        
        translate([5,-t+1.5,4.5])
        rotate([90,30,0])
        Mnut(0);
        translate([x-5,-t+1.5,4.5])
        rotate([90,30,0])
        Mnut(0);

        xd=47.5;
        translate([8,8.1,13])
        vrcube(29,2,18,.5);
        // Nuts
        translate([-1,5+2,22])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut(0);
        translate([xd-1,5+2,22])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut(0);        
    }
}
module v6_face_4020(){
    w=40;
    //color("brown")
    difference(){
        union(){
            hull(){
                translate([-w/2,-14,-19])
                vrcube(w,.5,40,4);

                translate([-w/2,-9.25,-19])
                vrcube(w,3.5,40,3);
            }
            hull(){
                translate([-w/2,-14,10])
                vrcube(w,.5,11,4);
                // clamp
                translate([-w/2,-1.2,10])
                vrcube(w,.1,14,2); 
            }
            translate([-w/2+6,-6,-11.9])
            vrcube(w-12,5,25,1);            
        }
       
        //----------------------------------
        // hotend
        translate([0,-1,-8.7])
        hotend_e3d();
       
        // vent
        x=22;
        z=30;
        hull(){
            translate([-x/2,-5,-z/2-4])
            vrcube(x,5,z,5);
           
            translate([0,-15,0])
            rotate([90,0,0])
            cylinder(d=32, h=.1);
        }

        // clamp screws
        translate([11,-10,17.5])
        rotate([90,0,0])
        Mscrew(l=30,b=1);
        translate([-11,-10,17.5])
        rotate([90,0,0])
        Mscrew(l=30,b=1);
       
        // fan screws
        translate([16,-35,17])
        rotate([90,0,0])
        Mscrew(40);
        translate([-16,-35,17])
        rotate([90,0,0])
        Mscrew(40);

        translate([16,-35,-15])
        rotate([90,0,0])
        Mscrew(40);
        translate([-16,-35,-15])
        rotate([90,0,0])
        Mscrew(40);
       
        // fan nuts
        translate([16,8,17])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut();
        translate([-16,8,17])
        rotate([90,0,0])
        rotate([0,0,30])
        Mnut();      
    }
}    
module v6_face_3010(){
    t=2;
    difference(){
        union(){
            // adxl
            xl=52;
            translate([-xl/2,-5,0])
            rcube(xl,16,5,8);

            hull(){
                translate([-20.5,-35.9,0])
                rcube(41,7,t,2.5);
               
                translate([-15,0,t/2])
                rotate([0,90,0])
                cylinder(d=t, h=30);
            }
           
            hull(){
                translate([-15,-6.8,5])
                rcube(30,13.9,8,5);

                translate([-16,-7,0])
                rcube(32,1,t);
               
                translate([-15.5,0,3])
                rotate([0,90,0])
                cylinder(d=6, h=31);
            }
           
            translate([-20.5,-36.25,0])
            rcube(41,8,8.2,2.5);

            translate([-14,-29,0])
            rcube(28,26,13,2.5);
           
        }
       
        //--------------------------
        //adxl
        translate([-30.5, 7.1,-.1])
        rcube(60,16.5,20,2);
        translate([16.3, 11.5,-.1])
        cylinder(d=11, h=20);

        translate([-14.5,-5,-.1])
        rcube(29,16.5,3,2);
        translate([-23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
        translate([23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
       
        translate([0,-25.8,11+2])
        rotate([-90,0,0])
        hotend_e3d();
       
        // vent
        x=22.3;
        hull(){
            translate([0,-21,-.1])
            cylinder(d=26,h=1);
           
            translate([-x/2,-35,10])
            rcube(x,28,.1,1);
        }
        translate([-x/2,-35,10])
        rcube(x,28,4,1);

        // Fan screws
        translate([0,-12+3.5,0]){
            translate([-12,-24,-.1])
            cylinder(d=2,h=6);
            translate([12,-24,-.1])
            cylinder(d=2,h=6);

            translate([-12,0,-.1])
            cylinder(d=2.5,h=5);
            translate([12,0,-.1])
            cylinder(d=2.5,h=5);
        }
        // Clamp screws
        translate([-10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        // Support screws
        translate([-16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
    }
}

module klicky(){
    x=45;
    t=5;
    r=1;
    difference(){
        union(){
            rotate([90,0,0])
            rcube(x,14,t,r);
            translate([(x-18)/2,-18,0])
            hull(){
                translate([0,18-t,0])
                cube([18,t,14]);
                rcube(18,18,t,r);
            }
        }
        //-------------------------
        translate([(x-7.5)/2,-18+3.7,-.1])
        rcube(7.5,11,15,r);
        translate([(x-11.5)/2,-18.1,t])
        rcube(11.5,11+3.8,15,r);
        
        translate([5,-t+1.5,6.4])
        rotate([90,30,0])
        Mnut(0);
        translate([x-5,-t+1.5,6.4])
        rotate([90,30,0])
        Mnut(0);
    }
}



module 5020_fan1(fd=70){   
    //color("grey")
    translate([-fd/2-4,-41,-39])
    rotate([0,0,-20])
    {
        rotate([0,-90,0])
        rotate([0,0,90])
        translate([-23.5,0,-35.5])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/50x20blower.stl");
        
        translate([-6.5,46.5,-1])
        rotate([180,0,0])
        Mscrew(l=28,d=4,hh=2, he=false);
    }
}


/*=======================================*/
module front_face(){
    // Sacrifice Bridge
    translate([-10,18,2.3])
    cube([20,5,.3]);

    difference(){
        union(){
            rotate([-90,0,0])
            import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/universal_face.stl");
            
            translate([-7,-10,0])
            cube([1.6,11,5]);
            translate([5.5,-16,0])
            cube([1.6,11,5]);
        }
        
        //---------------------------------
        if(print==1){
            // tie holes
            translate([-17,1.5,-1])
            cube([3.5,2,10]);
            translate([-17,-9,-1])
            cube([3.5,2,10]);

            translate([13.5,-7.5,-1])
            cube([3.5,2,10]);
            translate([13.5,-18,-1])
            cube([3.5,2,10]);
            
            /* Corrections */
            translate([18.5,-2.8,-1])
            cylinder(d=3.5,h=3.3);
            
        }
    }
}    

module back_face(){
    d=4;
    
    translate([9.5,-45,d/2])
    hull(){
        rotate([-90,0,0])
        cylinder(d=d, h=10);
        
        translate([0,0,4.5-d])
        rotate([-90,0,0])
        cylinder(d=d, h=10);
    }
    translate([35.5,-45-9,d/2])
    hull(){
        rotate([-90,0,0])
        cylinder(d=d, h=10);
        
        translate([0,0,4.5-d])
        rotate([-90,0,0])
        cylinder(d=d, h=10);
    }

    difference(){
        union(){
            translate([-3.5,-52,70])
            rotate([90,0,0])
            translate([25.9,-65,0])
            import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/Back plate without tensioner EVA 2.4.stl");    

            translate([0.5,-48,0])
            rcube(16.5,13.5,5,2);

            translate([28.2,-45-10.8,0])
            rcube(16.2,12.5,5,2);
        }
        //------------------------------
        if(print==1)
        {
        translate([4+27,-44.5-9,-1])
        rcube(10,8.5,10,1);
        translate([39,-44.5-9,4.5])
        scube(7,8.5,1);
        
        translate([4,-44.5,-1])
        rcube(10,8.5,30,1);
        translate([0,-44.5,4.5])
        scube(5,8.5,1);
        }
    }
}    
module top_mgn9(){
    difference(){
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/Top-MGN9-HextrudORT.stl");
        
        if(print==1){
            translate([-30,-tbd/2-10-2,-25])
            cube([60,10,80]);
        }
    }
}    
module gantry(){
    // Idlers    
    translate([-50.25,-25.25,-8.6]){
    translate([0,0,9.1])
    gt2_idler(b=5);

    translate([0,50.25,0])
    gt2_idler(b=5);
    }
    // Y-Gantry
    translate([160,-45,-44.8]){
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Top.stl");
        import("/home/hespanhol/3D Print/openscad/HC230/stl/Y-Gantry_Bottom.stl");
    }
    /* tube */
    color("grey") 
    translate([-65,-10,-10]) 
    cube([100,20,20]);

    // carriage 
    color("silver")
    translate([0,0,10]) 
    rotate([90,0,-90])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/mgn9h.stl");
    /**/
}    
module belts_vz(dy=40,dx=40){   
    bt=belt_thick;
    
    /**
    translate([-10,33,-8.1])
    rotate([90,180,0])
import("/home/hespanhol/OneDrive/openscad/HC235/EVA_stl/tension_slider_6mm_belt_M3s.stl");

    /* Y Belt *
    color("black")
    translate([20+16,0,0])
    rotate([0,0,90])
    union(){
        translate([-dy-2,-5,belt_distance/2 ])
        cube([dy*2+10,2,6]);        

        //
        translate([-dy-2,-16.5,belt_distance/2 ])
        cube([dy-10,2,6]);        

        translate([12,-16.5,-belt_size-belt_distance/2 ])
        cube([dy,2,6]);        
        
        // Stepper belt 
        *translate([dy+2.6,-16.5,belt_distance/2 ])
        cube([53,2,6]);        
    }

    /* X Belt */
    color("black")
    translate([-dx,-19.5,0.2])
    union(){
        // Left
        translate([0,0,belt_distance/2])
        cube([dx,bt,6]);
        
        translate([0,37.4,-belt_size-belt_distance/2])
        cube([dx,bt,6]);

        // Right
        translate([dx,37.4,belt_distance/2])
        cube([dx,bt,6]);
        
        translate([dx,0,-belt_size-belt_distance/2])
        cube([dx,bt,6]);
    }

    /* Back Belt *
    color("black")
    translate([-dx,dy,0])
    union(){
        translate([0,0,belt_distance/2])
        cube([dx*2,2,6]);
        
        translate([0,0,-belt_size-belt_distance/2])
        cube([dx*2,2,6]);
    }
    /**/
}

module bottom(){
    //color("grey")
    translate([0,17.6,-38.75])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/bottom_mgn12_short_duct.stl");
}
    

   
module duct_eva_volcano(){
    color("grey")
    translate([0,10.5,-27.9])
    rotate([90,0,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/TriHorn Duct UHF.stl");
}

module plate(){
    w=44;
    t=5;
    h=57;
    
    // left
    translate([-w/2,13,3])
    belt_clamp();
    // right
    translate([w/2,13,-10])
    mirror([1,0,0])
    belt_clamp();
       
    translate([0,13,0])
    difference(){
        union(){
            translate([-22,0,-19.9])
            vrcube(w,t,h,2);
            
        }
        
        translate([1,1.5,-belt_distance/2-belt_size])
        cube([w+10,t+1, 13]);
        
        translate([-w/2-5,1.5,belt_distance/2])
        cube([w/2+4,t+1,13]);
        
        // lower holes
        translate([-w/2+9, -.1, -15.9])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
        translate([w/2-9, -.1, -15.9])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
        // higher holes
        translate([-w/2+5, -.1, 32.1])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
        translate([w/2-5, -.1, 32.1])
        rotate([-90,0,0])
        cylinder(d=3.2, h=6);
    }
}    
module HX_extruder(){
    color("silver")
    // nema 14 
    translate([0,-1,56])
    rotate([0,-9,0])
    nema14();

    color("lime")
    translate([-.6,0,0]){
        
        translate([0,-22.5,54])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_BACKPLATE.stl");
            
        translate([0,-22.5,54])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_BODY_NOVA NEW.stl");

        translate([0,-22.6,54])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_COVER.stl");

        translate([.1,-22.5,55.5])
        rotate([90,0,180])
        import("/home/hespanhol/3D Print/openscad/HC230/stl/vzEVA/HextrudORT_TENSION_ARM.stl");
    }
} 
module carriage_parts(){
    translate([0,0,-1]){
        /* Hotend */
        translate([0,-tbd/2-18,64.9-hotend_height])
        hotend_e3d(1);
        
        /* Blower */
        *translate([-8,27,-11])
        rotate([-25,0,-90])
        blower();
    }
}
module hotend_e3d(detail=0){
    translate([0,0,-37.1])
    rotate([0,0,180])
    e3d(detail,1.5);

    translate([0,0,-36.75])
    rotate([0,0,180])
    e3d(detail,1.5);
    
    *translate([0,0,35])
    rotate([0,180,0])    
    e3d_volcano();
}
module v6_face(){
    t=2;
    difference(){
        union(){ 
            // adxl
            xl=52;
            translate([-xl/2,4,0])
            rcube(xl,16,5,8);

            *hull(){
                translate([-20.5,-35.9,0])
                rcube(41,7,t,2.5);
                
                translate([-15,0,t/2])
                rotate([0,90,0])
                cylinder(d=t, h=30);
            }
            
            hull(){
                translate([-15,-6.8,5])
                rcube(30,13.9,8,5);

                translate([-16,-7,0])
                rcube(32,1,t);
                
                *translate([-15.5,0,3])
                rotate([0,90,0])
                cylinder(d=6, h=31);
            }
            
            *translate([-20.5,-36.25,0])
            rcube(8.2,41,8,2.5);
            *translate([12,-36.25,0])
            rcube(8.2,41,8,2.5);

            translate([-20.5,-36.25,0])
            rcube(41, 43, 5,2.5);
            translate([-20.5,-36.25,0])
            rcube(41, 8,8.2,2.5);

            translate([-14,-29,0])
            rcube(28,26,13,2.5);
            
        }
        
        //--------------------------
        //adxl
        *translate([-30.5, 7.1,-.1])
        rcube(60,16.5,20,2);
        translate([16.3, 11.5,6])
        sphere(d=11);

        translate([-14.5,4,-.1])
        rcube(29,16.5,2,2);
        translate([-23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
        translate([23.75,3,5-1.5])
        rotate([0,0,30])
        Mnut(0);
        
        translate([0,-25.8,11+2])
        rotate([-90,0,0])
        hotend_e3d();
        
        // vent
        x=22.3;
        hull(){
            translate([0,-16,-.1])
            cylinder(d=37,h=1);
            
            #translate([-x/2,-35,11])
            rcube(x,28,.1,1);
        }
        translate([-x/2,-35,10])
        rcube(x,28,4,1);

        // Fan screws
        *translate([0,-12+3.5,0]){
            translate([-12,-24,-.1])
            cylinder(d=2,h=6);
            translate([12,-24,-.1])
            cylinder(d=2,h=6);

            translate([-12,0,-.1])
            cylinder(d=2.5,h=5);
            translate([12,0,-.1])
            cylinder(d=2.5,h=5);
        }
        // Clamp screws 
        translate([-10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([10.8,0,6.5])
        rotate([0,180,0])
        Mscrew(b=1);
        
        // Support screws 
        translate([-16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
        translate([16,-32,3])
        rotate([0,180,0])
        Mscrew(b=1);
        
        translate([-16,0,-1])
        rotate([0,180,0])
        Mscrew();
        translate([16,0,-1])
        rotate([0,180,0])
        Mscrew();
    }
}


module nema14(){    
    t=3;
    rotate([90,0,0]){
        cylinder(d=37.5, h=17.5);
        
        rotate([0,0,-38])
        translate([0,0,17.5-t])
        difference(){
            hull(){
                translate([-21.9,0,0])
                cylinder(d=7.5, h=t);
                translate([21.9,0,0])
                cylinder(d=7.5, h=t);
                
                cylinder(d=25, h=t);
            }
            //----------------------
            translate([-21.9,0,-1])
            cylinder(d=2, h=10);
            translate([21.9,0,-1])
            cylinder(d=2, h=10);
        }
    }
    /**/
}    

module blower(){
    
    color("grey")
    translate([-8.5,-5,25.5])
    rotate([90,0,90])
    cylinder(d=40, h=.5);
    
    color("silver")
    translate([-33,-0,0])
    rotate([0,0,90])
    import("stl/50_mm_blower_fan_placeholder.stl"); 
}
/////////////////////
module top(){
    *translate([34.05,9.5+4,14])
    rotate([0,-90,0])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/top_mgn12.stl");
    
    *color("silver")
    translate([0,13.5,14-10]) 
    rotate([90,0,-90])
    import("/home/hespanhol/3D Print/openscad/HC230/stl/mgn9h.stl"); 
 
    y=10;
    z=20.9+6;

    color("grey")
    translate([-tbw/2,-tbd/2,24.05])
    difference(){
        union(){
            scube(tbw,tbd,13);

        }

        //-----------------------------------
        *translate([-5,-10,11])
        cube([50,50,30]);
        // screw access
        translate([0,0,0]){
            translate([-1,(tbd-10)/2,-.1])
            scube(tbw+2, 10, 5 +.1);
           
            hull(){
                translate([tbw/3,tbd/2, 8])
                cylinder(d=5.6,h=6.1);

                translate([tbw/3*2,tbd/2, 8])
                cylinder(d=5.6,h=6.1);
            }
            hull(){
                translate([tbw/3,tbd/2, 0])
                cylinder(d=3,h=10);

                translate([tbw/3*2,tbd/2, 0])
                cylinder(d=3,h=10);
            }
        }
    
        // screws
        translate([4.95,-10, 8])
        rotate([-90,0,0])
        cylinder(d=3.25,h=50);

        translate([tbw-4.95,-10, 8])
        rotate([-90,0,0])
        cylinder(d=3.25,h=50);
                
        // MGN9
        translate([12,6, -5])
        mgn_screw();
        translate([29.5,6, -5])
        mgn_screw();
        translate([12,21, -5])
        mgn_screw();
        translate([29.5,21, -5])
        mgn_screw();
    }
}    
module mgn_screw(){
    hull(){
        cylinder(d=3.25,h=30);

        translate([2.5,0,0])
        cylinder(d=3.25,h=30);
    }    
    translate([0,0,15])
    hull(){
        cylinder(d=5.6,h=30);

        translate([2.5,0,0])
        cylinder(d=5.6,h=30);
    }    
}    