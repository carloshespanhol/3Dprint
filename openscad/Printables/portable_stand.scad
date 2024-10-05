use <../lib.scad>
$fn=100;

lineHeight = 0.28;
lineWidth = 0.88;

length=35;
width=25; 
height=15;

pw=11; // phone width Samsung
//pw=9;   // phone width iphone 6
t=5;     // min. thickness

/**************************/
l = multiple(length,lineWidth); 
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
echo(w);
echo(h);

rotate([0,0,0]){
difference(){
    rotate([0,0,0]){
        /* Sacrifice bridge *
        translate([w,ch-t,0])
        nccube(lineWidth+0.01,w,h);            
        /**/
        difference(){
            union(){
                translate([0,0,0])
                roundCube(l,h,w,4);

                translate([0,-h*1.5,0])
                roundCube(l/2,h*2.5,w,4);

                translate([0,0,0])
                nccube(10,h,w);
                hull(){
                }
            }
            /**/
            // Phone slot
            translate([l/4,-h*2-t/2,-.1])
            rotate([0,0,-15])
            nccube(pw,h*3,w+1);

            // Hole
            dist=multiple(3,lineWidth)+t/2;
            translate([dist,h-dist,-.1])
            cylinder(d=t,h=w+1);
        }
    }    
}
}