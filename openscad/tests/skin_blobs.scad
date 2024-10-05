use <../lib.scad>
$fn= 100;

fatiador= 0;
l=45;
w=40;
h=3;

/* Fatiador */
lineHeight = 0.2;
firstlayer = 0.24;
fatias = multiple(h,lineHeight)/lineHeight;
if(fatiador){
    for(i=[0:fatias]){
        if(i % 2){
            translate([-l,-w,firstlayer+i*lineHeight])
            %cube([l*2,w*2, lineHeight]);
        }
    }    
}


blob_test();


module blob_test(){
    r=2;
    x=60;
    y=20;
    d=4;
    
    difference(){
        union(){
            //top
            translate([-x/2, -y/2, 0])
            rcube(x, y,h,r);
            
        }
        
        translate([-x/2+d*1.5,-y/2+d*1.5,-.1])
        cylinder(d=d, h=h+1);
        translate([x/2-d*1.5,-y/2+d*1.5,-.1])
        cylinder(d=d, h=h+1);
        
        translate([x/2-d*1.5,y/2-d*1.5,-.1])
        cylinder(d=d, h=h+1);
    }
}    
