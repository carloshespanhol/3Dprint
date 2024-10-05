use <../lib.scad>
$fn=100;

lineWidth = 0.68;
lineHeight = 0.28;

size=50;
base=25;

ws=20;       // width of slot (connector)
width=11; // phone width
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
        translate([w+t,ch-t, h/2-ws/2+lineHeight/2 ]) nccube(lineWidth/2,w+t,h);
        translate([w+1.5*t-lineWidth/2,ch-t, h/2-ws/2+lineHeight ]) nccube(lineWidth/2,w+t,h);            
        translate([w+2*t-lineWidth/2,ch-t, h/2-ws/2+lineHeight/2 ]) nccube(lineWidth/2,w+t,h);            

        translate([t+lineWidth,ch-t/2, h/2-ws/2+lineHeight/2 ]) nccube(w-2*lineWidth,lineWidth/2,h);            

        difference(){
            union(){
                translate([0,2,0])
                nccube(t,size,h);
                hull(){
                    translate([0,2,0])
                    nccube(t,1,h);
                    rotate([0,0,-20])
                    translate([-base,0,0])
                    nccube(base,t,h);
                    translate([t*.5,t*.35,0])
                    cylinder(d=t,h=h);
                }
                translate([t,ch-t,0])
                nccube(w+t,t,h);
                translate([w+t,ch,0])
                nccube(t,w,h);
            }

            translate([t,ch-t-.1,h/2-ws/2-.1])
            nccube(w+t+.1,w+2*t,ws+.2);
        }
    }    
    /**/
    translate([-base/2,t,-.1])
    nccube(base,t,t);
}

}
