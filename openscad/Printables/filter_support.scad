use <../lib.scad>

intLen=35;
w=15;
h=10;

lineWidth=0.68;
lineHeight=0.28;
s=0.68;

t=3*lineWidth;
l=intLen+t;

translate([0,0,h])
rotate([-90,0,0]){
support();
translate([0,h-t,0])
hinge();
}

module support(){
    difference(){
        nccube(l,h,w);

        translate([-.1,-t,-.1])
        nccube(l+1,h,w+1);
        
        translate([0,h-t,w/3+w/6])
        ccube(4+t,5,w/3+2*s);

        translate([0,h-t,-0.01])
        zcylinder(1+t,w+1);
    }  
}

module hinge(){
    
    difference(){
        zcylinder(2*t,w);

        translate([0,0,w/3+w/6])
        ccube(3+t,5,w/3+2*s);

        translate([0,0,-0.01])
        zcylinder(1,w+1);
    }
    
    difference(){    
        union(){
            translate([-h,0,0])
            nccube(h,t,w);

            translate([0,0,w/3])
            zcylinder(2*t,w/3);
        }
        
        translate([0,0,w/6])
        ccube(3+t,5,w/3+0.01);
        translate([0,0,w-w/6])
        ccube(3+t,5,w/3+0.01);

        translate([0,0,-0.01])
        zcylinder(1,w+1);
    }
}

