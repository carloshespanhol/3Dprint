use <../lib.scad>
$fn=200;

lineHeight = 0.28;
lineWidth = 0.88;

length=60;
width=30; 
height=60;

base_length=35;
base_height=15;

pw=11; // phone width Samsung
//pw=9;   // phone width iphone 6
t=5;     // min. thickness

/**************************/
l = multiple(length,lineWidth); 
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);

bl = multiple(base_length,lineWidth); 
bh = multiple(base_height,lineHeight);
echo(w);
echo(h);

//translate([l/2+1,-w/2-35, 7]) rotate([0,-105,0]) %roundCube(140,70,pw,5);

//rotate([90,0,0])
{
    /* Sacrifice bridge *
    translate([w,ch-t,0])
    nccube(lineWidth+0.01,w,h);            
    /**/
    difference(){
        union(){
            translate([0,0,0])
            rcube(bl,bh,w,4);
/*
            translate([0,-h*1.5,0])
            roundCube(l/2,h*2.5,w,4);
*/
            difference(){
                translate([-l*0.6,0,0])
                rotate([0,0,-30])
                rcube(l*.8,h*1.2,w,6);

                translate([bl/2,bh/2,-.1])
                rcube(bl,h,w+1,4);
            }
        }
        /**/
        // Phone slot
        translate([bl-pw-5,5,-.1])
        rotate([0,0,15])
        scube(pw,h,w+1);
        translate([bl-pw-4,bh,-.1])
        rotate([0,0,15])
        scube(l,h,w+1);

        //  X axis
        translate([-l,-h,-.1])
        scube(l*2,h,w*2);    

            
        // Hole
        translate([2,0,0])
        hull(){
            translate([-(l-bl)/3,0,-.1])
            cylinder(d=40,h=w+1);
            translate([-3.5,38,-.1])
            cylinder(d=10,h=w+1);
        }
    }
}    
