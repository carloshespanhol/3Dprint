translate ([-40,22,86]) rotate([180,0,90]){
//color([0,1,1]) translate ([0,0,0])  rotate([0,0,180])  import_stl("/media/Share/app-srv01/DiskD/Data/ADMIN/Soft/RepRap/STL/For DSLR/My/501PL_v2.stl");
//color([0.5,0.5,0.5]) translate ([-22,45,0])  import_stl("/media/Share/app-srv01/DiskD/Data/ADMIN/Soft/RepRap/STL/For DSLR/My/platform_501PL_v7_fixed.stl")
//color([0.5,0.5,0.5]) translate ([20,30,4]) rotate([90,0,0])rotate([0,-90,0]) import_stl("/media/Share/app-srv01/DiskD/Data/ADMIN/Soft/RepRap/STL/For DSLR/My/platform_501PL_v7_elem2_fixed.stl")
//translate ([0,7,0]) rotate([0,90,0]) cylinder(h=35,r=4/2, $fn=6, center = true);	
}


//---------------------------- test--------------


translate ([0,0,3]) head_1();
color([0,0.5,0.5]) translate ([0,0,14]) rotate ([180,0,0]) head_2();
color([0,0.5,0.7]) translate ([0,0,-8.6]) rotate ([0,0,0]) head_3();
color([0,0.5,0.8]) translate ([0,-51.5,3]) rotate ([-90,0,0]) head_2();
color([0,0.5,0.4]) translate ([0,-27.5,3]) rotate ([-90,0,0]) head_5();
color([0.6,0.4,0.3]) translate ([0,-40.6,3]) rotate ([-90,-90,0])head_4();
color([0.8,0.5,0.7]) translate ([-3,-40.6,43]) rotate ([90,90,-90]) head_5();
color([0.8,0.5,0.5]) translate ([21.1,-40.6,43]) rotate ([90,90,-90]) head_2();
color([0.8,0.8,0.1]) translate ([10,-40.6,43]) rotate ([90,-90,-90]) head_6();


translate ([-30,19,3]) rotate ([0,90,0]) translate ([0,0,-3])pen1();
translate ([10,26,41.5-6]) rotate ([0,70,-90])  translate ([0,0,2])pen();
translate ([47,-40.5,-5.5]) rotate ([60,0,-90]) translate ([0,0,7]) pen1();


//%translate ([0,-33,3]) rotate ([90,90,0]) bolt5x40();
//%translate ([0,0,-4]) rotate ([0,0,0]) bolt5x40();


//%translate ([19,10,3]) rotate ([90,-45,0]) pen2();
//%translate ([19,10,3]) rotate ([0,90,0]) translate ([0,0,-30])pen2();
//%translate ([0,10,0]) rotate ([0,0,0])  bolt5x50();

//------------------------------------------------

//-------------------------print-----------------
//translate ([0,0,0]) rotate ([0,0,0]) head_6();
//translate ([0,0,0]) rotate ([0,0,0])head_4();
//rotate ([0,0,0]) pen();
//rotate ([0,0,0]) pen1();
//------------------------------------------------


