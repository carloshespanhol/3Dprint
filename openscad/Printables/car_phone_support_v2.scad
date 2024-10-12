use <../lib.scad>

l=50;
w=50;
t=5; 
tp=8;
t1=6;
r=2;
a=60;

phl=50;
pl = 20;
pw = 10;
ph = 6;	


phone_support();


module phone_support(){
    w1=3;
    mt=11;
    md=34;
    difference(){
        union(){
            translate([-l+t1+(l-md)/2,w/2-w1/2,mt])
            scube(md,w1,3);
            translate([-20-w1/2, (w-md)/2, mt])
            scube(w1,md,3);
            
            /* bridge */
            translate([-20,w/2,mt])
            cylinder(d=md, h=.2);
            /**/
        }
                
        translate([0,tp,tp])
        rotate([0,-a,0])
        scube(tp*3,w-tp*2,tp);
    }
        
    difference(){
        union(){
            hull(){
                translate([-phl+t1,0,0])
                rcube(phl,w,t,8);
                
                translate([-20,w/2,mt+3])
                cylinder(d=md, h=.2);
            }
            /**/
            translate([-3,0,0])
            rotate([0,-a,0])
            hull(){
                translate([0,tp/2,0])
                rcube(l-tp,w-tp,1,8);

                translate([0,0,tp-2])
                rcube(l,w,2,2);
            }
            /**/
        }

        // magnet
        translate([-20,w/2,-.5]){
            cylinder(d=34, h=mt+.5);
            cylinder(d=22, h=30);
        }
    }    
}
