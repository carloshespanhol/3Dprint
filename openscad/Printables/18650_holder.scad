$fn=200;

fit=.18;
bd=18.3;
h=5;
t=1.76;
n=5;

for(i = [bd/2+t:bd+t+fit:bd*n+t]){
    translate([i,0,0])
    difference(){
        cylinder(d=bd+t*2+fit, h=h);    
        
        translate([0,0,-.1])
        cylinder(d=bd+fit, h=h+1);
    }
    
    translate([bd/2+t,bd/2+fit,0])
    cube([bd*(n-1)+t*(n-1),t,h]);
    translate([bd/2+t,-bd/2-t-fit,0])
    cube([bd*(n-1)+t*(n-1),t,h]);
}
    