module pen()
{
%translate ([0,0,10+9+10]) rotate ([180,0,0]) bolt5x80();

difference() {
	union(){
		for (r = [0:5]) {
	          rotate([0,0,360/5 * r]) {
		difference() {
			translate ([0,7,-20+1]) cylinder(h=28,r1=20/2,r2=12/2,$fn=100,center = true);
			translate ([0,7,-21]) cylinder(h=28,r1=18/2,r2=10/2,$fn=10,center = true);
		}
		difference() {
			translate ([0,7,-36]) cylinder(h=6,r2=20/2,r1=15/2,$fn=100,center = true);
			translate ([0,7,-34]) cylinder(h=6,r2=19/2,r1=14/2,$fn=10,center = true);
		}
		difference() {
			translate ([0,7,-5.5]) sphere(6,$fn=100);
			translate ([0,7,-5.5]) sphere(4.5,$fn=10);
		}
		}
		difference() {
			translate ([0,0,-5.5]) sphere(10.1,$fn=100);
			translate ([0,0,-5.5]) sphere(9,$fn=10);
		}
		  }

translate ([0,0,-22]) rotate ([0,0,0]) cylinder(h=30,r=14/2,$fn=100,center = true);
translate ([0,0,12]) rotate ([0,0,0]) cylinder(h=60,r=14/2,$fn=100,center = true);
}
union(){
		 for (r = [0:5]) {
	          rotate([0,0,360/5 * r]) 
			rotate([0,0,36]) translate ([0,7,-24]) cube ([0.1,5,2],center = true);
			rotate([0,0,0]) translate ([0,7,-20]) cube ([0.1,5,2],center = true);
		}


translate ([0,0,-27.6+9+10]) rotate ([0,0,0]) cylinder(h=3,r2=5.2/2,r1=11/2,$fn=30,center = true);
translate ([0,0,41]) rotate ([0,0,0]) cylinder(h=8,r=9.5/2,$fn=6,center = true);
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=80,r=5.4/2,$fn=100,center = true);
translate ([0,0,-29.01+4]) rotate ([0,0,0]) cylinder(h=30,r=11/2,$fn=100,center = true);
//translate ([0,0,-15]) rotate ([0,0,0]) cube ([50,50,20],center = true);
}
}
}


module pen1()
{
%translate ([0,0,10+9+10]) rotate ([180,0,0]) bolt5x40();

difference() {
	union(){
		for (r = [0:5]) {
	          rotate([0,0,360/5 * r]) {
		difference() {
			translate ([0,7,-20+1]) cylinder(h=28,r1=20/2,r2=12/2,$fn=100,center = true);
			translate ([0,7,-21]) cylinder(h=28,r1=18/2,r2=10/2,$fn=10,center = true);
		}
		difference() {
			translate ([0,7,-36]) cylinder(h=6,r2=20/2,r1=15/2,$fn=100,center = true);
			translate ([0,7,-34]) cylinder(h=6,r2=19/2,r1=14/2,$fn=10,center = true);
		}
		difference() {
			translate ([0,7,-5.5]) sphere(6,$fn=100);
			translate ([0,7,-5.5]) sphere(4.5,$fn=10);
		}
		}
		difference() {
			translate ([0,0,-5.5]) sphere(10.1,$fn=100);
			translate ([0,0,-5.5]) sphere(9,$fn=10);
		}
		  }

translate ([0,0,-22]) rotate ([0,0,0]) cylinder(h=30,r=14/2,$fn=100,center = true);
translate ([0,0,12]) rotate ([0,0,0]) cylinder(h=20,r=14/2,$fn=100,center = true);
}
union(){
		 for (r = [0:5]) {
	          rotate([0,0,360/5 * r]) 
			rotate([0,0,36]) translate ([0,7,-24]) cube ([0.1,5,2],center = true);
			rotate([0,0,0]) translate ([0,7,-20]) cube ([0.1,5,2],center = true);
		}


translate ([0,0,-27.6+9+10]) rotate ([0,0,0]) cylinder(h=3,r2=5.2/2,r1=11/2,$fn=30,center = true);
translate ([0,0,41]) rotate ([0,0,0]) cylinder(h=8,r=9.5/2,$fn=6,center = true);
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=80,r=5.4/2,$fn=100,center = true);
translate ([0,0,-29.01+4]) rotate ([0,0,0]) cylinder(h=30,r=11/2,$fn=100,center = true);
//translate ([0,0,-15]) rotate ([0,0,0]) cube ([50,50,20],center = true);
}
}
}


