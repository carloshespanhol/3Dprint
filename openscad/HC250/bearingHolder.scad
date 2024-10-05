$fn=150;

box_height=240;
tipo=1;

//Diametro Carretel 1Kg 
d1=205;
//Diametro Carretel 0.5Kg 
d05=160;
// 80, 100, 65, 85, 100, 70
dist=155;

bearingDiameter=22;
bearingWidth=7;
bearingHole=8;

//Cap
extra_width=5;
inner_flat=1;
outer_flat=0.2;

tolerance=0; // fit
thickness=1.2;
space=12;
axisDiameter=8;

footHeight=25;
wallWidth=5;

Pin_Height=10;

/* 500g 3DRojo *
spoolInnerDiameter = 30;
Holder_Height=60;
Holder_Border=1.8;

/* 1Kg 3DFila */
spoolInnerDiameter = 40;
Holder_Height=80;
Holder_Border=4;
/***************************************/
hh=Holder_Height;
ph=Pin_Height;
hb=Holder_Border;
sid=spoolInnerDiameter-hb*2;

s=space;
ad=axisDiameter;
tol=tolerance;
t=thickness;

bd=bearingDiameter;
bw=bearingWidth;
bh=bearingHole;
ew=extra_width;
inf=inner_flat;
of=outer_flat;

fh=footHeight;
ww=wallWidth;

    
/* Box Height *
translate([0, -dist/2, box_height])
#cube([hh*2,dist,.5]);

/* carretel *
translate([bw/2+.5, -15, d1/2+34])
%rotate([0,90,0]) 
cylinder(d=d1, h=75);

/* Axis *
%translate([-15,-dist/2, 40])
rotate([0,90,0])
cylinder(d=ad, h=200);
%translate([-15,dist/2, 70])
rotate([0,90,0])
cylinder(d=ad, h=200);

/* Holder*
translate([0,-dist/2, 40])
rotate([0,90,0])
/**
difference(){
holder();

*translate([-20,-20,-1])
cube([40,20,100]);    
}    
/*
translate([0,dist/2, 70])
rotate([0,90,0])
holder();



/**
translate([sid/2+30,-10,0])
washer();
translate([sid/2+15,-10,0])
pin();
/**
*translate([sid/2+30,10,0])
washer();
*translate([sid/2+15,10,0])
pin();


/* Bearing cap *
cap();
/**
translate([-80,-15,0]){
translate([-bh, bd, 0]) spacer();
translate([ bh, bd, 0]) spacer();
}
/**/
translate([-5,15,0])
//rotate([0,-90,0]) 
foot();
/**
mirror([1,0,0])
translate([40,10,0])
rotate([0,0,-90]) 
foot();

/**/
/**
translate([bw/2,dist/2, d05/2-2])
%rotate([0,90,0]) cylinder(d=d05, h=80);
/**/

module foot(){
    difference() {
        union() {
            // front
            translate([40,-dist/2,0])
            cylinder(d=spoolInnerDiameter, h=ww);
            // back
            translate([70,dist/2,0])
            cylinder(d=spoolInnerDiameter, h=ww);
            *hull(){
                // front
                translate([40,-dist/2,0])
                cylinder(d=sid-10, h=ww);
                // back
                translate([70,dist/2,0])
                cylinder(d=sid-10, h=ww);
            }

            // bottom
            hull(){
                translate([0,-dist/2-15,0])
                rcube(40+ad/2,30,ww,5);
                translate([0,dist/2-20,0])
                rcube(70+ad,33,ww,5);
            }
            // reinforce
            color("grey")
            hull(){
                translate([40,-dist/2+spoolInnerDiameter/2, 0])
                cylinder(d=ad, h=10);
                translate([65,dist/2-spoolInnerDiameter/2, 0])
                cylinder(d=ad, h=10);
            }
            color("grey")
            {
                translate([0,-dist/2-15,0])
                rcube(27,10,10,5);
                translate([0,dist/2+3,0])
                rcube(55,10,10,5);
            }

            // feet
            color("grey")
            hull(){
                h=20;
                translate([0,-dist/2-15,0])
                rcube(10,30,h,5);
                translate([0,dist/2-20,0])
                rcube(10,33,h,5);
            }            
        }
        //------------------------------
        translate([-dist/4-5,0,-.1])
        cylinder(d=dist+10, h=50);
        
        // Hole
        difference(){
            translate([7,dist/2-42,-.1])
            rcube(40,40,20,5);
            
            translate([-dist/4-5,0,-.1])
            cylinder(d=dist+42, h=50);
        }
        
        /* Axis */
        translate([40,-dist/2, -.1])
        cylinder(d=ad, h=20);
        translate([70,dist/2, -.1])
        cylinder(d=ad, h=20);
    }    
}

