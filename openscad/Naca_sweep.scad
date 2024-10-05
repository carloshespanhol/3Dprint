// Naca4_sweep.scad - sweep library
// Code: Rudolf Huttary, Berlin 
// 1st release : June 2015
// last update: 2019.03.10
// commercial use prohibited


// Calculates a polyhedron based extrusion. 
// Expects a dataset defined as *non-selfintersecting* sequence of polygons that describes a extrusion trajectory
//  interchangable with skin()
// dat := vector of simple polygons, with polygon := vec of vec3, minimum 3 points per polygon expected
// use "planar_caps = true" only if triangulation of OpenSCAD works flawlessly
module sweep(dat, showslices = false, close = false, planar_caps = true, convexity = 5) 
{
  n = len(dat);     // # datasets
  l = len(dat[0]);  // points per dataset 
  if(l<3) echo("ERROR: sweep() expects more than 3 points per dataset"); 
  if (showslices)  for(i=dat) poly(i);
  else
  {
    obj = sweep(dat, close=close, planar_caps=planar_caps); 
    polyhedron(obj[0], obj[1], convexity = convexity); 
  }
}

module skin(dat, showslices = false, close = false, planar_caps = true, convexity = 5) 
 sweep(dat, showslices, close, planar_caps, convexity); 

function rotate_from_to(a,b) = // matrix for rotation from normal a to normal b
        let( axis = unit(cross(a,b)) )
        axis*axis >= 0.99 ? 
           transpose([unit(b), axis, cross(axis, unit(b))]) * [unit(a), axis, cross(axis, unit(a))] : 
            [[1, 0, 0], [0, 1, 0], [0, 0, 1]];
function transpose(A) = [for(i=[0:2])[for(j=[0:2]) A[j][i]]]; 
function unit(a) = a/norm(a); 
function rotate_from_to(a,b) =  let( axis = unit(cross(a,b)) )
 axis*axis >= 0.99 ? 
  transpose([unit(b), -axis, cross(-axis, unit(b))]) * [unit(a), -axis, cross(-axis, unit(a))] : 
  [[1, 0, 0], [0, 1, 0], [0, 0, 1]];


module sweep_multihole(outer, holes, convexity = 5)
  difference()
  { 
    sweep(outer, convexity = convexity); 
    sweeps(holes, convexity = convexity); 
  }
  

module sweeps(Dat, convexity = 5) // lazy union sweep
{
  soup = sweeps(Dat); 
  polyhedron(soup[0], soup[1], convexity = convexity);  
}

  function sweepsShiftFaces(faces, N) = // helper: calcs face shift indices
    [for(x=faces) [for(y=x) y+N]]; 
    
  function sweepsNewoffs(L, o=0, i=0) = // helper: calcs acculumlated offsets  
      i<=len(L)?concat([o], sweepsNewoffs(L, o+L[i], i+1)):[];

function sweep(dat, close = false, planar_caps = true) = // main sweep function
  let(n=len(dat), l=len(dat[0]))
  let(first = planar_caps?[count(l-1, 0)]: facerev(earcut(dat[0])))
  let(last = planar_caps?[count((n-1)*l,(n)*l-1)]: faces_shift((n-1)*l, (earcut(dat[0])))) 
  let(faces = close?faces_sweep(l,n, close) :concat(first, last, faces_sweep(l,n))) 
  let(points = [for (i=[0:n-1], j=[0:l-1]) dat[i][j]]) // flatten points vector
[points, faces]; 

function count(a, b) = [for (i=[a:(a<b?1:-1):b]) i];  // helper
function faces_shift(d, dat) = [for (i=[0:len(dat)-1]) dat[i] + [d, d, d]]; // helper
  
//// knit polyhedron
  function faces_sweep(l, n=1, close = false) = 
      let(M = n*l, n1=close?n+1:n) 
      concat([[0,l,l-1]],   // first face
             [for (i=[0:l*(n1-1)-2], j = [0,1])
                j==0? [i, i+1, (i+l)%M] 
                    : [i+1, (i+l+1)%M, (i+l)%M]
             ]
             ,[[(n1*l-1)%M, (n1-1)*l-1, ((n1-1)*l)%M]
             ]); // last face
      ;
    
function facerev(dat) = [for (i=[0:len(dat)-1]) [dat[i][0],dat[i][2],dat[i][1]]]; 

