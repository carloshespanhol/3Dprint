$fn=200;
fit=0.4;

//sabonete=[95,55];
sabonete=[90,60]; //Claudia
div=6;
//sabonete=[80,60];  //Gabi
//div=6;
sl=sabonete[0];
sw=sabonete[1];
l=sl+2;
w=sw+2; 
h=4;    // height
r=1;    // radius
td=3;   // top dif

slot=4;
t=(l/div)-slot;
bl=l-t;
dw=w/2-w/6-t/4-fit;
bw=6;
print=1;
fh=7;   // foot height
fd=t-td;   // foot diameter

saboneteira2();

module saboneteira2(){
    v=l-(t*div);
    slot=v/(div-1);
    s=t+slot;    
    
    difference(){
        union(){
            for(i=[-1,1]){
                translate([i*dw-(bw-td)/2,-l/2+t/2,0])
                trapezy(bw-td,bw,bl,h);
            }
            
            for(i=[0:div-1]){
                p=-l/2+s*i;
                translate([-w/2,p+td/2,0])
                trapezx(w,t-td,t,h);
            }
            
            // foot
            color("silver")
            for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
                translate([a[0]*dw, a[1]*l/2-a[1]*(s+t/2), -fh])
                cylinder(d=fd, h=fh);
            }
        }
        //---------------------------------
        
    }    
}

module saboneteira(){
    v=l-(t*div);
    slot=v/(div-1);
    s=t+slot;    
    
    difference(){
        union(){
            for(i=[-1,1]){
                translate([i*dw-bw/2,-l/2+t/2,0])
                trapezy(bw,2,bl,h);
            }
            
            for(i=[0:div-1]){
                p=-l/2+s*i;
                translate([-w/2,p,0])
                rcube(w,t,h/2,r);
                translate([-w/2,p,h/2])
                trapezx(w,t,t-td,h/2);
            }
            
            // foot
            for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
                translate([a[0]*dw, a[1]*l/2-a[1]*(s+t/2), -fh])
                cylinder(d=fd, h=fh);
            }
        }
        //---------------------------------
        
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

module trapezx(x,y1,y2,z){
    hull(){
        rcube(x,y1,.1,r);

        translate([0,(y1-y2)/2,z-.1])
        rcube(x,y2,.1,r);
    }    
}
module trapezy(x1,x2,y,z){
    translate([x1,0,0])
    rotate([0,0,90])
    trapezx(y,x1,x2,z);
}
