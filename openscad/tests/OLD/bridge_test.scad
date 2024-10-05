use <../lib.scad>
$fn=100;

lineHeight = 0.20;
lineWidth = 0.44;

// Inside measures
width=50; 
length=10;
depth=12;
height=2;
thick=0.2;
thickbottom=lineHeight;
widthbottom=4;
cornerRadius=5;

/**************************/
x = multiple(length,lineWidth); 
y = multiple(depth,lineWidth); 
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
t = multiple(thick,lineWidth);
tb = multiple(thickbottom,lineHeight);
wb = multiple(widthbottom,lineWidth);
cr=cornerRadius;
bh=0.28+lineHeight;

difference(){
    union(){
        /* Bridge */
        translate([0,0,h])
        scube(w+x*2,y,bh);
        
        scube(x,y,h);
        
        translate([w+x,0,0])
        scube(x,y,h);
    }
    
    // Cut
    translate([w+x*1.3+1,y+1,-.1])
    rotate([0,0,-45])
    scube(x,y,h*2);
    
}    
