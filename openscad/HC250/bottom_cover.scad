$fn=64;
/*
x=400;
y=180;
t=2;
/**/
x=40;
y=18;
t=1;

j=10;

translate([-x/2-.1,0,0])
cube([x/2,y,t]);

cube([x/2,y,t]);

// joint male
#translate([-j,y/2-j/4,t])
hull(){
    cube([j*2,j/2,.1]);
    
    translate([0,-j/4,j/4])
    cube([j*2,j,.1]);    
}

//joint female
difference(){
    
    translate([-j-t,y/2-j/2-t/2,t])
    cube([j*2+t,j+t,j/4+t]);
    
    translate([-j,y/2-j/4,t])
    hull(){
        cube([j*3,j/2,.1]);
        
        translate([0,-j/4,j/4])
        cube([j*3,j,.1]);    
    }
}    



