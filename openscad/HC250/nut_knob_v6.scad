// Based on 'Ultimate Nut Knob Generator' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
use <../lib.scad>
$fn=200;

height=15;

/*[Advanced]*/
function get_diameter_1()=10;

// in percent of Diameter 1 
diameter_2=300; //[100:200]

function get_diameter_2()=get_diameter_1()*diameter_2/100;

/*[Knurled]*/
knurled_height=40; //[10:100]   // in percent of knob height
knurled_density=45; //[0:100]
knurled_strong=4;//[1:20]
knurled_r=sqrt(10*get_diameter_2())/40*knurled_strong;
knurled_r=1.5;

/*[Hidden]*/
function get_knurled_n()= 
    round(sqrt(10*get_diameter_2())*get_knurled_density_factor());
    
function get_knurled_density_factor()=pow(10,knurled_density/50-1);
echo("get_knurled_density_factor()", get_knurled_density_factor());


h1=height-height*knurled_height/100;
rstep=[0,pow(0.1,2),pow(0.2,2),pow(0.3,2),pow(0.4,2),pow(0.5,2),pow(0.6,2),pow(0.7,2),pow(0.8,2),pow(0.9,2),pow(1.0,2)];
rlist=rstep*(get_diameter_2()-get_diameter_1());


//translate([0,0,height]) mirror([0,0,1])
nut_knob();

        
steps=10;
module nut_knob(){
    // Nut Reccess Bridge
    //translate([0, 0, height-8])  cylinder(d=20, h=.1);

	difference()
	{
		union()
		{
            
            translate([0,0,h1])
            cylinder(d=get_diameter_2(), h=height-h1);

			for(n=[0:steps])
                translate([0,0,h1*n/steps])
                cylinder( d1=(get_diameter_1()+rlist[n]), d2=(get_diameter_1()+rlist[n+1]), h=(h1*(n+1)/steps)-(h1*n/steps) );
		}
        
		create_knurled();

        // Chamfer
        translate([0,0,height-1])
        difference(){
            cylinder(d1=get_diameter_2()+2,d2=get_diameter_2(), h=2);
            cylinder(d1=get_diameter_2(),d2=get_diameter_2()-2, h=2);
        }
        
        // Nut
        translate([0, 0, height-(height-5)])
        Mnut(false);
        
        // Nut Reccess
        translate([0, 0, height+.01-8])
        cylinder(d1=14, d2=20, h=8);
	}
}


module create_knurled(){
    translate([0,0,h1])
    difference()
    {    
        for(a=[0:get_knurled_n()-1])
            rotate(360/get_knurled_n()*(a+.5))
            translate([get_diameter_2()/2,0,-2])
            cylinder(r=knurled_r,h=height);
    }
}