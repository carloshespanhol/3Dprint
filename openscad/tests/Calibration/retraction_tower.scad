$fs=0.2;
$fn=200;

dist=40;
size=6;
step_height=1;
steps=5;
transition_height=.4;

/******/
d=dist;
s=size;
th=transition_height;
sh=step_height-th;
st=steps;

for(i=[0:st-.1]){
    translate([0,0,i*(sh+th)]){
        transition1();
        step();
        transition2();
    }
}
/**/
translate([-s*1.5,-s*1.25,0])
rcube(d+s*3,s*2.5,0.6,3);
/**/

module step(){
    translate([-s,-s/2,sh-th])
    cube([s,s,sh]);
    
    translate([d+s/2,0,sh-th*3/2])
    cylinder(d=s, h=sh+th);

    translate([d+s/2,0,sh+th-.2])
    cylinder(d=s+th, h=.2);
}

module transition1(){
    hull(){
        translate([-s,-s/2,th/2])
        cube([s,s,.01]);

        translate([-s+th/2,-s/2+th/2,0])
        cube([s-th,s-th,.01]);
    }
}    
module transition2(){
    hull(){
        translate([-s,-s/2,sh+th/2])
        cube([s,s,.01]);

        translate([-s+th/2,-s/2+th/2,sh+th])
        cube([s-th,s-th,.01]);
    }    
}    

module rcube(length,width,height,r=.5){ 
    l=length-2*r;
    w=width-2*r;    
    translate([r,r,0]){
        cylinder(r=r,h=height);    
        translate([0,w,0])
        cylinder(r=r,h=height);    
        translate([l,0,0])
        cylinder(r=r,h=height);    
        translate([l,w,0])
        cylinder(r=r,h=height);    
    }
    // Inner cubes
    translate([0,r,0])
    cube([length,w,height]);
    translate([r,0,0])
    cube([l,width,height]);
}



