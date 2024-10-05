$fn=200;

x=30;
y=15;
z=20;
t=6.5;
xs1=15;  //espaço para suporte
xs2=4;

sup_teste();

module sup_teste(){
difference(){
    union(){
        scube(x,y,t,4);
        
        translate([xs1,0,0])
        rcube(x-15,y,z,5);
        translate([xs1+5,0,0])
        rcube(x-15-5,y,z,1);

        translate([0,0,z])
        mirror([0,0,1])
        rcube(x,y,t,1);
    }
    //-----------------------
    r=x-xs1-xs2-5;
    translate([x-xs2,-.1,0])
    rotate([-90,0,0])
    cylinder(r=r, h=y+1);
    translate([x-xs2,-.1,0])
    cube([x,y+1,r]);
}    
}

module rcube(length,width,height,r=.5){ 
    l=length-2*r;
    w=width-2*r;    
    translate([r,r,0]){
        cylinder(r=r,h=height);    
        translate([0,w,0])
        cylinder(r=r,h=height);    
        translate([l,0,0])
        cylinder(r=r,h=height);    
        translate([l,w,0])
        cylinder(r=r,h=height);    
    }
    // Inner cubes
    translate([0,r,0])
    cube([length,w,height]);
    translate([r,0,0])
    cube([l,width,height]);
}

module scube(length,width,height,r,rc=0){ 
    d=r*2;
    l=length-d;
    w=width-d;  
    difference(){  
        hull(){
            translate([r,r,height-r])
            {
                sphere(r);
                translate([0,w,0])
                sphere(r);
                translate([l,0,0])
                sphere(r);
                translate([l,w,0])
                sphere(r);
                
            }
            if(rc > 0){
                rcube(length,width,0.1,rc);
            }else{
                rcube(length,width,height-r,r);
            }
        }
        //------------------------------
        translate([-1,-1,-d])
        cube([length+2, width+2, d]);
    }
}
