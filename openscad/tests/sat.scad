use <../lib.scad>
$fn=200;

lw=1;
/*
Size:
50mm/s - 60
*/
sy = 50;  
sx = 50;
hz = 8;
tk = sx * .1;
dh = 2.5;
wh1 = 1.5;
wh2 = 10;
di = 2.5;
do = 2.5;
a=6;    // amplitude
letter_size = 5;


difference(){
    union(){
        hull(){
            scube(tk,sy,hz);
            scube(sx,tk,hz);
        }
        // curves out
        for (i = [0,1,4]){
            rotate([0,0,45])
            translate([sx*0.78+a/2,i*(di+do)+(di+do)/2-sy/3,0]){
                cylinder(d=do,h=hz);
                
                translate([-a,-do/2,0])
                cube([a,do,hz]);
            }
        }
        // letter X
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
    
    
    // curves in
    for (i = [0,1]){
        rotate([0,0,45])
        translate([sx*0.77-a/2,i*(di+do)-sy/3,-.1]){
            cylinder(d=di,h=hz+1);
            translate([0,-di/2,0])
            cube([a,di,hz+1]);
        }
    }
    // x holes
    translate([sx/6,-.1,hz/2])
    hull(){
        scube(wh1,.1,hz);
        translate([0,0,dh])
        scube(wh1,dh,hz);
    }
    translate([sx/3*2-wh2,-.1,hz/2])
    hull(){
        scube(wh2,.1,hz);
        translate([0,0,dh])
        scube(wh2,dh,hz);
    }
    // y holes
    translate([-.1,sy/6,hz/2])
    hull(){
        scube(.1,wh1,hz);
        translate([0,0,dh])
        scube(dh,wh1,hz);
    }
    translate([-.1,sy/3*2-wh2,hz/2])
    hull(){
        scube(.1,wh2,hz);
        translate([0,0,dh])
        scube(dh,wh2,hz);
    }
    // x chamfer
    translate([sx-hz/2,-.1,hz])
    rotate([0,45,0])
    scube(sx/2,sy/2,hz);    
    // y chamfer
    translate([-.1,sy-hz/2,hz])
    rotate([-45,0,0])
    scube(sx/2,sy/2,hz);    
} 