module pen2()
{
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=40,r=5/2,$fn=100,center = true);
translate ([0,0,-20]) rotate ([0,0,0]) cylinder(h=20,r=16/2,$fn=100,center = true);
translate ([0,10,-20]) rotate ([0,0,0]) cylinder(h=20,r=10/2,$fn=100,center = true);
translate ([0,-10,-20]) rotate ([0,0,0]) cylinder(h=20,r=10/2,$fn=100,center = true);
translate ([0,0,-2]) rotate ([0,0,0]) cylinder(h=2,r=8/2,$fn=100,center = true);
}


module head_1()
{
difference() {

union(){
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=6,r=36/2,$fn=300,center = true);
translate ([0,0,6.5]) rotate ([0,0,0]) cylinder(h=7,r1=36/2,r2=32/2,$fn=300,center = true);
translate ([0,0,-6.5]) rotate ([0,0,0]) cylinder(h=7,r2=36/2,r1=32/2,$fn=300,center = true);
rotate ([0,0,90]) translate ([18,0,0]) rotate ([0,0,0]) {
intersection() {
	intersection() {
		cube ([16,20,20],center = true);
		translate ([-10,0,0]) cylinder(h = 50, r = 20, center = true,$fn=200);
	}
	translate ([-11,0,0]) rotate ([90,0,0]) cylinder(h = 30, r = 20, center = true,$fn=200);
}
}
difference() {
translate ([0,-16,0]) rotate ([0,0,0]) cube ([16,20,20],center = true,$fn=200);
union(){
	translate ([-7,-18.9,12]) rotate ([40,0,90]) cube ([20,10,20],center = true);
	translate ([7,-18.9,12]) rotate ([-40,0,90]) cube ([20,10,20],center = true);
	translate ([7,-18.9,-12]) rotate ([40,0,90]) cube ([20,10,20],center = true);
	translate ([-7,-18.9,-12]) rotate ([-40,0,90]) cube ([20,10,20],center = true);
}
}
}

union(){
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=25.1,r=25/2,$fn=200,center = true);
translate ([0,18,0]) rotate ([0,0,90]) cube ([27,3,27],center = true);
translate ([0,19,0]) rotate ([0,90,0]) cylinder(h=30.1,r=5.2/2,$fn=30,center = true);
translate ([-10,19,0]) rotate ([0,90,0]) cylinder(h=8,r=9.5/2,$fn=6,center = true);
translate ([13,19,0]) rotate ([0,90,0]) cylinder(h=6,r=14/2,$fn=60,center = true);

translate ([0,-19,0]) rotate ([90,0,0]) cylinder(h=30.1,r=5.2/2,$fn=30,center = true);
translate ([0,-14,0]) rotate ([90,90,0]) cylinder(h=6.1,r=9.5/2,$fn=6,center = true);
}
}
}



module head_2()
{
difference() {

union(){
	translate ([0,0,-0.6]) rotate ([0,0,0]) cylinder(h=3,r1=28/2,r2=32/2,$fn=200,center = true);
	translate ([0,0,11]) rotate ([0,0,0]) cylinder(h=20.2,r=24.8/2,$fn=200,center = true);
//	translate ([0,0,22]) rotate ([90,0,0]) cube ([14,4.1,14],center = true);
	translate ([0,7,21.5]) rotate ([90,0,0]) cube ([16,4.1,3],center = true);
	translate ([0,-7,21.5]) rotate ([90,0,0]) cube ([16,4.1,3],center = true);
}

union(){
	translate ([0,0,15]) rotate ([0,0,0]) cylinder(h=30,r=5.2/2,$fn=100,center = true);
	translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=6.1,r1=11.5/2,r2=5.2/2,$fn=30,center = true);
//	translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=6.1,r1=12.5/2,r2=6.2/2,$fn=30,center = true);
}

}
}


