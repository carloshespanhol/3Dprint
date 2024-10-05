$fn=100;

ds=7.4;
dl=15;
hl=10;
t=1.2;
s=ds/4*3;

difference(){
    union(){
        cylinder(d1=dl+t*2, d2=ds+t*2, h=hl);

        //cylinder(d=ds+t*2, h=hl*2);
    }
    
    translate([0,0,-.1])
    cylinder(d1=dl, d2=ds, h=hl+.2);

    cylinder(d=ds, h=hl*2+.2);

    translate([-s/2,0,-.1])
    cube([s,dl+t*3,hl*3]);
}