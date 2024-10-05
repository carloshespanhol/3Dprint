$fn=200;

l=65;
w=64;
h=93;
lw=2;
mt=17;  // mobile thickness
cw=w/3; // cut width
ch=30;  // cut height
ba=108; // back angle
fa=70;  // front angle

*translate([-5,0,-10])
import("/home/hespanhol/Downloads/70deg.STL");
*import("/home/hespanhol/Downloads/50deg.STL");

module oblong(x,y,z){
    //translate([y/2,+y/2,0])
    cylinder(d=y,h=z);

    translate([0,-y/2,0])
    cube([x-y,y,z]);

    translate([x-y,0,0])
    cylinder(d=y,h=z);    
}

module curve(){
  //translate([-dia_mm, 0, 0])
  rotate_extrude(angle=fa)
  translate([lw*2, 0, 0])
  difference(){
    circle(d = lw*2);    
    //circle(d = dia_mm-thickness*2);
  }
}  

curve();

difference(){
    union(){
        oblong(l,lw*2,w);

        translate([l-lw*2,0,0])
        rotate([0,0,ba])
        oblong(h,lw*2,w);

        translate([l-lw+((h+lw)*cos(108)), (h-lw*2)*sin(108), 0])
        //translate([l-31+lw,h-5-lw,0])
        rotate([0,0,-90-(90-70)])
        oblong(60,lw*2,w);

        translate([l-lw+((h+lw)*cos(108)), (h-lw*2)*sin(108), 0])

        translate([-(60*cos(70))+lw*2+lw/2, -60*sin(70)+lw, 0])
        rotate([0,0,-20])
        hook();
    }
    //-----------------------------------------------
    hull(){
        translate([0,28,(w-cw)/2])
        cube([l/2,cw,cw]);
        
        translate([0,28+ch,w/2])
        rotate([0,90,0])
        cylinder(d=lw,h=cw);
    }
}

module hook(){
    translate([-mt,0,0])
    oblong(mt,lw*2,w);

    //rotate([0,0,-20])
    translate([-mt,0,0])
    rotate([0,0,90])
    oblong(12,lw*2,w);
}
