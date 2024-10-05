use <../lib.scad>
$fn=200;

di=47;
hi=7.5;
dii=42.5;
ic=35;
lk= (di-dii)/2;
t=2.4;
f=2;
c=hi/3*2+3;

rf=3;
az=0.8;

*cylinder(d=ic,h=hi);


difference(){
    union(){
        translate([0,0,t])
        rotate_extrude()
            translate([ic/2-rf-az, 0])
            difference(){
                rotate ([0,0,180]) 
                translate([-rf-az,-rf-az,0]) 
                square([rf+az,rf+az]);
                //-------------------------
                translate([0,rf,0])
                circle(rf);
            } 
        difference(){
            cylinder(d=di+t*2, h=hi+t+lk);
            
            translate([0,0,t])
            cylinder(d=di, h=hi*2);
        }
        *intersection(){
            cylinder(d=di+t*2, h=hi+lk+t*2);
            
            translate([0,0,hi+t+lk])
            rotate_extrude()
                translate([di/2, 0])
                circle(lk);
        }
    }
    //-----------------------
    fillet_r(2,di/2+t);
    /**/
    rotate([0,0,45]){
        translate([di,-1,c])
        rotate([0,-90,0])
        rcube(hi*2,2,di*2,1);
        translate([-1,di,c])
        rotate([90,0,0])
        rcube(2,hi*2,di*2,1);
    }
    translate([di,-1,c])
    rotate([0,-90,0])
    rcube(hi*2,2,di*2,1);
    translate([-1,di,c])
    rotate([90,0,0])
    rcube(2,hi*2,di*2,1);
    /**/
    // Furos
    for(n=[0:9]) 
      rotate([0,0,n*360/10]){
        translate([-(di/3)+f,0,-.1])
        cylinder(d=f, h=t+1);
        translate([-(di/4)+t*2+f,0,-.1])
        cylinder(d=f, h=t+1);
    }
}   