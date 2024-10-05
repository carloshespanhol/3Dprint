$fn=200;

sp2();

module sp1(){
    h=3;
    difference(){
        cylinder(d=10, h=h);
        
        translate([0,0,-.1])
        cylinder(d1=3.1, d2=6.5, h=h+.2);
    }
}


module sp2(){
    h=1.5;
    hp=5;
    
    translate([0,0,-.1])
    cylinder(d1=6, d2=9, h=h);

    cylinder(d=3, h=hp);    
}
