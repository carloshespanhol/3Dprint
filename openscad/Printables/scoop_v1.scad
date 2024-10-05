$fn=100;

h=30;
di=47;
t=1.2;
tb=t*2;
l=40;
w=10;


difference(){
    union(){
        cylinder(d=di+t*2, h=h);
        
        hull(){
            translate([0,0,h-tb])
            cylinder(d=w, h=tb);
            
            translate([di/2+l,0,h-tb])
            cylinder(d=w, h=tb);
        }
        
        // reforço
        hull(){
            translate([di/2-w,0,h/2])
            cylinder(d=w, h=h/2);
            
            translate([di/2+h/2-w,0,h-tb])
            cylinder(d=w, h=tb);
        }
    }

    translate([0,0,tb])
    cylinder(d=di, h=h);
}    