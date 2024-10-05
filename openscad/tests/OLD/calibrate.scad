$fn=200;
/*
s=40;
t=.2;
b=20; // border distance
nl=20;
nb=5;

l=.6;
wd=3;    //wall distance
/**/


flow();

module flow(){
    s=50;
    h=10;
    t=1.2;
    lh=0.28;
    difference(){
        union(){
            cube([s,s,h]);
        }
        
        translate([t,t,lh])
        cube([s-t*2,s-t*2,h]);
        
        // center hole
        translate([s/4,s/4,-.1])
        cube([s/2,s/2,h]);

        // front mark
        translate([s/2,s/4,-.1])
        cylinder(d=s/8, h=h);
    }
}    

module calib(){
    overhang=1;
    a=30;
    y=s/2;
    difference(){
        union(){
            translate([-s/2,-y/2,0])
            cube([s,y,t*nb]);
            
            hull(){
                translate([-s/2,-y/2, t*nb])
                cube([s,y,.1]);
                
                translate([-s/2,-y/2, nl*t-t*nb])
                if(overhang==1){
                    cube([s,y+nl*t-.7, t*nb]);
                }else{
                    cube([s,y, t*nb]);
                }
            }
        }
        
        // 1mm
        translate([-s/3,-y/2*1.1, -1])
        rotate([45,0,90])
        oblong(3.5,1, nl*t*4);
        // 2mm
        translate([0,-y/2*1.1, -2])
        rotate([55,0,90])
        oblong(3.5,2, nl*t*4);
        
        // bridge test
        translate([-y/2, -y/4, -.1])
        oblong(y,y/2, (nl*t)/3);  
  
        // holes
        d1=3;
        d2=5;
        translate([-s/2+wd+d2/2,y/2-wd-d2/2,-1])
        polyhole(d=d1, h=y);
        translate([s/2-wd-d2/2,y/2-wd-d2/2,-1])
        polyhole(d=d2, h=y);
    }
}    

module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}
module oblong(len,width,height){
    translate([width/2,0,0])
    union(){
        hull(){
            translate([0,width/2,0]) cylinder(h=height, d=width);
            translate([len-width,width/2,0]) cylinder(h=height, d=width);
        }
    }
}