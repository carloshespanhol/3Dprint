$fn=100;

// Type: body, arm, both & test
//type="test";
//type="full";
type="print";

// Taper in/outlet for 3d filament
TAPER = false;

LID = false;

//Inner hole diameter
holeD=4.5; // 1.75mm PLA (2.2 works for PLA)

// Diameter & Height of nut
D=18;
H=11;
nh=5;    //nut height

//Base height & size
baseH=2;
baseD=D*1.5;

// Thickness of container
containerT=0.6;
containerInsert=2;

//Hight of screw above nut 
spigotaddH=4;
spigotH=H+spigotaddH;

space = 0.1;
overlap = 0.01;

// Screw thread
//==============
LH = 0.3;
fh = 0.2; //LH*1;
th = LH*4;
pitch = 2*(fh+th);

// Screw
//==============
screw_diam=7;
screw_outerdiam=screw_diam+th*2+space*2;
screw_height=30;
echo(str("External diameter: ",screw_outerdiam));

// Body
//==============
footlen = 15;
footh   = 5;
bodysize= screw_outerdiam + 8;

// Screw polyhedron
//=================
faces = [ [0,1,2], [0,2,3], [0,3,4], [4,3,7], [3,2,7], [2,6,7], [2,1,5], [2,5,6], [4,7,5], [7,6,5], [0,4,5], [0,5,1] ];

//taper: Start, End, Both or None
module screw(minordiam = 10, neg=false, taper="N", resolution=60, sheight=30 ) {
    
    tapersteps = 10;
    $fn=resolution;
    dtheta=360/resolution;
    // Negative
    z_adj   = neg ? LH*(sqrt(2)-1) : 0;
    rad_adj = neg ? LH : 0;
    len_adj = neg ? overlap : 0;
    
    radmin=minordiam/2 + rad_adj;
    radmaj=radmin+th + rad_adj;
    steps=360/dtheta*(sheight-pitch)/pitch;
    zstep=dtheta*pitch/360;
    zheight=th*2+fh + 2*z_adj;
    
    translate([0,0,-len_adj]) cylinder(h=sheight+len_adj*2, r=radmin+1/128, center=false);
    
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

module chamfer0(top_rad,base_rad,base_hgt,nr_steps=10, sc=2) {
    R=base_rad-top_rad;
    astep=90/nr_steps;
    translate([0,0,-base_hgt]) cylinder(h=base_hgt+overlap,r=base_rad,center=false);
    scale([1,1,sc]) for(i=[0:nr_steps-1]) {
        ang=i*astep;
        rr0=base_rad-R*sin(ang);
        rh0=R-R*cos(ang);
        rtop_rad=base_rad-R*sin(ang+astep);
        rh1=R-R*cos(ang+astep);
        //echo(rr0,rh0,rtop_rad,rh1);
        translate([0,0,rh0]) cylinder(h=rh1-rh0+overlap,r1=rr0,r2=rtop_rad,center=false);
    }
}

module chamfer(chH,chW,chBaseH,chInR) {
    rotate_extrude(angle=360,convexity=4) chamfer2D(chH=chH,chW=chW,chBaseH=chBaseH,chInR=chInR);
}


module chamfer2D(chH,chW,chBaseH,chInR) {
    overlap=0.01;
    $fn=64;
    translate([0,chBaseH]) scale([1,chH/chW]) union() {
        square([chInR+overlap,chW],center=false);
        translate([chInR,0]) difference() {
            square(chW,center=false);
            translate([chW,chW]) circle(r=chW);
        }
    }
    square([chInR+chW,chBaseH+overlap],center=false);
}

module inside() {
    funnelD=holeD*2.5;
    funnelL=4;
    taper=spigotaddH+2;
    difference() {
        union() {
            //base
            cylinder(h=baseH,d1=baseD-containerT*4,d2=baseD,center=false);
            translate([0,0,baseH-containerT-overlap]) cylinder(h=containerT+containerInsert,d1=screw_outerdiam+2,d2=screw_diam,center=false);
            intersection() {
                union() {
                    cylinder(h=spigotH-taper/2+overlap,d=screw_outerdiam,center=false);
                    difference() {
                        translate([0,0,spigotH-taper/2]) cylinder(h=taper,d1=screw_outerdiam,d2=holeD*( TAPER ? 1 : 0.5),center=false);
                        translate([0,0,spigotH*1.5]) cube(spigotH,center=true);
                    }
                }
                screw(minordiam = screw_diam, taper="N", sheight=spigotH+10);
            }
        }
        union() {
                translate([0,0,-overlap]) cylinder(h=spigotH+overlap*2,d=holeD,center=false);
            if ( TAPER ) union() {
                translate([0,0,spigotH+2]) mirror([0,0,1])  chamfer(chH=funnelD*1.5,chW=funnelD/2,chBaseH=1,chInR=holeD/2-overlap*2);
                translate([0,0,-1.2]) chamfer(chH=funnelD*1.5,chW=funnelD*0.75,chBaseH=1,chInR=holeD/2-overlap*2);
            }
        }
    }
}


module lid(){
    translate([0,0,baseH])
    outside();
    
    translate([0,0,baseH+containerT])
    cylinder(d=D,h=baseH);
}

module outside() {
    difference() {
        union() {
            translate([0,0,baseH+containerT])
            cylinder(h=nh,d=D,center=false);
        }
        union() {
            translate([0,0,-pitch]) 
            screw(neg=true,minordiam = screw_diam, taper="N", sheight=nh*2+pitch*2);
            translate([0,0,baseH-overlap]) cylinder(h=containerT+containerInsert,d1=screw_outerdiam+2,d2=screw_diam,center=false);
            for(n=[0:11]) 
                rotate([0,0,n*360/12]) 
                translate([-D/2,0,baseH+containerT-2]) 
                scale([1,2,1]) 
                rotate([-5,0,0]) 
                cylinder(h=H+4,d=1.5,center=false,$fn=3);
        }
    }
}

// ---- //
// Main //
// ---- //


if ( type == "test" ) {
    difference() {
        union() {
            inside();
            outside();
        }
    translate([0,-50,0]) cube(100,center=true);
    }
} else if ( type == "full" ) {
    union() {
        inside();
        outside();
    }

} else {
    inside();
    translate([baseD/2+D/2+3,0,-(baseH+containerT)])
    outside();
    if(LID){
        translate([-baseD/2-D/2-3,0,-(baseH+containerT)])
        lid();
    }
}