module holder(){
    th=6;
    
    /* Bridge */
    if(tipo==1){
        translate([0, 0, bw])
        cylinder(d=bd, h=.2);

        translate([0,0,hh-5])
        cylinder(d=bd, h=.32);        
    }
    
    /**/
    difference() {
        union() {
            cylinder(d=sid, h=hh+hb*2);
            
            if(tipo==1){
                z=.4;
                cylinder(d=spoolInnerDiameter, h=z);
                translate([0,0,z])
                cylinder(d2=sid, d1=sid+hb*2, h=hb-z);
                
                translate([0,0,hh+hb*2-z])
                cylinder(d=sid+hb*2, h=z);
                translate([0,0,hh+hb])
                cylinder(d1=sid, d2=sid+hb*2, h=hb-z);
            }else{
                rotate_extrude( angle=360)
                translate([sid/2-hb/2,0,0])
                circle(hb);
                
                translate([0,0,hh+hb*2])
                rotate_extrude( angle=360)
                translate([sid/2-hb/2,0,0])
                circle(hb);
            }
        }

        // inner hole
        if(tipo==1){
            
            translate([0,0,7+th])
            cylinder(d=sid-2.4*2, h=hh-6-2*th);
        
            cylinder(d=(bd+bh)/2+1, h=hh*2);            
        }
        translate([0,0,hh+hb*2-bw-4])
        cylinder(d=(bd+bh)/2+1, h=bw*2);
        translate([0,0,-.1])
        cylinder(d=(bd+bh)/2+1, h=bw+4);

        // bearing hole
        translate([0,0,hh+hb*2-bw])
        cylinder(d=bd+tol, h=bw+.1);
        translate([0,0,-.1])
        cylinder(d=bd+tol, h=bw+.1);
        
        // upper and lower cut
        translate([-sid,-sid,hh+hb*2])
        cube([sid*2,sid*2,hb*2]);
        translate([-sid,-sid,-hb*2])
        cube([sid*2,sid*2,hb*2]);
        
        /*cut*
        translate([-sid, -sid, 20])
        cube([sid*2, sid*2, hh*2]);
        /**/
    }    
}


module washer(){
    t=2.4;
    
    difference() {
        union() {
            
            cylinder(d=bh+t*2, h=2);
        }

        translate([0,0,-.1])
        polyhole(d=bh, h=ph+bw+t*2);
    }
}

module pin(){
    t=2;
    
    difference() {
        union() {
            cylinder(d=bh, h=ph+bw+t*2);
            
            cylinder(d=bh+t*2, h=t);
        }
    }
}

module spacer(){
    difference() {
        union() {
            cylinder(d1=bh+t*4, d2=bh+t*2+1, h=s/2);
        }
        
        translate([0,0,-.1])
        cylinder(d=ad+tol, h=s);
    }    
}

module cap(){
    difference() {
        union() {
            cylinder(d=bd+t*2, h=bw+ew);
            
            // outer flat
            cylinder(d=bd+t*2+bw, h=of);
            translate([0,0,bw+ew-of])
            cylinder(d=bd+t*2+bw, h=of);
            
            //
            translate([0,0,of])
            cylinder(d1=bd+t*2+bw, d2=bd+t*2, h=(bw+ew)/2-inf/2-of);  
            
            translate([0,0,(bw+ew)/2+inf/2])
            cylinder(d2=bd+t*2+bw, d1=bd+t*2, h=(bw+ew)/2-inf/2-of);
        }
        
        translate([0,0,ew/2])
        cylinder(d=bd+tol, h=bw+ew+1);
        
        translate([0,0,-.1])
        cylinder(d=bd-4, h=bw+ew+1);
    }
}


module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}
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
