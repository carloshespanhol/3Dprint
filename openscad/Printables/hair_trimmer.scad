use <../lib.scad>
$fn=200;

lineHeigth=0.12;
lineWidth=0.80;

ext_width=42;
// Internal measures
width=33;
length=40;
height=6;
thick=1.5;

widthSlot=29;
thickSlot=0.8;

widthLock=12;
lengthLock=2;

front_len=19;
front_top=height+19;

/************************************
w=multiple(width, lineWidth);
l=multiple(length, lineWidth);
h=multiple(height, lineHeigth);
*/
t=thick;//multiple(thick, lineWidth);
tooth_area_width = ext_width;
tooth_len=20;
tooth_height=10;



nccube(ext_width,lineWidth+.9,.2);
translate([0,-front_top-7-lineWidth,0])
nccube(ext_width,lineWidth+.9,.2);


translate([0,3,7.5])
rotate([68,0,0])
intersection(){
union(){
    translate([ext_width/2,length,height*1.5])
    rotate([90,0,0])
    cylinder(r1=ext_width/2-2,r2=ext_width/2+2,h=length+front_len);
    translate([0,-front_len-2,height])
    nccube(ext_width,front_len,front_top+2);
} 

difference(){
union(){
    /* Front */         
    difference(){
        union(){
            // bottom
            translate([0,-front_len,0])
            nccube(ext_width,front_len,front_top+2);
            // top
            translate([0,-front_len-5,front_top-3])
            nccube(ext_width,front_len,7);
        }        
        //-----------------------------
        // internal angle
        translate([-.1,2.5,height-5])
        rotate([42,0,0])
        nccube(ext_width+3*t,length,front_top);
        
        translate([-.1,-height*2-1.5,front_top-6])
        rotate([26,0,0])
        nccube(ext_width+3*t,15,6);
        
        translate([-1,-front_len+5,front_top-1])
        rotate([22,0,0])
        nccube(ext_width+3*t,front_len,10);
        
        // external angle
        translate([-.1,-front_len+2,-10])
        rotate([22,0,0])
        nccube(ext_width+3*t,12,length+1);        
    }  


    /* Body */  
    difference(){
        union(){
            translate([0,-10,0])
            nccube(ext_width,length+10,height+t);
        }
        //--------------------------
        // internal
        intersection(){
            translate([(ext_width-width)/2,-front_len,t])
            nccube(width,length*2,height+1);
            
            translate([ext_width/2,length,height*1.5])
            rotate([90,0,0])
            cylinder(r1=width/2,r2=width/2,h=length+10);
        }
        
        // Chamfer front
        rotate([33,0,0])
        translate([-.1,-16,0])
        nccube(ext_width+1,16,height*2);

        // Chamfer hear
        rotate([22,0,0])
        translate([-.1,length-4,-17])
        nccube(ext_width+1,10,height*2);

        /* Chamfer lock
        translate([ext_width/2-(widthLock+2)/2,length-8,t])
        rotate([-7.5,0,0])
        nccube(widthLock+2,height*2,height);
      
       /* Lock */
       translate([ext_width/2-widthLock/2, length-lengthLock-3,-.1])
       nccube(widthLock,lengthLock,height);
    }

    /* Slot snap */
    difference(){
        union(){
            translate([0,-5,height+t])
            mirror([0,0,1])
            quadx(3, thickSlot, (ext_width-widthSlot)/2,length+5);
            translate([ext_width,-5,height+t])
            rotate([0,180,0])
            quadx(3, thickSlot, (ext_width-widthSlot)/2,length+5);
        }
        
        // Chamfer front
        rotate([33,0,0])
        translate([-.1,-14.7,0])
        nccube(ext_width+1,15,height*2);

        // Chamfer hear
        rotate([22,0,0])
        translate([-.1,length-4,-17])
        nccube(ext_width+1,10,height*2);

        // Chamfer snap in
        translate([0,length+t,0])
        rotate([0,0,-60])
        nccube(height*3,height*2,height*2);
        
        translate([ext_width,length+t,0])
        mirror([1,0,0])
        rotate([0,0,-60])
        nccube(height*3,height*2,height*2);
    }   
}
//------------------------------------
// tooth 
for(i=[0:7]) {
      translate([ lineWidth*2 + ((tooth_area_width-lineWidth*2)/6)*i, -24.5, -.1]) 
        cube([tooth_area_width/6-lineWidth*2-.1, tooth_len, 21+15]);
}   

}
}
