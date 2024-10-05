/* Webcam Cover generator v1.0
 * By: Kleinjoni aka. sneezegray
 *
 * - change the values like you want 
 * - render(F6)
 * - look if everything fits, maybe change values again 
 * - change print=true 
 * - export .stl file
 * 
 */
 function multiple(Size,Unit) = Unit * ceil(Size / Unit);
/////////// Settings /////////////
//////////////////////////////////
lw=0.7201; // line width

// print=true putts the parts in printable position 
print=true;

// the border width
border=lw * 5;
echo(border);
// the outer dimmensions
// width    40 - Carlos Carol
//          35 - Gabi
widht = 40 + border*2;
height= 9 + border*2;
thickness=1.2;
// the width of the webcam cover
camW=20; 
// Design Options
cubic=false;
// stripe widht( 0 if not wanted)
stripes=0.88; 
// how facet rich it should be
$fn=200; 
// spacing Options
// upper gap
gap1=0.12; 
// middel spacing Gap(mostly not necessary)
gap2=0.12; 
// under gap
gap3=0.12;
// The size difference of the overlapping parts (in Percent) .
under=25; 
//////////////////////////////////
//////////////////////////////////
diff=under/100;
thick=multiple(thickness, lw);

echo("<b>overlapping downpart thickness:", thick ,"</b>");
echo("<b>overlapping uperpart thickness:", thickness-diff-gap2 ,"</b>");
echo("<b>webcam height :", height-border*2 ,"</b>");

module rcube(w,h,t,cu) {
union(){
if(cu==false){
w=w-h;
translate([w/2,0,0]) {cylinder(t,h/2,h/2);}
translate([-w/2,0,0]) {cylinder(t,h/2,h/2);}
translate([-w/2,-h/2,0]) {cube([w,h,t]);}
}
if(cu==true){
translate([-w/2,-h/2,0]) {cube([w,h,t]);}
}
}
}

if(print==true){
    translate([0,height,thickness])rotate([180,0,0])
    oval();
}else{
    oval();
}

module oval(){
    difference(){
        rcube(widht+10,height,thickness,cubic);
        
        translate([0,0,+.01]) 
        rcube((widht-border*2),(height-border*2),thickness,cubic);
        translate([0,0,-.01])  
        rcube((widht-border*2),(height-lw*4), thickness/2+gap2,cubic);
    }
}


// Cover
translate([widht/2-border-camW/2,0,0]) {
    difference(){
        union(){
            rcube((camW-gap1),(height-border*2-gap1*1.5),(thickness),cubic);
            rcube((camW-gap3),(height-lw*4-gap3),(thickness/2 - gap2),cubic);
        }

        translate([-camW/2-(height+border)/2+stripes,-height/2, thickness/2]) 
        linear_array( count=30, distance=1.76)  cube([stripes,height+border,1]);

    }
}

module linear_array( count, distance ) {
    for ( i= [1:1:count])  {
        translate([distance*i,0,0,]) 
        children();
    }
}
