use <../lib.scad>
$fn=100;

lineHeight = 0.28;
lineWidth = 0.56;
brimHeight = .5;

w=200;
l=120;
h=15;
pa=21;
d=6.5;

mirror([1,0,0])
{
{
    translate([pa/2,l-pa/2,0])
    cylinder(d=pa,h=h);
    
    difference(){
        translate([0,l,0])
        cylinder(d=pa*3,h=h);
        
        translate([-pa,l-pa*1.75,-.1])
        rotate([0,0,40])
        ncube(pa*4,pa*3,h+1);

        translate([-pa-1.5,l-pa*2.5,-.1])
        rotate([0,0,50])
        ncube(pa*4,pa*3,h+1);
    }

    sup2();
}

/* Brim */
difference(){
    union(){
        cylinder( d=40, h=brimHeight );
        translate([w/3*2,-pa/3,0])
        cylinder( d=30, h=brimHeight );
        
        translate([0,l,0])
        cylinder( d=40, h=brimHeight );
        translate([w,l-20,0])
        cylinder( d=40, h=brimHeight );
    }
    translate([.1,.1,-h/2])
    sup2();
    translate([-.1,-.1,-h/2])
    sup2();
    
    translate([5,5,-.1])
    cylinder( d=20, h=h );
}
}
/**/

thick = [20,20,12];
vert  = [[w/3*2+10,0,0], [0,0,0], [0,l,0], [w,l-20,0]]; 

module sup2(){    
    /* sacrifice bridge */
    translate([-pa/4, -pa/4, 4.9])
    ncube(pa,pa,lineHeight);

    difference(){
        union(){            
            for (i = [0:len(vert)-2]) { 
                hull(){
                    translate([0,(pa-thick[i])/2,0])
                    translate( vert[i] )
                    cylinder(d=thick[i],h=h);
                    
                    translate( vert[i+1] )
                    cylinder(d=thick[i],h=h);
                }
            }
            
            hull(){
                translate([w+5.5,l+5,0])
                cylinder(d=5,h=h);
                translate([w+3.5,l-20,0])
                cylinder(d=5,h=h);
            }

            translate([pa/2-2, pa/2-2, 0])
            cylinder(d=pa+15, h=h);
                        
        }
        
        //-------------------        
        // profile slots
        translate([-pa/4,-pa/4,10])
        ncube(pa,pa,h);

        // screw hole
        translate([pa/4,pa/4,-.1])
        cylinder(d=d,h=h);
        
        translate([pa/4,pa/4,-.1])
        cylinder(d=15,h=5);
        
        // Chamfer
        hull(){
            translate([pa+5,pa/2,-.1])
            ncube(1,1,h+1);
            translate([w/4*3+pa/2,-pa/2+lineWidth*2,-.1])
            ncube(1,pa,h+1);
        }
    }
}

