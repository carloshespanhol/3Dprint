$fn=100;

sl=95;
sw=55;
t=4;

/*********/
l=sl+t*3;
w=sw+t*3; 
h=6;
div=6;
s=(l-t)/(div+1);

difference(){
    union(){
        difference(){
            translate([-w/2,-l/2,0])
            rcube(w,l,h+t,2);
            
            translate([-w/2+t,-l/2+t,-.1])
            rcube(w-t*2,l-t*2,h+t+1,1);
        }
          
        for(i=[-l/2+t/2+s:s:l/2-t*2]){
            translate([0,i,0])
            translate([-w/2,-t/2,0])
            cube([w,h/2,h]);
        }
    }
        
    hull(){
        translate([-w/5,0,0])
        rotate([0,45,0])
        cube([h/2,l*2,h],true);
        
        translate([w/5,0,0])
        rotate([0,-45,0])
        cube([h/2,l*2,h],true);
    }
}    

module rcube(length,width,height,radius=.5){    
    l=length-2*radius;
    w=width-2*radius;
    translate([radius,radius,0])
    hull(){
        cylinder(r=radius,h=height);    
        translate([0,w,0])
        cylinder(r=radius,h=height);    
        translate([l,0,0])
        cylinder(r=radius,h=height);    
        translate([l,w,0])
        cylinder(r=radius,h=height);    
    }
}
