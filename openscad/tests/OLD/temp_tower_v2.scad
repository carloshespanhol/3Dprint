$fn=100;

ht=5;
l=80;
w=5;
d1=8;
d2=6;
q=5;

translate([0,-1,-1])
for(i=[1:ht:ht*q]){
    difference(){
        union(){
            hull(){
                translate([-w/2,i,i])
                cube([w,ht*q-i,ht]);
                
                translate([-w/2,i,i+ht-1])
                cube([w,ht*q-i+ht,1]);
            }
            translate([0,l-d1/2+1,i])
            cylinder(d=d1,h=ht);

            translate([-w/2,i,i+ht-1.2])
            cube([w,l-i-d1/2,1.2]);
        }

    }    
}

