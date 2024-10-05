$fn=0.2;

ih=8;
iw=23;
depth=5;
ww=1.2;
ss=10;

difference(){
    union(){
        cube([iw+ww*2,depth,ih+ww*2]);
        
        
        
    }
    
    translate([ww,-ww,ww])
    cube([iw,iw,ih]);
    
    translate([iw/2+ww-ss/2,-ww,-1])
    cube([ss,iw,ih]);
}    