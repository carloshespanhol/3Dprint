$fn=100;

iw=48.5;
ow=65;
oh=2;
h=60;
t=2;

hh=15;
hl=47;
hw=26;

gw=3;   // grid width
lw=4;   // lock width


support();


module support(){
    difference(){
        union(){            
            cylinder(d=ow, h=oh);
            cylinder(d=iw, h=h);
        }


        // silica
        translate([0,0,hh+t*3])
        cylinder(d=iw-t*2, h=h);
        
        // hygrometer
        translate([-hl/2,-hw/2,-.1])
        cube([hl,hw,hh]);
        translate([-hl/2-1,-hw/2, 3])
        cube([hl+2,hw,hh]);
        
        /* grid
        for (i = [0:6:hl-6]) {
            translate([-hl/2+4+i,-hw/2,0])
            cube([gw,hw,h/2]);
        }       
        /**/
        for(i=[0:30:360]){
            rotate([0,0,i])
            translate([-gw/2,0,h/2])
            cube([gw,ow/2,hh]);
        }
    }    
    
    /* Lock */
    difference(){
        union(){            
            translate([0,0,h-lw])
            cylinder(d=iw, h=lw);
        }
        /**/
        hull(){
            translate([-iw/2, -lw*1.5, h-lw-.1])
            cube([iw,lw*3,.2]);
            
            translate([-iw/2, -lw, h-.1])
            cube([iw,lw*2,.2]);
        }
        
        translate([0,0,h-lw-.1])
        cylinder(d1=iw-t*2, d2=iw-t*2-lw*2, h=lw+.2);
    }    
}
