$fn=100;

soapLength = 85;
soapWidth  = 60;
clearance = 1;
border = 1;

/**********************************/
t=3;
l=soapLength+t*2+clearance;
w=soapWidth+t*2+clearance; 
h=6;
o=15;
div=6;
s=(l-t)/(div+1);

if(border){
    difference(){
        translate([-w/2,-l/2,0])
        rcube(w,l,h+t,2);
        
        translate([-w/2+t,-l/2+t,-.1])
        rcube(w-t*2,l-t*2,h+t+1,1);
        
        hull(){
            translate([0,0,h/2])
            cube([o,l*2,.1],true);
            
            cube([o+h,l*2,.1],true);
        }        
    }
    
    intersection(){
        translate([-w/2,-l/2,0])
        rcube(w,l,h+t,2);

        grid();
    }
}else{            
    grid();
}            

module grid(){
    difference(){
        union(){
            translate([-w/2,-l/2, 0])
            cube([t,l,t]);
            translate([w/2-t,-l/2, 0])
            cube([t,l,t]);
            
            for(i=[-l/2+t/2:s:l/2]){
                translate([0,i,0])
                translate([-w/2,-t/2,0])
                cube([w,h/2,h]);
            }
        }
            
        hull(){
            translate([0,0,h/2])
            cube([o,l*2,.1],true);
            cube([o+h,l*2,.1],true);
        }        
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