//// vector and vector set operation stuff ///////////////////////
//// Expand 2D vector into 3D
function vec3(v,z=0) = v[0][0]==undef?[v[0],v[1],z]:[for(a=v) vec3D(a, z)]; 
function vec2(v) = v[0][0]==undef?[v[0], v[1]]:[for(a=v) vec2(a)]; 
function vec3D(v,z=0) = vec3(v, z); 

// Translation - 1D, 2D, 3D point vector //////////////////////////
//   recursive! operates over vectors, lists of vectors, lists of lists ... 
function T_(x=0, y=0, z=0, v) = let(il=x[0]!=undef?len(x)==3:false)
  let(v = il?y:v, x = il?x:[x, y, z]) v[0][0]!=undef?[for (i=v) T_(x,i)]:v+x; 
function T(x=0, y=0, z=0, v) = T_(x,y,z,v); // synonym
/// translate along one axis
function Tx_(x=0, v=undef) = v[0][0]!=undef?[for (i=v) Tx_(x,i)]:v+[x,0,0]; 
function Tx(x=0, v=undef) = Tx_(x,v); // synonym
function Ty_(y=0, v) = v[0][0]!=undef?[for (i=v) Ty_(y,i)]:v+[0,y,0];  
function Ty(y=0, v) = Ty_(y,v); // synonym
function Tz_(z=0, v) = v[0][0]!=undef?[for (i=v) Tz_(z,i)]:v+[0,0,z]; 
function Tz(z=0, v) = Tz_(z,v); // synonym

//// Rotation - 2D, 3D point vector ///////////////////////////////////
//   recursive! operates over vectors, lists of vectors, lists of lists ... 
// 2D vectors allowed 
function R_(x=0, y=0, z=0, v) = let(len_x_eq_3= x[0]!=undef?len(x)==3:false) 
  let(v = len_x_eq_3?y:v, x=len_x_eq_3?x:[x, y, z])
  v[0][0]!=undef? [for(i=v) R_(x,i)]:Rz_(x[2], Ry(x[1], Rx_(x[0], v)));  
function R(x=0, y=0, z=0, v) = R_(x,y,z,v); // synonym
// rotate around one axis
function Rx_(x, A) = A[0][0]!=undef?[for(i=A) Rx_(x, i)]:
    A*[[1, 0, 0], [0, cos(x), sin(x)], [0, -sin(x), cos(x)]]; 
function Rx(x, A) = Rx_(x, A); // synonym
function Ry_(y, A) = A[0][0]!=undef?[for(i=A) Ry_(y, i)]:
    A*[[cos(y), 0, sin(y)], [0, 1, 0], [-sin(y), 0, cos(y)]]; 
function Ry(y, A) = Ry_(y, A); // synonym
function Rz_(z, A) = let(lenA0is2=A[0]!=undef?len(A)==2:false) 
    A[0][0]!=undef? 
    [for(i=A) Rz_(z, i)]: 
    lenA0is2? 
    A*[[cos(z), sin(z)], [-sin(z), cos(z)]]: 
    A*[[cos(z), sin(z), 0], [-sin(z), cos(z), 0], [0, 0, 1]]; 
function Rz(z, A) = Rz_(z, A); // synonym


//// Scale - 2D, 3D point vectors ///////////////////////////////////
//   recursive! operates over vectors, lists of vectors, lists of lists ... 
function S_(x=1, y=1, z=1, v) = let(len_x_eq_3=x[0]!=undef?len(x)==3:false)
  let(v = len_x_eq_3?y:v, x = len_x_eq_3?x:[x, y, z])
  v[0][0]!=undef?[for (i=v) S_(x,i)]:[v[0]*x[0], v[1]*x[1], v[2]*x[2]]; 
function S(x=1, y=1, z=1, v) = S_(x,y,z,v);     
// scale along one axis
function Sx_(x=0, v) = S_(x=x, v=v); 
function Sx(x=1, v) = Sx_(x,v); // synonym    
function Sy_(y=0, v) = S_(y=y, v=v); 
function Sy(y=1, v) = Sy_(y,v); // synonym    
function Sz_(z=0, v) = S_(z=z, v=v); 
function Sz(z=1, v) = Sz_(z,v); // synonym   

 
 