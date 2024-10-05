use <../sc.scad>
use <../lib.scad>
use <../ISOThread.scad>
$fn=200;
print=1;

// Type: body, arm, both & test
//type="inside";
//type="test";
//type="sup";
//type="full";

//type="termsup";

//type="holder";
//type="hcenter";
type="htop";
//type="hretainer";
//type="hbottom";
//type="hnut";

LID = true;
f=2;      //fillet radius
nd=16;

//Inner hole diameter
holeD=4.5; // 1.75mm PLA (2.2 works for PLA)

// Diameter & Height of nut
D=20;
H=14;
nh=7;     //nut height
lidh=1;     //lid height

//Base height & size
baseH=7;
baseD=D;

// Thickness of container
containerT=0.5;
containerInsert=.3;

//Hight of screw above nut 
spigotaddH=4;
spigotH=H+spigotaddH;

space = 0.2;
overlap = 0.01;

// Screw thread
//==============
LH = 0.2;   //nut slack
fh = 0.2;   //LH*1;
th = LH*4;
pitch = 2;  //*(fh+th);

// Screw
//==============
screw_outerdiam=8;
screw_diam =screw_outerdiam;
screw_height=30;
echo(str("Internal diameter: ",screw_diam));
echo(str("External diameter: ",screw_outerdiam));

//===========================================
/*
*inside();
*import("/home/hespanhol/3D Print/stl_files/Filament Nut.stl");
*rotate([0,0,10])
translate([26,6.1,-2])
import("/home/hespanhol/3D Print/stl_files/Filament Bolt.stl");

%cylinder(d=8,h=10);
Tz(.6)
screw();
#metric_thread (8);
/**********************************/



//taper: Start, End, Both or None
module screw(minordiam = 8, neg=false, taper="N", resolution=60, sheight=10 ) {


// Screw polyhedron
//=================
faces = [ [0,1,2], [0,2,3], [0,3,4], [4,3,7], [3,2,7], [2,6,7], [2,1,5], [2,5,6], [4,7,5], [7,6,5], [0,4,5], [0,5,1] ];
    
    tapersteps = 10;
    $fn=resolution;
    dtheta=360/resolution;
    
    // Negative
    z_adj   = neg ? LH*(sqrt(2)-1) : 0;
    rad_adj = neg ? LH : 0;
    len_adj = neg ? overlap : 0;
    
    radmaj=minordiam/2 + rad_adj;
    radmin=radmaj-th - rad_adj;
    steps=360/dtheta * sheight/pitch;
    zstep=dtheta*pitch/360;
    zheight=th*2+fh + 2*z_adj;
    
    difference(){
        union(){
        translate([0,0,-len_adj]) 
        cylinder(h=sheight+len_adj*2, r=radmin+1/128, center=false);
        
        end = steps-1-tapersteps;
        
        for(i=[0:steps-1]) {
            // Taper start or end
            n=min(i,steps-i,tapersteps);

            sc0 = i < tapersteps ? ( taper == "S" || taper == "B" ? n/tapersteps : 1) : ( i > end ? ( taper == "E" || taper == "B"  ? n/tapersteps: 1) : 1);
            
            sc1 =  i < tapersteps ? ( taper == "S" || taper == "B" ? (n+1)/tapersteps : 1) : ( i > end ? (taper == "E"  || taper == "B" ? (n-1)/tapersteps : 1) : 1);
            
            taperrad0 = radmin + th*sc0;
            taperrad1 = radmin + th*sc1;
          
            ang = i*dtheta;
            x0 = radmin*cos(ang);
            y0 = radmin*sin(ang);
            z0 = i*zstep - z_adj;
            
            x1 = x0;
            y1 = y0;
            z1 = z0+zheight;
            
            x2 = taperrad0*cos(ang);
            y2 = taperrad0*sin(ang);
            z2 = z1-th;
            
            x3 = x2;
            y3 = y2;
            z3 = z0+th;
            
            angstep = (i+1)*dtheta+1/128;
            x4 = radmin*cos(angstep);
            y4 = radmin*sin(angstep);
            z4 = (i+1)*zstep - z_adj;
            
            x5 = x4;
            y5 = y4;
            z5 = z4+zheight;
            
            x6 = taperrad1*cos(angstep);
            y6 = taperrad1*sin(angstep);
            z6 = z5-th;
            
            x7 = x6;
            y7 = y6;
            z7 = z4+th;
            
            points = [[x0,y0,z0], [x1,y1,z1], [x2,y2,z2], [x3,y3,z3], [x4,y4,z4], [x5,y5,z5], [x6,y6,z6], [x7,y7,z7]];
            polyhedron(points=points, faces=faces);
        }
        }
        //------------------------------------------------
        //top chamfer
        Tz(sheight)
        Mz()
        chamfer_r(1.25, radmaj);
        //upper cut
        Tz(sheight)
        Cy(radmaj+2,h=5);
    }
}
/**/
module term_support(){
    import("/home/hespanhol/3D Print/stl_files/Thermostand.stl");
}

