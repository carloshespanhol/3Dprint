$fn=100; // recomended value for smooth circle is 60
h=12;

/* ----- execute ----- */

bp=7;
dx=40;
dy=5;
lw=.44; //lineWidth



difference(){
    union(){
        translate([-dx, 2.5, 1])
        cube([dx+15, bp, 1]);

        translate([-dx/2, bp+2.5-lw*2, 1])
        cube([2.5, lw*2, h-3]);
        translate([-dx/4*3, bp+2.5-lw*2, 1])
        cube([2.5, lw*2, h-3]);

        translate([-dx/2, 2.5, 1])
        cube([2.5, lw*2, h-3]);
    
        if(h>10){
            translate([-dx/4*3, bp+2.5-lw*2, h-4])
            cube([dx/4, lw*2, 2]);
        }
        translate([-dx/4*3, bp+2.5-lw*2, 3])
        cube([dx/4, lw*2, 2]);

        translate([-dx/4*3, 2.5, 1])
        cube([lw*2, bp, h-3]);
        translate([-dx/4*3.5, 2.5, 1])
        cube([lw*2, bp, h-3]);
    }
    
    
    translate([-dx/3, 2, 0])
    cube([dx+15, bp+1, 5]);
        
}

