$fn=200;

h=12.5;
l=9;
width=12;
w=width/2;
adj=0.95;

t=2;
dif=1;

pd=4;   //pick point diameter
pw=0.8; //pick thickness
ph=2;   //pick point height

fw=21;  //finger width
fh=15.5;  //finger height
d=fh/1.25;

//thumb_pick();
finger(w*2+.1,dif);

hull(){
    intersection(){
        thumb_pick();
        
        cube([20,9,15]);
    }    

    difference(){
        union(){
            translate([fw/2+.5, fh/3, w*1.5])
           // rotate([0,-3,0])
            rotate([-90,0,-75])
            cylinder(d=w, h=t/2);

        }
        
        translate([0, fh/2, -.1])
        cube([fw,fw,w*2+1]);
    }    
}

module thumb_pick(){
    difference(){
        union(){   
            difference(){
                hull(){
                    thumb(fw,w);
                    translate([0,0,w]) thumb(fw-dif,w);
                }
                //------------------------------------
                translate([-1, -fw, -.1])
                cube([fw,fw+fh/2,w*2+1]);
            }
            pick(w,1);
            translate([0,0,w]) pick(w,0);
        }
        //------------------------------------
        /*
        hull(){
            translate([0,0,2]) finger(w-2);
            finger(.2,-t*2+.6);
        }
        hull(){
            translate([0,0,w-1]) finger(1);
            translate([0,0,w]) finger(1,dif);
        }
        /**/
        translate([0,0,-.1]) finger(w*2+.1,dif);
    }
}


module thumb(df,w){
    translate([0, fh-fw/2, 0])
    difference(){
        cylinder(d=df+t*2, h=w);

        translate([-df, -df, -.1])
        cube([df*2,df,w+1]);
    }
/*    translate([-fw/2+d/2+adj, d/2, 0])
    cylinder(d=d+t*2, h=w);
    /**/
    translate([-fw/2+d/2, d/2, 0])
    cylinder(d=d+t*2, h=w);
    
}

module finger(w,dif=0){ 
    hull(){
        translate([-fw/2+d/2, d/2, -.1])
        cylinder(d=d, h=w+.2);

        difference(){
            translate([0, fh-fw/2,-.1])
            cylinder(d=fw-dif, h=w+.2);
            
            translate([-fw, -fw, -.1])
            rotate([0,0,-2])
            cube([fw*2,fw+h/2,w+.2]);
        }
    }
    translate([(fh-fw)/2-1.5, 0, -.1])
    cube([l/2,t*2,w+.2]);
}

module pick(w,p){
    if(p==1){
        // body
        hull(){
            translate([(h-fw)/2 -1, -t, 0])
            cube([5,t,w]);

            translate([(l-pd)/2, -t, 0])
            cube([.1,pw,w]);
        }
        // point
        hull(){
            translate([(l-pd)/2, -t, 0])
            cube([.1,pw,w*1.5]);
         
            translate([fw/2, -t, 0])
            cube([.1,pw,ph]);

            translate([fw/2+t/2+ph, -t, ph])
            rotate([-90,0,0])
            cylinder(d=pd, h=pw);
        }
    }else{
        hull(){
            translate([(h-fw)/2 -1, -t, 0])
            cube([5,t,w]);

            translate([(l-pd)/2, -t, 0])
            cube([.1,pw,w/2]);
        }
    }
}    
    