sd=4.5+.2; //sphere diameter
h=20;
t=.65;
//38 esferas
id=40;
od=48;  //spool hole diameter
td=85;  //top diameter
bd=70;
e=15+t*8;   //encaixe
te=.5;      // tolerance
brd=22+te;  //bearing diameter plus tolerance

module spool_holder(){
    //bearing
    Tz(3)
    Tz(sd+t*2){
        %cylinder(d=brd, h=7);
        holder_nut();
    }
    holder_center();
    
    Tz(t+2*sd/3)
    holder_top();
    
    color("lightgreen")
    holder_retainer();
    holder_bottom();
}

module holder_center(){    
    Tz(sd+t*2){
        //sacrifice bridge
        #Tz(3)
        cylinder(d=brd, h=.3);  
    
        difference(){
            union(){
                cylinder(d=od,h=h);
                
                T(-e/2,-e/2,-(sd/2+t/2))
                rcube(e,e,sd/2+t,2);            
            }
            //-------------------------------------
            Tz(9.5)
            cylinder(d1=brd,d2=35,h=h-9.4);
                    
            Tz(3)
            cylinder(d=brd, h=7);  
            
            Tz(-sd/2-t-1)
            cylinder(d=15,h=h);        

            translate([0,0,h])
            mirror([0,0,1])        
            fillet_r(f,od/2);
        }
    }
}
    
module holder_top(){ 
    difference(){
        union(){
            cylinder(d=td,h=sd/3+t);
        }
        //------------------------------------- 
        T(-(e+te)/2,-(e+te)/2,-.1)
        rcube(e+te,e+te,e,2);
        
        Tz(sd/3+t) 
        Mz()
        fillet_r(f,td/2);      

        if(print==1)
            Tz(-t)
            rotate_extrude(angle=360){
                Tx(td/3)
                circle(r=sd/2); 
            }
    }    
}

