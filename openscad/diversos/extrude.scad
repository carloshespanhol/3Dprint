use <path_extrude.scad>;


myPathTrefoil = [ for(t = [0:(360 / 101):365]) [ // trefoil knot
    5*(.41*cos(t) - .18*sin(t) - .83*cos(2*t) - .83*sin(2*t) -
       .11*cos(3*t) + .27*sin(3*t)),
    5*(.36*cos(t) + .27*sin(t) - 1.13*cos(2*t) + .30*sin(2*t) +
       .11*cos(3*t) - .27*sin(3*t)),
    5*(.45*sin(t) - .30*cos(2*t) +1.13*sin(2*t) -
       .11*cos(3*t) + .27*sin(3*t))] ];

myPointsOctagon =
  let(ofs1=15)
  [ for(t = [0:(360/8):359])
     ((t==90)?1:2) * [cos(t+ofs1),sin(t+ofs1)]];
myPointsChunkOctagon =
  let(ofs1=15)
  [ for(t = [0:(360/8):359])
    ((t==90)?0.4:1.9) *
     [cos((t * 135/360 + 45)+ofs1+45)+0.5,sin((t * 135/360 + 45)+ofs1+45)]];
myPoints = [ for(t = [0:(360/8):359]) 2 * [cos(t+45),sin(t+45)]];

pts=[2,0,0.5];

translate([0,0,0]) {
    path_extrude( exShape=myPoints,
                 exPath=myPathTrefoil, merge=true);
}
