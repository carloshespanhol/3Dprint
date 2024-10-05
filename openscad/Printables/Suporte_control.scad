use <../lib.scad>
$fn=100;

tx=18;  // thickness x
ty=10;  // thickness y
tz=6;   // thickness z
cd=40;  // control depth
cw=70;  // control width
w=cw+ty*2;   // width
h=80;   // height
nc=3;   // number of controls
rc=4; // round corner


color("grey"){
for (i = [1:nc]) {
    translate([tx/4+(tx+cd)*i,ty,tz])
    hull(){
        translate([0,tz*1.5,tz*1.5])
        rcube(tx/2,w-ty*2-tz*3,.1,rc);
    
        rcube(tx/2,w-ty*2,.1,rc);
    }
}

difference(){
    union(){
        vrcube(cd+tx*(nc+1), w, h, rc);
        
        translate([cd, 0,0])
        rcube(cd*nc+tx*(nc+1)-cd, w, h, rc);        
    }
    
    translate([tx/2, -.1, tz])
    vrcube(cd*nc+tx*(nc+1), w+1, h-tz*2, rc/2);
    
    for (i = [0:nc-1]) {
        translate([tx+(tx+cd)*i,ty,tz*2])
        cube([cd,cw,h]);
    
    }
}
}