module holder_retainer(){ 
    difference(){
        union(){
            Tz(sd/3+t+.3)
            cylinder(d=2*td/3+sd*2,h=sd/3-.6);
        }
        //-----------------------------------
        cylinder(d=2*td/3-sd*2,h=sd);
        
        for(n=[1:20]) 
            rotate([0,0,n*360/20]) 
            translate([td/3,0,sd/2+t]) 
            sphere(sd/2+te);          
    }
}
module holder_bottom(){ 
    difference(){
        union(){
            cylinder(d=bd,h=sd/3+t);
            //center
            cylinder(d=10.5,h=sd+t*2+3+te);
            iso_thread(m=screw_diam ,p=2 ,l=h-3+nh, t=0);
        }
        //-------------------------------------   
        fillet_r(f,bd/2);
        
        cylinder(d=3,h=h+nh);
        
        if(print==1)
            Tz(sd/2+t)
            rotate_extrude(angle=360){
                Tx(td/3)
                circle(r=sd/2); 
            }
        /*    
        T(15,-20/2,-.1)
        rcube(10,20,t-.4,1);
        T(-25,-20/2,-.1)
        rcube(10,20,t-.4,1);
        */
    }
}
module holder_nut() {
    D=18;
    difference() {
        union() {
            translate([0,0,baseH+containerT])
            cylinder(h=nh/2,d1=10.5,d2=D,center=false);
            Tz(baseH+containerT+nh/2)
            cylinder(h=nh/2,d=D,center=false);
        }
        //--------------------------------------------
        translate([0,0,baseH+containerT+nh])
        mirror([0,0,1])
        fillet_r(f/2,D/2);
        Tz(baseH+containerT-.1){
            iso_thread(m=screw_diam ,p=2 ,l=nh+5 ,t=LH);
            cylinder(d1=screw_diam+2,d2=screw_diam,h=.5);
            
            cylinder(h=1,d1=screw_diam-.5,d2=screw_diam+1.5);
        }
        

        for(n=[0:nd]) 
            rotate([0,0,n*360/nd]) 
            translate([-D/2,0,baseH+containerT-2]) 
            scale([1,2,1]) 
            //rotate([-5,0,0]) 
            cylinder(h=H+4,d=1.5,center=false);        
    }
}

module spool_holder_orig(){
h=21;
t=5;
nd=5;
id=40;
od=48;
bd=84;

*rotate([0,0,-18])
translate([-175,-175,0])
import("/home/hespanhol/3D Print/stl_files/Spinner_spool_holder_.stl");

    difference(){
        union(){
            cylinder(d=od,h=h);
            cylinder(d=bd,h=t);
        }
        //-------------------------------------
        translate([0,0,-.1])
        cylinder(d=35,h=h+1);
        
        fillet_r(f,bd/2);
        
        translate([0,0,h])
        mirror([0,0,1])        
        fillet_r(f,od/2);
        *fillet_r(f,id/2);
        
        for(n=[0:nd]) 
            rotate([0,0,n*360/nd]) 
            translate([-id,0,4.5]) 
            rotate([0,90,0]) 
            cylinder(h=24,d=4.1); 
    }
}

module support(){
w=200;
l=270;
h=20;
r=15;
r2=r/4;
t=1.6;
ss=40;

%translate([-w/2,-l/2,0])
rcube(w,l,t/2,15);
#cylinder(d=200,h=t);
    difference(){
        hull(){
            translate([w/2-r,-l/2+r,0])
            cylinder(r=r,h=h);            
            translate([w/2-r2-ss,-l/2+r2,0])
            cylinder(r=r2,h=h);
            
            translate([w/2-r2,-l/2+r2+ss,0])
            cylinder(r=r2,h=h);
        }
        //-------------------------------
        hull(){
            translate([w/2-r,-l/2+r,t])
            cylinder(r=r-t,h=h);            
            translate([w/2-r2-ss,-l/2+r2,t])
            cylinder(r=r2-t,h=h);
            
            translate([w/2-r2,-l/2+r2+ss,t])
            cylinder(r=r2-t,h=h);
        }
    }
}

module support_term(){
w=130;
p=30;
h=60;
t=3;
r=3;
vw=45;
vh=26;
    difference(){
        union(){
            vrcube(w,t,h,r);
            
            translate([0,-p-t,0])
            vrcube(w/2+t*2,p+t,h/3,r);
        }
        //-------------------------------
        translate([t,-p,t])
        rcube(w/2,p,h,.5);

        translate([w-vw-h/6,-t*2,h/2-vh/4])
        rcube(vw,t*4,vh,.5);
    }
}

