use <../lib.scad>
$fn=100;

lineHeight = 0.20;
lineWidth = 0.80;

// Inside measures
width=60; 
length=30;
height=6.5;
thick=lineWidth*2;
thickbottom=lineHeight;
widthbottom=4;
cornerRadius=5;

/**************************/
l = multiple(length,lineWidth); 
w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
t = multiple(thick,lineWidth);
tz = lineHeight;
wb = multiple(widthbottom,lineWidth);
cr=cornerRadius;

rotate([0,0,0]){
difference(){
    rotate([0,0,0]){
        // left tower
        translate([cr,l-(cr-t)/2,0])
        cylinder(r=cr-t, h*1.1);
        translate([cr,l-(cr-t)/2,h*1.1])
        cylinder(r1=cr-t, r2=.1,h);
        //right tower
        translate([w-(cr-t)/2,l-(cr-t)/2,0])
        cylinder(r=cr-t, h*1.1);
        translate([w-(cr-t)/2,l-(cr-t)/2,h*1.1])
        cylinder(r1=cr-t, r2=.1,h);
        // overhang
        translate([w/2-t,l+t*2,h])
        rotate([180,0,0])
        quady(h,t,h,w/10);
        
        // Bridge
        translate([t/2,l/4,h-lineHeight*5])
        nccube(w+t,l/3,lineHeight*5);
                
        difference(){
            union(){
                translate([0,0,0])
                roundCube(w+t*2,l+t*2,h,cornerRadius);

                translate([0,l/2,0])
                nccube(w+t*2,l/2+t*2,h);

            }
            //---------------------------------------------
            // inner
            translate([t,t,tz*2])
            roundCube(w,l,h,cr-t);
            // front
            translate([w/2+t,-.1,2.5+tz*2])
            rotate([-90,0,0])
            quadz(w-20,w-10,5,l/2,true);
            // rear
            translate([10+t,l/2,t])
            nccube(w-20,l,h-t*2);
            // bottom
            translate([wb+t,wb+t,-.1])
            roundCube(w-wb*2,l-wb*2,h,cr);
        }
    }    
}
}