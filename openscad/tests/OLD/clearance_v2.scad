$fn=8;

linewidth = .6;
h=2;    //height
s=linewidth*12;    //step
q=6;

for(i=[s:s:s*q]){
    cl = .1*(i/s);
    echo(cl);
    difference(){
        echo(i);
        cylinder(d=i, h=h);

        translate([0,0,-.1])
        cylinder(d=i-s+cl, h=h+1);        
    }
}    