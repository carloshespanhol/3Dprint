$fn=100;

db= 80;     // diameter base
dt= 104;    // diameter top
h= 70;      // height
s= 8;       // sides
b=12;       // borda
u=96;
//---------------------------------
ir=4;
ns=4;
bt=4;       // base thickness
bs=10;      // base space
a=360/s/ir; // angle
vh=h+bt+bs; // vase height
sh=vh/ns;   // steps height

d=db*1.3;
du=dt*1.3;
sd=(du-d)/(vh/sh);
st=vh/sh;
c=15;
th=8;   //top height

/* vase *
%translate([0,0,bt+bs])
cylinder(d1=db, d2=dt, h=h);
/**/
rotate([180,0,0]) 
//vase_top();
vase_top_circle();
//vase();
//cap();

module cap(){
    difference(){
        union(){
            cylinder(d=28, h=2);
            
            translate([0,0,2])
            cylinder(d=23.5, h=5);
        }        

        translate([0,0,2])
        cylinder(d=19.64, h=10);
    }    
}

module vase_top(){
    difference(){
        translate([0,0,st*sh-(th-2)])
        rotate([0,0,st*a])
        cylinder(d=d+st*sd*1.2, h=th, $fn=s);

        translate([0,0,st*sh-(th-2)-2])
        rotate([0,0,st*a])
        cylinder(d=d+st*sd, h=th, $fn=s);
        
        translate([0,0,vh-b])
        cylinder(d=dt-2, h=vh);
        
    }
}
module vase_top_circle(){
    difference(){
        translate([0,0,st*sh-(th-2)])
        rotate([0,0,st*a])
        cylinder(d=d+st*sd*1.2, h=th);

        translate([0,0,st*sh-(th-2)-2])
        rotate([0,0,st*a])
        cylinder(d=d+st*sd, h=th, $fn=s);
        
        translate([0,0,vh-b])
        cylinder(d=dt-2, h=vh);
        
    }
}

module vase(){
    color("white")
    difference(){
        for(i=[1:st]){
            hull(){
                translate([0,0,i*sh])
                rotate([0,0,i*a])
                cylinder(d=d+i*sd, h=.1, $fn=s);

                translate([0,0,(i-1)*sh])
                rotate([0,0,(i-1)*a])
                cylinder(d=d+(i-1)*sd, h=.1, $fn=s);
            }
        }

        translate([0,0,bt])
        cylinder(d1=db-10, d2=db, h=vh);

        translate([0,0,bt+bs])
        cylinder(d=u, h=vh);

        translate([0,0,vh-b])
        cylinder(d=dt, h=vh);
        
        // chanel
        hull(){
            translate([0,-(db-17)/2,bt])
            cylinder(d=c*2, h=1);
            
            translate([0,-(db-25),vh])
            cylinder(d=c, h=1);

            translate([-c/2,-(db-25),vh])
            cube([c,c,1]);
        }
    }
}
