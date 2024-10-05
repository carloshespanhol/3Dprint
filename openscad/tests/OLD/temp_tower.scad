$fn=100;

ht=5;
l=50;
w=5;
d1=6; // cylinder
d2=5; // hole

translate([-5,-d1/4,0])
cube([10,l+d1/2,.5]);

for(i=[0:2:8]){
    j=ht*(i/2);
    difference(){
        union(){
            hull(){
                translate([-w/2,0,j])
                cube([w,ht*2,ht]);
                translate([-w/2,0,j+ht-1])
                cube([w,15,1]);
            }
            translate([0,l-d1/2,j])
            cylinder(d=d1,h=ht);

            translate([-w/2,0,j+ht-1.5])
            cube([w,l-d1/2,1.5]);
        }
        
        translate([-w,5,j])
        rotate([0,90,0])
        cylinder(d=d2,h=w*2);
    }    
}