module inside() {
    funnelD=holeD*2.5;
    funnelL=4;
    taper=spigotaddH;
    difference() {
        union() {
            //base
            cylinder(h=baseH,d=baseD,center=false);
            
            //containerInsert
            translate([0,0,baseH]) 
            cylinder(h=containerT,d=screw_outerdiam);
            
            //screw
            Tz(baseH-pitch)
            iso_thread(m=screw_diam ,p=2 ,l=spigotH+2 ,t=0);
            
        }
        //-----------------------------------------------
        fillet_r(f,D/2);
        
        translate([0,0,baseH])
        mirror([0,0,1])
        fillet_r(f/2,D/2);        
        
        translate([0,0,-overlap]) 
        cylinder(h=H*2,d=holeD,center=false);
        
        for(n=[0:nd]) 
            rotate([0,0,n*360/nd]) 
            translate([-D/2,0,-.1]) 
            scale([1,2,1]) 
            //Rx(10)
            cylinder(h=H+4,d=1.5,center=false); 
            
    }
}


module lid(){
    D=D-5;
    nh=nh+1.5;
    
    translate([0,0,lidh])
    difference() {
        union() {
            translate([0,0,baseH+containerT])
            cylinder(h=nh,d=D,center=false);
        }
        //--------------------------------------------
        translate([0,0,baseH+containerT])
        fillet_r(f,D/2);
        
        translate([0,0,baseH+containerT+nh])
        mirror([0,0,1])
        fillet_r(f/2,D/2);
        
        Tz(-pitch) 
        iso_thread(m=screw_diam ,p=2 ,l=spigotH+2 ,t=LH);
              
        nd=12;
        for(n=[0:nd]) 
            rotate([0,0,n*360/nd]) 
            translate([-D/2,0,baseH+containerT-2]) 
            scale([1,2,1]) 
            //rotate([-5,0,0]) 
            cylinder(h=H+4,d=1.5,center=false);        
    }
    
    translate([0,0,baseH+containerT])
    cylinder(d2=D-2,d1=D-2-lidh*2,h=lidh+.25, center=false);
}

module outside() {
    difference() {
        union() {
            translate([0,0,baseH+containerT])
            cylinder(h=nh,d=D,center=false);
        }
        //--------------------------------------------
        translate([0,0,baseH+containerT])
        fillet_r(f,D/2);
        
        translate([0,0,baseH+containerT+nh])
        mirror([0,0,1])
        fillet_r(f/2,D/2);
        
        Tz(-pitch) 
        iso_thread(m=screw_diam ,p=2 ,l=spigotH+2 ,t=LH);
        
        translate([0,0,nh+baseH-containerInsert+overlap]) 
        cylinder(h=containerT+containerInsert,d2=screw_outerdiam+2,d1=screw_diam,center=false);

        for(n=[0:nd]) 
            rotate([0,0,n*360/nd]) 
            translate([-D/2,0,baseH+containerT-2]) 
            scale([1,2,1]) 
            //rotate([-5,0,0]) 
            cylinder(h=H+4,d=1.5,center=false);        
    }
}

// ---- //
// Main //
// ---- //
if ( type == "test" ) {
    difference() {
        union() {
            inside();
            
            translate([0,0,1])
            color("#ccffcc")
            outside();
        }
        translate([0,-50,-.1]) 
        cube(100);
        translate([-100-.1,-50,-.1]) 
        cube(100);
    }
} else if ( type == "inside" ) {
    inside();
} else if ( type == "lid" ) {
    lid();
} else if ( type == "termsup" ) {    
    term_support();    
} else if ( type == "sup" ) {
    support();
} else if ( type == "holder" ) {
    spool_holder();
} else if ( type == "hcenter" ) {
    Tz(26) Rx(180)
    holder_center();
} else if ( type == "htop" ) {
    Tz(2.3) Rx(180)
    holder_top();
} else if ( type == "hbottom" ) {
    holder_bottom();
} else if ( type == "hretainer" ) {
    holder_retainer();
} else if ( type == "hnut" ) {
    Ry(180)
    holder_nut();
} else if ( type == "full" ) {
    inside();
    translate([baseD/2+D/2+3,0,-(baseH+containerT)])
    outside();
    if(LID){
        translate([-baseD/2-D/2-3,0,-(baseH+containerT)])
        lid();
    }
}