module head_3()
{
difference() {

union(){
	translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=3,r2=32/2,r1=36/2,$fn=200,center = true);
	translate ([0,0,-4.5]) rotate ([0,0,0]) cylinder(h=6,r=36/2,$fn=200,center = true);
}

union(){
	translate ([0,0,-5]) rotate ([0,0,0]) cylinder(h=15,r=6.2/2,$fn=100,center = true);
	translate ([0,7,1]) rotate ([90,0,0]) cube ([16.4,4.1,3.4],center = true);
	translate ([0,-7,1]) rotate ([90,0,0]) cube ([16.4,4.1,3.4],center = true);
// test cut
//	translate ([12,12,1]) rotate ([90,0,0]) cube ([24.4,14.1,24.4],center = true);
//
}

}
}

module head_4()
{
difference() {
union(){
	translate ([25,-13,0]) rotate ([0,0,0]) cube ([50,10,20],center = true);
	translate ([20,-9,0]) rotate ([0,0,-20]) cube ([15,5,20],center = true);
	translate ([40,-11,0]) {
difference() {
	translate ([0,0,0]) rotate ([0,0,0]) cube ([16,12,20],center = true);
union(){
	translate ([-6.2,0,-12.9]) rotate ([-40,0,90]) cube ([20,10,20],center = true);
	translate ([6.2,0,12.9]) rotate ([-40,0,90]) cube ([20,10,20],center = true);
	translate ([6.2,0,-12.9]) rotate ([40,0,90]) cube ([20,10,20],center = true);
	translate ([-6.2,0,12.9]) rotate ([40,0,90]) cube ([20,10,20],center = true);
}
}
}

//	translate ([-3,-18,0]) rotate ([0,0,0]) cylinder(h=20,r=10/2,$fn=300,center = true);

rotate ([0,0,30]) {
difference() {

union(){
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=6,r=36/2,$fn=300,center = true);
translate ([0,0,6.5]) rotate ([0,0,0]) cylinder(h=7,r1=36/2,r2=32/2,$fn=300,center = true);
translate ([0,0,-6.5]) rotate ([0,0,0]) cylinder(h=7,r2=36/2,r1=32/2,$fn=300,center = true);

translate ([15,4,0]) rotate ([0,0,0]) {
intersection() {
	intersection() {
		cube ([15,20,20],center = true);
		translate ([-11,0,0]) cylinder(h = 50, r = 20,$fn=300, center = true);
	}

	translate ([-12,0,0]) rotate ([90,0,0]) cylinder(h = 30, r = 20,$fn=300, center = true);
}
}

}

union(){
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=25.1,r=25/2,$fn=300,center = true);
translate ([18,4,0]) rotate ([0,0,0]) cube ([27,3,27],center = true);
translate ([16,5,0]) rotate ([90,0,0]) cylinder(h=25.1,r=5.2/2,$fn=30,center = true);
translate ([16.5,-7,0]) rotate ([90,90,0]) cylinder(h=8.5,r=9.5/2,$fn=6,center = true);
translate ([16.5,17,0]) rotate ([90,0,0]) cylinder(h=6,r=14/2,$fn=60,center = true);


}

}
}
}
union(){
translate ([40,-15,0]) rotate ([90,0,0]) cylinder(h=30.1,r=5.2/2,$fn=30,center = true);
translate ([40,-17,0]) rotate ([90,90,0]) cylinder(h=6.1,r=9.5/2,$fn=6,center = true);
translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=25.1,r=25/2,$fn=100,center = true);
//translate ([23,-5,0]) rotate ([90,0,20]) cylinder(h=4.5,r=9.5/2,$fn=6,center = true);
//обрезка краев
	translate ([47,-13,-15]) rotate ([0,45,0]) cube ([6,40,40],center = true);
	translate ([47,-13,15]) rotate ([0,-45,0]) cube ([6,40,40],center = true);
	translate ([25,-18.9,-7]) rotate ([16,0,0]) cube ([60,4,10],center = true);
	translate ([25,-18.9,7]) rotate ([-16,0,0]) cube ([60,4,10],center = true);

}
}

}



