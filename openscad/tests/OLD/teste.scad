$fn=200;
do=30;
di=do/4;
lw=0.6;
lh=0.2;
h=5;

difference(){
    cylinder(d=do, h=h);

    translate([0,0,lh])
    cylinder(d=do-lw*2, h=h);
}

difference(){
    cylinder(d=di*3, h=h);

    cylinder(d=di, h=h+1);
}
