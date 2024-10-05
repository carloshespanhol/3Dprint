m=2;
x=50;
y=20;
h=2;
ls=3;

hull(){
    cube([x,y,.1]);

    translate([0,h,h])
    cube([x,y-h*2,.1]);
}

//emboss text
translate([m, y-m*2-ls, h])
linear_extrude(height = 1.5)
    text(text="Claudia B.B. Hespanhol", font="Arial:style= Bold", size=ls, valign="bottom", halign="left");

translate([m, y-m*2-ls*2-1, h])
linear_extrude(height = 1.5)
    text(text="Gerente de HRServices", font="Arial:style= Bold", size=ls, valign="bottom", halign="left");

translate([m, y-m*2-ls*3-3, h])
linear_extrude(height = 1.5)
    text(text="CPF: 002.790.277-37", font="Arial:style= Bold", size=ls, valign="bottom", halign="left");
