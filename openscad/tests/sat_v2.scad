use <../lib.scad>
$fn=200;

lw=0.72;
/*
Size:
50mm/s - 60
*/
sy = 80;  
sx = 80;
hz = 8;
tk = sx * .1;
dh = 3;
wh1 = 2;
wh2 = 10;
di = 4;
do = 3;
a=5;    // amplitude
letter_size = 5;


difference(){
    union(){
        hull(){
            scube(tk,sy,hz);
            scube(sx,tk,hz);
        }
        // curves out
        for (i = [0,1,2]){
            rotate([0,0,45])
            translate([sx*0.78+a/2,i*(di+do)+(di+do)/2-sy/3,0]){
                cylinder(d=do,h=hz/2);
                
                translate([-a,-do/2,0])
                cube([a,do,hz/2]);
            }
        }
        /* halfcurve out
        rotate([0,0,45])
        translate([sx*0.78+a/2,5*(di+do)-sy/3, 0]){
            cylinder(d=do,h=hz/2);
            
            translate([-a,-do/2,0])
            cube([a,do,hz/2]);
        }

        /* letter X */
        translate([3, lw/2, 1.5])
        rotate([90,0,0])
        linear_extrude(height = lw)
        text("X", size = letter_size, font="Arial:style=Bold");
        // letter Y
        translate([-lw/2, 3, 1.5])
        rotate([90,0,90])
        linear_extrude(height = lw)
        text("Y", size = letter_size, font="Arial:style=Bold");
    }
    
    // semi circle
    difference(){
        translate([sx/4, sy/2, -1.5])
        rotate([0,90,45])
        cylinder(r=hz, h=sx);
        
        scube(sx,sy,2);
    }
    
    // inner cut
    m=sx/3;
    translate([lw*4+5, lw*4+5, -.1])
    hull(){
        scube(tk, sy-m, hz+1);
        scube(sx-m, tk, hz+1);
    }
    
    /* cut
    translate([sx/3, sy/2, hz/2+1])
    rotate([0,0,45])
    cube([20,wh2,hz]);
    
    /* curves in */
    for (i = [0,1,2]){
        rotate([0,0,45])
        translate([sx*0.77-a/2,i*(di+do)-sy/3,-.1]){
            cylinder(d=di,h=hz+1);
            translate([0,-di/2,0])
            cube([a,di,hz+1]);
        }
    }
    
    /* half curve in *
    rotate([0,0,45])
    translate([sx*0.77-a/2,5*(di+do)-sy/3,hz/2]){
        cylinder(d=di,h=hz+1);
        translate([0,-di/2,0])
        cube([a,di,hz+1]);
    }

    /* x holes */
    translate([sx/6+2,-.1,hz/2])
    rotate([0,180,0])
    hull(){
        scube(wh1,.1,hz);
        translate([0,0,dh])
        scube(wh1,dh,hz);
    }
    translate([sx/3*2,-.1,hz/2])
    rotate([0,180,0])
    hull(){
        scube(wh2,.1,hz);
        translate([0,0,dh-1])
        scube(wh2,dh,hz);
    }
    // cut
    translate([sx/2-wh2,-.1,hz/2+1])
    scube(wh2,sy/4,hz);
    
    // y holes
    translate([-.1,sy/6+2,hz/2])
    rotate([180,0,0])
    hull(){
        scube(.1,wh1,hz);
        translate([0,0,dh])
        scube(dh,wh1,hz);
    }
    translate([-.1,sy/3*2,hz/2])
    rotate([180,0,0])
    hull(){
        scube(.1,wh2,hz);
        translate([0,0,dh-.5])
        scube(dh,wh2,hz);
    }
    // cut
    translate([-.1,sy/2-wh2,hz/2+1])
    scube(sx/4,wh2,hz);

    // x chamfer
    translate([sx-hz,-.1,hz])
    rotate([0,30,0])
    scube(sx/2,sy/2,hz);    
    // y chamfer
    translate([-.1,sy-hz,hz])
    rotate([-25,0,0])
    scube(sx/2,sy/2,hz);    
} 
