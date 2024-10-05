$fn=100;
fit=0.3;

//sabonete=[95,55];
//sabonete=[100,60]; //Claudia
sabonete=[80,50];  //Gabi
sl=sabonete[0];
sw=sabonete[1];
l=sl+2;
w=sw+2; 
pos=1;

h=3;
div=6;
slot=4;
t=(l/div)-slot;
echo("T: ");
echo(t);
/*********/
v=l-(t*div);
//slot=v/(div-1);
s=t+slot;
bh=4;
bw=8;
bl=l-t;
td=0; //top dif
c=25; //top curve
echo(slot);
fh=3;
dw=w/2-w/6-bw/2;
dl=s*2+t;
print=1;

// Sabonete
//%translate([-sw/2, -sl/2, h*3]) cube([sw,sl,20]);

//color([.6,1,0.6])
/**
color("orange")
if(print == 1){ 
    saboneteira6();
}else{    
    translate([0,0,fh]) 
    saboneteira6();
}
saboneteira4();
/**/
foot();

module saboneteira4(){
    v=l-(t*div);
    slot=v/(div-1);
    s=t+slot;
    bh=2.5;
    bw=6;
    bl=l-t;
    td=0; //top dif
    echo(slot);
    dw=w/2-w/6-t/4-fit;
    dl=s*2+t;
    
    difference(){
        union(){
            for(i=[-1,1]){
                translate([i*dw-bw/2,-l/2+t/2,0])
                trapezy(bw,bw/2,bl,bh);
            }
            
            for(i=[0:div-1]){
                p=-l/2+s*i;
                translate([-w/2,p,0])
                //trapezx(w,t,t-td,h);
                rcube(w,t,h,.5);
            }
            
        }
        /****************************/
        for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
            translate([a[0]*dw, a[1]*l/2-a[1]*(s+t/2), -.1])
            cylinder(d=t/2+fit, h=h/2);
        }
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
        cube([x,y1,.1]);

        translate([0,(y1-y2)/2,z])
        cube([x,y2,.1]);
    }    
}
module trapezy(x1,x2,y,z){
    translate([x1,0,0])
    rotate([0,0,90])
    trapezx(y,x1,x2,z);
}

module foot(){
    t=(w/div);
    if(print == 1){ 
        for(a=[ 0,1,2,3 ] ){
            translate([-w/2+t/2+a*t, l/2+t/2, -.1])
            cylinder(d=t/2, h=h/2+fh);
        }
    }else{
        for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
            translate([a[0]*dw, a[1]*(s+t/2), -.1])
            cylinder(d=t/2, h=h/2+fh);
        }
    }
}
module foot6(){
    t=(w/div);
    if(print == 1){ 
        for(a=[ 0,1,2,3 ] ){
            translate([-w/2+t+a*t*1.25, l/2+t/2, -.1])
            cylinder(d=t/2, h=h/2+fh);
        }
    }else{
        for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
            translate([(a[0]*t*2)-(a[0]*t/2)-.4, a[1]*(l/3), -.1])
            cylinder(d=t/2, h=h/2+fh);
        }
    }
}

module saboneteira6(){
  tipo=2;
  t=(w/div);
  dw=3.2;
  dl=25;
  sr=l;
    
  intersection(){
    translate([0,0,sr-13])    sphere(sr);
    
    difference(){
        union(){
            // base
            translate([-w/2,-l/2,0])
            trapezx(w-.8,l,l,bh);

            for(i=[0:div-1]){
                p=-w/2+t*i;
                translate([p,-l/2,0]){
                    if(tipo==2){
                        translate([0,0,h])
                        trapezy(t-.8,0.8,l,t/2);
                    }
                }
            }
            
        }
        /****************************/
        // Foot Holes
        for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
                        translate([(a[0]*t*2)-(a[0]*t/2)-.4, a[1]*(l/3), -.1])
            cylinder(d=t/2+.5, h=h/2);
        }
        
        // Drain
        for(i=[0:div-2]){
            p=-w/2+t*i-dw/2+.8;
            translate([p,0,0]){
                if(tipo==2){
                    translate([t-1.2, l/4-dl/3*2-2,-.1])
                    rcube(dw, dl, h*2, 0.8);

                    translate([t-1.2, -l/4-dl/3+2,-.1])
                    rcube(dw, dl, h*2, 0.8);
                }
            }
        }
    }    
}
}
module saboneteira5(){
  tipo=2;
  
  intersection(){
    translate([0,0,l*4-bh/2])
    sphere(l*4);
    
    difference(){
        union(){
            // base
            difference(){
              union(){
                translate([-w/2+w/6,-l/2+t/2,0])
                trapezy(bw,bw,bl,bh);
                //rotate([-90,0,0]) cylinder(d=bw, h=bl);
                
                translate([w/2-bw-w/6,-l/2+t/2,0])
                trapezy(bw,bw,bl,bh);
                //translate([w/2-w/4,-l/2+t/2,0])
                //rotate([-90,0,0]) cylinder(d=bw, h=bl);
              }
              
              translate([-w/2,-l/2,-h])
              cube([w,l,h]);
            }
            
            for(i=[0:div-1]){
                p=-l/2+s*i;
                translate([-w/2,p+slot/2,0]){
                    trapezx(w,t,t-td,h);
                    
                    if(tipo==2){
                        translate([0,0,h])
                        trapezx(w,t/2-slot/2,.8,t/4);
                        translate([0,t/2+slot/2,h])
                        trapezx(w,t/2-slot/2,.8,t/4);
                    }
                }
            }
            
        }
        /****************************/
        for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
            translate([a[0]*dw, a[1]*(s+t/2+slot/2), -.1])
            cylinder(d=t/2+.5, h=h/2);
        }
    }    
}
}


