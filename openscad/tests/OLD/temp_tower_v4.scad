$fn=100;

ht=5;
l=30;
w=15;
d1=8;
d2=6;
q=5;
t=1.2;

for(i=[0:ht:ht*q]){
    difference(){
        union(){
            hull(){
                translate([-w/2,0,i])
                cube([w,ht,ht]);
                
                translate([-w/2,0,i+ht-t])
                cube([w,ht*2,1]);
            }

            translate([-w/2,0,i+ht-t])
            cube([w,l,1.2]);

            translate([-w/2,l-t*2,i])
            cube([w,t*2,ht]);
            
            //
            translate([-w/2,-ht,i])
            cube([w,ht,ht]);
        }

        translate([0,-ht,i-.1])
        cylinder(d=w/2, h=ht+1);
    }    
}

