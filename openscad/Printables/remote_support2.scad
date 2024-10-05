use <../lib.scad>
$fn=100;

lineHeight = 0.20;
lineWidth = 0.88;

// Inside measures
width=55; 
length=31;
height=80;
thick=1.5;
thickbottom=2;
widthbottom=6;
cornerRadius=5;

/**************************/
l = multiple(length,lineWidth); 
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
t = multiple(thick,lineWidth);
tb = multiple(thickbottom,lineHeight);
wb = multiple(widthbottom,lineWidth);
echo(w);
echo(t);

nccube(w*2+t*3,100,tb);

translate([0,-l-t,h])
mirror([0,0,1]){
    difference(){
        translate([w-t,0,0]) nccube(10,5,h);

        /* inner */
        translate([t,t,tb])
        roundCube(w,l,h,cornerRadius-t);
        
        translate([w,t,tb])
        roundCube(w,l,h,cornerRadius-t);
    }

    support();
    translate([w+t,0,0]) support();
}

module support(){
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
                    roundCube(w+t*2,l+t*2,h,cornerRadius);

                    translate([0,l/2,0])
                    nccube(w+t*2,l/2+t*2,h);
                }
                /**/
                // inner
                translate([t,t,tb])
                roundCube(w,l,h,cornerRadius-t);
                // front
               // translate([10+t,-.1,h/3*2]) nccube(w-20,t*4,h);                
                // bottom
                translate([wb+t,wb+t,-lineHeight])
                roundCube(w-wb*2,l-wb*2,tb,cornerRadius);
            }
        }    
    }
    }
}