module saboneteira3(){
    v=l-(t*div);
    slot=v/(div-1);
    s=t+slot;
    bh=3;
    bw=6;
    bl=l-t;
    
    difference(){
        union(){
            translate([-w/2+t,-l/2+t/2,0])
            cube([bw,bl,bh]);
            
            translate([w/2-t-bw,-l/2+t/2,0])
            cube([bw,bl,bh]);

            for(i=[0:div-1]){
                p=-l/2+s*i;
                translate([-w/2,0,0])
                hull(){
                    translate([0,p,0])
                    cube([.1,t,h]);

                    translate([w,p,0])
                    cube([.1,t,h]);
                }
                /*overhang
                translate([-w/2,t/2,0])
                hull(){
                    translate([t,p,bh-t])
                    cube([t,t,.1]);

                    translate([0,p,bh])
                    cube([t,t,.1]);
                }
                translate([-w/2,t/2,0])
                hull(){
                    translate([w-t*2,p,bh-t])
                    cube([t,t,.1]);

                    translate([w-t,p,bh])
                    cube([t,t,.1]);
                }
                /**/
            }
            
        }
        /****************************/
        dw=w/2-t-bw/2;
        dl=s*2+t;
        for(a=[ [-1,-1], [-1,1], [1,-1], [1,1] ] ){
            translate([a[0]*dw, a[1]*l/2-a[1]*(s+t/2), -.1])
            cylinder(d=t/2+.5, h=h/2);
        }
    }    
}

module saboneteira2(){
    s=(l)/(div);
    bh=5;
    bw=10;
    bl=l;
    
    difference(){
        union(){
            translate([-w/2+t*2,-l/2,0])
            cube([bw,bl,bh]);
            
            translate([w/2-t*2-bw,-l/2,-.1])
            cube([bw,bl,bh]);

            for(i=[0:div-1]){
                //-l/2+t/2+s:s:l/2-t*2
                p=-l/2+t+s*i;
                translate([-w/2,t/2,bh])
                hull(){
                    translate([0,p,0])
                    cube([.1,t,h]);

                    translate([w,p,0])
                    cube([.1,t,h]);
                }
                /*overhang
                translate([-w/2,t/2,0])
                hull(){
                    translate([t,p,bh-t])
                    cube([t,t,.1]);

                    translate([0,p,bh])
                    cube([t,t,.1]);
                }
                translate([-w/2,t/2,0])
                hull(){
                    translate([w-t*2,p,bh-t])
                    cube([t,t,.1]);

                    translate([w-t,p,bh])
                    cube([t,t,.1]);
                }
                /**/
            }
        }
        /****************************/
        
    }    
}

module saboneteira1(){
    s=(l-t)/(div);
    
    difference(){
        union(){
            /**/
            difference(){
                translate([-w/2,-l/2,0])
                rcube(w,l,h+t/2,2);
                
                translate([-w/2+t,-l/2+t,-.1])
                rcube(w-t*2,l-t*2,h+t+1,1);
            }
            /**/  
            for(i=[0:div-1]){
                //-l/2+t/2+s:s:l/2-t*2
                p=-l/2+t/2+s*i;
                translate([-w/2,-t/2,0]){
                    hull(){
                        translate([0,p,0])
                        cube([.1,t,h]);

                        translate([w,p+s,0])
                        cube([.1,t,h]);
                    }
                }
                /*
                hull(){
                    translate([0,p,0])
                    cube([.1,t,h]);

                    translate([w,p-s,0])
                    cube([.1,t,h]);
                }
                /**/
            }
        }
        
        
         /* */  
        hull(){
            translate([-sw/3,0,0])
            rotate([0,45,0])
            cube([1,l*2,h],true);
            
            translate([sw/3,0,0])
            rotate([0,-45,0])
            cube([1,l*2,h],true);
        }
        /**/
    }    
}

module saboneteira(){
    s=(l-t)/(div+1);
    
    difference(){
        union(){
            /**/
            difference(){
                translate([-w/2,-l/2,0])
                rcube(w,l,h+t/2,2);
                
                translate([-w/2+t,-l/2+t,-.1])
                rcube(w-t*2,l-t*2,h+t+1,1);
            }
            /**/  
            for(i=[-l/2+t/2+s:s:l/2-t*2]){
                translate([0,i,0])
                translate([-w/2,-t/2,0])
                cube([w,t,h]);
            }
        }
            
        hull(){
            translate([-sw/3,0,0])
            rotate([0,45,0])
            cube([1,l*2,h],true);
            
            translate([sw/3,0,0])
            rotate([0,-45,0])
            cube([1,l*2,h],true);
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
