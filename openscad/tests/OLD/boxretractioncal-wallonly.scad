length=20;
height=3;
width=20;
proportion=2.5;
wallthickness=1;
bottomthickness=.2;

difference(){
    cube(size=[length,width,height],center=true);
    
    
    translate([0,-width/proportion,height/4])
         cube(size=[length/proportion,width*4,height],center=true);
    translate([-length/proportion,0,height/4])
         cube(size=[length*4,width/proportion,height],center=true);
    translate([0,0,bottomthickness])
         cube(size=[length-wallthickness,width-wallthickness,height*2],center=true);
};