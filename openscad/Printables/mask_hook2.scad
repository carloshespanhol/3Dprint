use <../lib.scad>
$fn= 100;

fatiador= 0;
x=25; //180;
nh=2;
y=15;
t=.68;
h=3;
hole=6;


/* Fatiador */
lineHeight = 0.2;
firstlayer = 0.24;
fatias = multiple(h,lineHeight)/lineHeight;
if(fatiador){
    for(i=[0:fatias]){
        if(i % 2){
            translate([-l,-w,firstlayer+i*lineHeight])
            %cube([l*2,w*2, lineHeight]);
        }
    }    
}


mask_hook();

module hook(){
    translate([x-y, -y/4, 0]){
        hull(){
            translate([0,h/2,t+.2])
            rcube(1.2, y/2-h, .1, .3);  
            
            translate([-h/2-.2,0,h-.6])
            rcube(1.75, y/2, .1, .3);  
        }
 
        hull(){
            translate([0,h/2,0])
            rcube(1.6, y/2-h, .1, .3);  
            
            translate([0,0,h])
            rcube(1.6, y/2, .1, .3);  
        }
    }    
}

module mask_hook(){
    difference(){
        union(){
            hull(){
                cylinder(d=y, h=t);

                translate([x-y, 0, 0])
                cylinder(d=y, h=t);
            }
            
            for (i = [0:nh-1]){
                translate([-i*10,0,0])
                hook();   
            } 
        }
      
        if(x>25){
            translate([0,0,-.1])
            cylinder(d=hole, h=t+1);
        }
        
        translate([-x/2, -y/2,-10])
        scube(x*2, y*2, 10);

        translate([-x/2, -y/2, 2])
        scube(x*2, y*2, 50);
    }
}    
