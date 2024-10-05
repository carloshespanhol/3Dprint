use <../lib.scad>
$fn=100;

lineHeight = 0.28;
lineWidth = 0.56;

// Inside measures
width=40; 
length=7;
height=2;
thick=0.2;
thickbottom=lineHeight;
widthbottom=4;
cornerRadius=5;

/**************************/
l = multiple(length,lineWidth); 
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
t = multiple(thick,lineWidth);
tb = multiple(thickbottom,lineHeight);
wb = multiple(widthbottom,lineWidth);
cr=cornerRadius;

rotate([0,0,0]){
    
    /* Bridge */
    translate([0,0,h])
    scube(w+l*2,l,lineHeight);
    
    scube(l,l,h);
    
    translate([w+l,0,0])
    scube(l,l,h);

}    
