use <../lib.scad>

l=50;
w=50;
t=6;
r=2;
a=60;

panel();
phone();

module phone(){
    difference(){
        union(){
            rotate([0,-a,0])
            scube(l/2,w,t);

            rotate([0,-a,0])
            rcube(l,w,t,r);

            translate([-l/3+t/3,w/3,t-1.65])
            rcube(l/3,w/3,t,r);
        }
        
        translate([0,-.1,0])
        rotate([0,180+45,0])
        scube(t+.2,w+1,t);

        translate([-8,w/2,4])
        rotate([180,0,0])
        Mscrew();
        
        translate([-8,w/2,t*1.4])
        Mnut();
    }    
}
module panel(){
    difference(){
        union(){
            translate([-l/2,0,0])
            scube(l/2,w,t);

            translate([-l,0,0])
            rcube(l,w,t,r);
        }
        
        translate([-l/3+t/3,w/3,t-1.65])
        rcube(l/3,w/3,t,r);
        
        translate([0,-.1,0])
        rotate([0,-45,0])
        scube(t*1.5,w+1,t*1.5);

        translate([-8,w/2,3])
        rotate([180,0,0])
        Mscrew();
    }    
}

