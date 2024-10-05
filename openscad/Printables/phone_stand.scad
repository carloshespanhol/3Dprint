use <../lib.scad>
$fn=100;

lineWidth = 0.68;
lineHeight = 0.28;

size=50;
base=25;

ws=18;      // width of slot (connector)
width=12.5; // phone width
ch=15;      // connector height
height=45;

w = multiple(width,lineWidth); 
h = multiple(height,lineHeight);
t=5;
echo(w);
echo(h);

intersection(){
            translate([-t,ch-t-.1,h/4-1])
            nccube(ws*2,w*2,ws*1.4);
    
difference(){
    rotate([0,0,20]){
        // Sacrifice bridge
        translate([w+t,ch-t,0]) nccube(lineWidth/2,w,h);            
        translate([w+t+t/2-lineWidth/2,ch-t,0]) nccube(lineWidth/2,w,h);            

        difference(){
            union(){
                nccube(t,size,h);
                
                translate([t,ch-t,0])
                nccube(w,t,h);
                translate([w+t,ch-t,0])
                nccube(t,w,h);
            }

            translate([t,ch-t-.1,h/2-ws/2-.1])
            nccube(w+t,w+t,ws+.2);
        }
    }    
}

}
/*
    translate([-base/2,t,-.1])
    nccube(base,t,t);


translate([-base,0,0])
nccube(base,t,h);
/**/


