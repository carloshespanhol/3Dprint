$fn=100;

size=25;
numsteps=5;
step=size/numsteps;
line_height=0.32;
echo(step);

step_cube();

module step_cube(){
    difference(){
        union(){
            //steps
            for(i=[1:numsteps-1]){
                translate([-size+step*i,0,0])
                cube([size,size-step,i]);
            }
    
            difference(){
            for(i=[0:numsteps-1]){
                translate([step*i,0,0]) cube([size-step*i,size-step*i,step*(i+1)]);
            }
            
        translate([-step/2,size-step,-.1]) rotate([0,0,45]) 
        cube([step*2,step,step+1]);
            }
        
            // polls
            translate([-size+step,0,0])
            cube([step,step,size]);
            translate([size-step,size-step,0]) cube([step,step,size]);
            translate([step/2,size-step/2,0]) cylinder(d=step, h=size);
            
            // bridges
            translate([-size+step,0,size-step/2]) cube([size*2-step,step,step/2]);
            translate([size-step,0,size-step/2]) cube([step,size,step/2]);
            hull(){
                translate([size-step+1.4,0,size-step/2+line_height]) 
                rotate([0,0,45])
                cube([step,step,step/2-line_height]);

                translate([step/2,size-step/2,size-step/2+line_height]) 
                cylinder(d=step, h=step/2-line_height);
            }
        }

        
        // bridge
        translate([step*1.5,-.1,-.1]) cube([step,step,step]);
        
        // cylinder
        translate([step*1.5,size-(step*1.5),-.1]) cylinder(d=step*2, h=step/2);
        // vertical cylinder
        translate([size-step,-.1,step*2]) rotate([-90,0,0]) cylinder(d=step, h=step);
        
        // Angle test
        hull(){
            // 45deg
            translate([size-step+.1,size-step,-.1])
            rotate([45,0,0]) 
            cube([step,.1,step]);   
            
            /* 55deg */
            translate([size-step+.1, size-step-sin(45)*step,cos(45)*step]) 
            rotate([55,0,0]) 
            cube([step,.1,step]);
            
            /* 90deg */
            translate([size-step+.1,step/2,-.1]) 
            cube([step,.1,cos(45)*step+cos(55)*step+.15]);
            /**/
        }
    }
}
