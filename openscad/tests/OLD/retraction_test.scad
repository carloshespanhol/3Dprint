use <../lib.scad>
$fn=200;

linewidth  = .6;

diam    = multiple(5, linewidth);
heigth  = 7;
dist    = 60;
bh      = 1;    //bridge height
echo(diam);

translate([-diam,-diam,0])
rcube(dist+diam*2,diam*2,1,2, .2);

cylinder(d=diam, h=heigth);

translate([dist,0,0])
cylinder(d=diam, h=heigth);

hull(){
    translate([0,0,heigth])
    cylinder(d=diam, h=bh);

    translate([dist,0,heigth])
    cylinder(d=diam, h=bh);
}