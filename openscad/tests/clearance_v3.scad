use <../lib.scad>
$fn=200;


r=1;
h=2;
s=3;
q=5;

for(i=[1:q]){
    cl = .1*(i-1);
    echo(cl);
    difference(){
        d=i*s;
        translate([-d/2,-d/2,0])
        rcube(d, d, h,r,0);
        
        if(i>1){
            di = (i-1)*s;
            translate([-di/2-cl,-di/2-cl,-.1])
            rcube(di+cl*2,di+cl*2,h+1,r,0);        
        }
        
        translate([-100,0,-.1])
        cube([200,100,h+1]);
    }
}    