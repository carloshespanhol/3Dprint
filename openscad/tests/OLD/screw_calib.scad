use <../lib.scad>
$fn=100;

lineHeight = 0.28;
lineWidth = 0.60;

height=7;
w = 15; 
l=35;
cl=0.3;

h = multiple(height,lineHeight);
echo(h/lineHeight);

/*
translate([0,w,0])
screws();
nuts();
*/
test();

//MnutPocket();

module test(){
    #translate([28,w/2,5.3])
    cylinder(d=4,h=lineHeight);
    
    difference(){
        union(){
            rcube(l,w,h,2);            
        }    
        
        translate([6,w/2,3])
        Mnut();

        translate([17,w/2,3])
        Mscrew();

        translate([28,w/2,2])
        MnutPocket(1);
    }
}


module nuts(){
    max=3.5;
    l=max*16;
    echo(l);
    difference(){
        union(){
            rcube(l,w,2,2);
        }    
        
        for(i = [3 : .1 : max+.1]){
            echo(i);
            translate([90*i-265,w/2,h/2])
            Mnut(i);
        }
    }
}

module screws(){
    max=3.5;
    l=max*12;
    echo(l);
    difference(){
        union(){
            rcube(l,w,2,2);
        }    
        
        for(i = [3 : .1 : max+.1]){
            echo(i);
            translate([65*i-190,w/2,h/2])
            Mscrew(10,i);
        }
    }
}

module holes(){
    max=3.5;
    l=max*14;
    
    difference(){
        union(){
            rcube(l,w,2,2);
        }    
        for(i = [3 : .1 : max+.1]){
            echo(i);
            translate([-235+80*i,w/2,-.1])
            cylinder(d=i, h=10);
        }
    }
}

