length=30;
height=15;
width=30;
proportion=2.5;
t=1;
bottomthickness=1;

difference(){
    cube([width,length,height]);
    
    translate([1,1,bottomthickness])
    cube([width-t*2,length-t*2,height*2]);
}    