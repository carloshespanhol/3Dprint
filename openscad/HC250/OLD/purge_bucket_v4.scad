use <../lib.scad>
$fn=100;
cf=.4;  // Fit
cl=.3;  // Cleareance

ct=.3;  // Thread

lineHeigth=0.4;
lineWidth=0.8;

distance_back=52;
height=30;
length=30;
thick=2.5;
support_height=103;

sh=20;   // silicone height
sw=11;   // silicone width
st=2.5;  // silicone thick
cthick=1.5;    // canal thick
ch=15;   // canal height
clen=60; // canal length
ft=4.5;    // fixing thick
/************************************/
db=multiple(distance_back, lineHeigth);
l=multiple(length, lineHeigth);
h=multiple(height, lineHeigth);
t=multiple(thick, lineWidth);
suph=multiple(support_height+sh/4, lineHeigth);
cw=st+t;

/**
%translate([db-t/2-st,l/2+1,-sh/2])    cube([st,sw,sh]);    
%brush();
/**/
bucket();
vsupport();
//canal();


module canal(){
    difference(){
        union(){
            // bottom
            hull(){
                translate([-clen,-cthick,-clen-db-cthick-cl]) 
                scube(.1,l+cthick*2,cthick);
                
                translate([db-t*2,-cthick,-h-t*2-cthick-cl]) 
                scube(.1,l+cthick*2,cthick);
            }
            // left
            hull(){
                // back
                translate([-clen,-cthick-cl,-clen-db-cthick-cl]) 
                scube(.1,cthick,ch);
                //front
                translate([db-t*2,-cthick-cl,-h-t*2-cthick-cl]) 
                scube(.1,cthick,cthick);
                //upper
                translate([db/2+3.75,-cthick-cl,cl])
                scube(6,cthick,cthick);                
            }
            // right
            hull(){
                translate([-clen,l+cl,-clen-db-cthick-cl]) 
                scube(.1,cthick,ch);
                
                translate([db-t*2,l+cl,-h-t*2-cthick-cl]) 
                scube(.1,cthick,cthick);
                translate([db/2+3.75,l+cl,cl])
                scube(6,cthick,cthick);                
            }

            translate([db/2+3.75,-cthick,cl])
            scube(6,l+cthick*2,cthick);
        }
        
        translate([db/2+3.75+6, -l/2,-db]) cube([db,l*2,db*2]);
        
    }
}

module vsupport(){
    difference(){
        union(){
            cube([t,l,suph]);
            
            translate([0,0,suph-30])
            cube([ft,l,30]);
            
            /* profile insert
            translate([-6,0,suph-10-2.5])
            cube([6,l,5]);
            
            /* hook for garbage colecthickor
            translate([-t*2,0,0])
            cube([t*2,l,5+t]);

            /* reinforce */
            rs=db/2;
            translate([t,0,0])
            fillet(s=rs, t=t);

            translate([t,l-t,0])
            fillet(s=rs, t=t);
            
            // lateral
            cube([7,t*2,suph]);

            translate([0,l-t*2,0])
            cube([7,t*2,suph]);
        }
        /***************************/
        // hook for garbage colecthickor
        translate([-t,-.1,t])
        cube([t,l+1,10]);

        // M5 screws
        translate([10,l/2,suph-10])
        rotate([0,-90,0]) 
        cylinder(d=5.5, h=20);
        translate([10,l/2,suph-18.5])
        rotate([0,-90,0]) 
        cylinder(d=5.5, h=20);
        
        translate([-10,l/2-8,suph-20]) cube([10,16,20]);
        
        /**
        translate([t*2,l/3,suph*0.25]) 
        rotate([0,-90,0])
        rcube(suph/3,l/3,t*4,2);
        /**/
    }
}

module brush(){
    // brush
    translate([db-1.5, t+1.5, 0])
    rotate([0,-90,0])
    {
        cylinder(d=3, h=41);
        cylinder(d=5, h=6);
        
        difference(){
            cylinder(d=23, h=3.25);
            
            translate([-15,10,-1])
            scube(30,10,5);
        }
    }        
}    
module bucket(){
    // Bridge Support
    translate([db-cw, 0, -sh/2])  cube([cw,1,sh/2]);
    
    // brush support
    difference(){  
        translate([0,0,-5]) 
        scube(db-3, t*2+3, 5);
        
        brush();
    }
    
    difference(){        
        union(){
            // sfix
            hull(){ 
                translate([db-cw, 0, -h])
                cube([cw,l,.1]);
             
                translate([db-cw,0,0]) 
                cube([cw,l,.1]);
            }
            
            // bottom
            hull(){ 
                translate([db-t*2, 0, -h])
                intersection(){
                    rotate([-90,0,0])
                    semi_circle(d=t*4, h=l);
                    
                    translate([0,0,-h/2])
                    cube([t*2,l,h]);
                }
                
                translate([-clen,0,-clen-db]) 
                scube(.1,l,t);             
            }
            // left
            hull(){ 
                translate([-clen,0,-clen-db])
                scube(.1, t, t);
             
                translate([0,0,-h])
                scube(db, t, h);
            }
            // right
            hull(){ 
                translate([-clen,l-t,-clen-db])
                scube(.1, t, t);
             
                translate([0,l-t,-h])
                scube(db, t, h);
            }
        }
        
        /*************************************************/
        brush();
        translate([db-12,-1,-7]) scube(3.5,t*2,2);
        
        // silicone slot
        translate([db-t/2-st,l/2+1,-sh/2]) 
        cube([st,sw,sh]);    

        // Cuts
        // upper
        translate([-db-.1,-.1,0]) cube([db*3,l+1,db]);
        // back
        translate([-clen-1,-l/2,-db-clen]) cube([clen+1,l*2,db+clen+2]);
    }
}
        
        
        