module head_5()
{
difference() {

union(){
//	translate ([0,0,-2]) rotate ([0,0,0]) cylinder(h=2,r=32/2,$fn=100,center = true);
	translate ([0,0,1]) rotate ([0,0,0]) cylinder(h=8,r2=28/2,r1=32/2,$fn=100,center = true);
}

union(){
	translate ([0,0,3.5+1]){
	translate ([-3.22,-4.95,0]) rotate ([0,0,40]) cube ([5,9.2,5],center = true);
	translate ([3.22,-4.95,0]) rotate ([0,0,-40]) cube ([5,9.1,5],center = true);
	translate ([3.22,4.95,0]) rotate ([0,0,40]) cube ([5,9.1,5],center = true);
	translate ([-3.22,4.95,0]) rotate ([0,0,-40]) cube ([5,9.1,5],center = true);

	translate ([0,0,0]) rotate ([0,0,0]) cube ([4.5,20.2,5],center = true);
	translate ([0,0,0]) rotate ([0,0,0]) cube ([16.2,6.2,5],center = true);
}

	translate ([0,7,-1]) rotate ([90,0,0]) cube ([16.4,4.1,3.4],center = true);
	translate ([0,-7,-1]) rotate ([90,0,0]) cube ([16.4,4.1,3.4],center = true);

translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=30.1,r=5.2/2,$fn=30,center = true);

// Test cut
//	translate ([0,16,2]) rotate ([90,0,0]) cube ([16.4,10,25.4],center = true);
//	translate ([0,0,-1]) rotate ([0,0,0]) cylinder(h=8,r=28/2,$fn=100,center = true);
//
}
}

}




module head_6()
{
difference() {
union(){
//	translate ([17,-13,0]) rotate ([0,0,0]) cube ([32,14,20],center = true);

//	translate ([-3,-18,0]) rotate ([0,0,0]) cylinder(h=25,r=10/2,$fn=100,center = true);
rotate ([0,0,20]) {
difference() {

union(){
translate ([0,0,0]) {
translate ([0,0,6.5]) cylinder(h=7,r1=36/2,r2=32/2,$fn=300,center = true);
translate ([0,0,0]) cylinder(h=6,r=36/2,$fn=300,center = true);
translate ([0,0,-6.5]) cylinder(h=7,r2=36/2,r1=32/2,$fn=300,center = true);
difference() {
	translate ([15-5,6,0]) rotate ([0,0,0]) cube ([25+5,27,20],center = true);
	translate ([10-5,24,0]) rotate ([0,0,15]) cube ([25+5,10+2,21],center = true);
}
}
//translate ([4.4,0.55,-3]) rotate ([0,0,70]) oval(37/2,37/2,40/2,6);
//translate ([4.4,0.55,3]) rotate ([0,0,70]) oval(37/2,33.5/2,40/2,7);
//translate ([4.4,0.55,-3]) rotate ([180,0,70]) oval(37/2,33.5/2,40/2,7);
translate ([32,25.5,15+2]) rotate ([0,0,-20]) translate ([0,-3,0]) cube ([12,65,54],center = true);
//translate ([25,30,25]) rotate ([0,0,-20]) translate ([0,-23,0]) cube ([9,30,30],center = true);



}

union(){
translate ([0,0,-1]) rotate ([0,0,0]) cylinder(h=25.1,r=25/2,$fn=100,center = true);
translate ([14,10,-2]) rotate ([0,0,0]) cube ([19,3,26],center = true);
translate ([21,14,10.5]) rotate ([0,0,0]) cube ([5,11,1],center = true);
translate ([22.6,19,-2]) rotate ([0,0,0]) cube ([2,21,26],center = true);
translate ([15.5,10,0]) rotate ([90,0,0]) cylinder(h=40.1,r=5.2/2,$fn=30,center = true);
translate ([15.5,-19,0]) rotate ([90,90,0]) cylinder(h=27,r=9.5/2,$fn=6,center = true);
translate ([0,0,15]) rotate ([0,0,0]) cylinder(h=10,r=35/2,$fn=100,center = true);
translate ([39+2,32,15]) rotate ([0,0,-20]) translate ([0,-3,0]) cube ([6,100,100],center = true);

}
}
}
}
union(){

translate ([22,0,30]) rotate ([0,90,0]) cylinder(h=34,r=40/2,$fn=230,center = true);
translate ([19,10,40]) rotate ([0,0,0]) cube ([12,20,20],center = true);
translate ([15,43,17]) rotate ([0,0,0]) cube ([9,20,28],center = true);
translate ([15,43,30]) rotate ([0,90,0]) cylinder(h=9,r=20/2,$fn=30,center = true);
translate ([15,43,3]) rotate ([0,90,0]) cylinder(h=9,r=20/2,$fn=30,center = true);
translate ([20,43,16]) rotate ([0,90,0]) cylinder(h=10,r=6.2/2,$fn=30,center = true);
translate ([20,43,31]) rotate ([0,90,0]) cylinder(h=10,r=6.2/2,$fn=30,center = true);
translate ([20,43,1]) rotate ([0,90,0]) cylinder(h=10,r=6.2/2,$fn=30,center = true);


//translate ([18,56,3]) cut_elem();
//translate ([18,30,3]) cut_elem();
//translate ([18,56,26]) cut_elem();
//translate ([18,30,26]) cut_elem();
}
}
}




