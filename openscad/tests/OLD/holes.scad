use <../lib.scad>
$fn=100;

lineHeight = 0.28;
lineWidth = 0.88;

height=1.5;
w = 15; 
l=125;

h = multiple(height,lineHeight);
t=5;
echo(h);
echo(h/lineHeight);

difference(){
    union(){
        roundCube(l,w,2,2);
    }    
    for(i = [3 : .2 : 6]){
        translate([-115+40*i,w/2,-.1])
        cylinder(d=i, h=10);
        if( (i  - floor(i)) < 0.1 ){
            translate([-115+40*i,w/2,h-lineHeight])
            cube([1,10,h])
            echo( i  );
        }
    }
}   