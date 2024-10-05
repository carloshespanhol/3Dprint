$fn=100;

for(i=[5:5:25]){
    translate([0,0,25-i])
    cylinder(d=i, h=5);
}    