module cut_elem(){

intersection() {
	union(){
		translate ([0,0,0]) rotate ([0,0,0]) cube ([5,10,8],center = true);
		translate ([0,0,4]) rotate ([45,0,0]) cube ([5,7,7],center = true);
		translate ([0,0,-4]) rotate ([45,0,0]) cube ([5,7,7],center = true);
	}
	translate ([0,0,0]) rotate ([0,0,0]) cube ([6,13,17],center = true);
}
}

module bolt5x40()
{
difference() {

union(){
	translate ([0,0,18.5]) rotate ([0,0,0]) cylinder(h=3,r1=5/2,r2=9/2,$fn=30,center = true);
	translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=40,r=5/2,$fn=300,center = true);
}

union(){
	translate ([0,0,20]) rotate ([0,90,0]) cylinder(h=1.5,r=5/2,$fn=4,center = true);
	translate ([0,0,20]) rotate ([90,90,0]) cylinder(h=1.5,r=5/2,$fn=4,center = true);

}

}
}


module bolt5x50()
{
difference() {

union(){
	translate ([0,0,23.5]) rotate ([0,0,0]) cylinder(h=3,r1=5/2,r2=9/2,$fn=30,center = true);
	translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=50,r=5/2,$fn=300,center = true);
}

union(){
	translate ([0,0,25]) rotate ([0,90,0]) cylinder(h=1.5,r=5/2,$fn=4,center = true);
	translate ([0,0,25]) rotate ([90,90,0]) cylinder(h=1.5,r=5/2,$fn=4,center = true);

}

}
}

//bolt5x80();
module bolt5x80()
{
difference() {

union(){
	translate ([0,0,23.5+15]) rotate ([0,0,0]) cylinder(h=3,r1=5/2,r2=9/2,$fn=30,center = true);
	translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=80,r=5/2,$fn=300,center = true);
}

union(){
	translate ([0,0,25+15]) rotate ([0,90,0]) cylinder(h=1.5,r=5/2,$fn=4,center = true);
	translate ([0,0,25+15]) rotate ([90,90,0]) cylinder(h=1.5,r=5/2,$fn=4,center = true);

}

}
}

module oval(w1,w2,h, height, center = false) {
scale([1, h/w1, 1]) cylinder(h=height, r1=w1,r2=w2, center=center,$fn=300);
}