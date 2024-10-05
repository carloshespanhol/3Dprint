$fn=100;
diam=59;
height=30;

cylinder(3,d=diam);
translate([0,0,2.9]) cylinder(4,r1=(diam/3*2)/2,r2=7.5);

cylinder(height,r=7.5);
translate([0,0,height-6]) cylinder(6,r1=7.5,r2=17);
      
translate([0,0,height]) cylinder(1.5,r=17);
