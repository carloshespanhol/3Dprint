use <../lib.scad>
$fn=100;

lineWidth=0.68;
lineHeight=0.28;

cd=70;  // Can diameter
w=100;
h=cd/4*3;
t=20*lineHeight;
echo(t);
l=cd*3+2*t;

difference(){
    ccube(w,l,h);
    
    translate([-0.01,0,cd/2+t])
    ccube(w+1,3*cd,h);
    translate([-0.01,0,t])
    ccube(w+1,2*cd,h);

    translate([-w/2-0.1,0,(cd-h)/2+t]){
        xcylinder(cd,w+1);
        translate([0,cd,0])
        xcylinder(cd,w+1);
        translate([0,-cd,0])
        xcylinder(cd,w+1);
    }
    
    translate([-w/4,-l/4,-cd])
    roundCube(w/2,l/2,cd*2,10);
}
