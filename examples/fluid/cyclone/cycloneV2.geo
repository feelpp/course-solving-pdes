// GMSH Geometry Model of a Standard Cyclone (Gas-Solid) Separator 
// Author: John F. Porter
//
// Key to variables:
// D2 = cylindrical body diameter
// H = height of inlet duct
// W = width of inlet duct
// De = gas exhaust diameter
// L1 = height of main cylinder body 
// L2 = height of cone
// L3 = distance inner cylinder extends below inlet duct
// Dd = solid (dust) outlet diameter (see comment on 'rsout' below)
// Ld = length of cylindrical solid (dust) outlet
// Le = height of cylindrical gas exhaust to bend above roof
// Lre = length of cylindrical gas exhaust after bend
// Li = length of straight inlet duct
// base = elevation of bottom of solid (dust) outlet
// gap = distance from top of inlet duct to roof of cylindrical body
// th = thickness of inner cylinder wall
//
// Standard dimensions of Swift high efficiency cyclone used here,
// expressed as ratios to D2:
//
D2=1.0;
H=0.44*D2;
W=0.21*D2;
De=0.4*D2;
L1=1.4*D2;
L2=2.5*D2;
L3=0.06*D2;
Dd=0.4*D2;
//
// radii are easier to use in subsequent expressions:
rd=Dd/2.0;
r2=D2/2.0;
re=De/2.0;
//
// non-standard dimensions:
Ld=1.0*r2;
Le=0.5*r2;
Li=2.5*r2;
base=9.0;
gap=0.05*r2;
Lre=0.5*r2;
// reduce the solid outlet diameter to allow pressure balancing
// - used if CFD solver restricts available boundary conditions
// - otherwise set to slightly smaller than 'rd'
rsout=rd/4;
//
// internal cylinder wall thickness
th=0.15*r2;
//
// parameter used to define opening where rectangular gas inlet duct
// and cylindrical cyclone body meet
alpha=Asin((r2-W)/r2);

// characteristic length for meshing
lc=0.1*r2; // M2
lc=0.2*r2; //M0
lc=0.15*r2; //M1



// main cone
// circle made up of 3 arcs each of angle (pi/2) plus two additional 
// arcs to match gas inlet
r=r2;
x0=0;
y0=0;
z0=(base+Ld+L2);

Point(1)={x0,y0,z0,lc};
Point(2)={x0+r*Cos(1.5*Pi+alpha),y0+r*Sin(1.5*Pi+alpha),z0,lc};
Point(3)={x0+r*Cos(0),y0+r*Sin(0),z0,lc};
Point(4)={x0+r*Cos(0+Pi/6),y0+r*Sin(0+Pi/6),z0,lc};
Point(5)={x0+r*Cos(0.5*Pi+Pi/6),y0+r*Sin(0.5*Pi+Pi/6),z0,lc};
Point(6)={x0+r*Cos(Pi+Pi/6),y0+r*Sin(Pi+Pi/6),z0,lc};
Point(7)={x0+r*Cos(1.5*Pi+Pi/6),y0+r*Sin(1.5*Pi+Pi/6),z0,lc};
//
Circle(8)={2,1,3};
Circle(9)={3,1,4};
Circle(10)={4,1,5};
Circle(11)={5,1,6};
Circle(12)={6,1,7};
Circle(13)={7,1,2};
Line Loop(14) = {8,9,10,11,12,13};


//
r=rd;
x0=0;
y0=0;
z0=(base+Ld);
Point(21)={x0,y0,z0,lc};
Point(22)={x0+r*Cos(1.5*Pi+alpha),y0+r*Sin(1.5*Pi+alpha),z0,lc};
Point(23)={x0+r*Cos(0),y0+r*Sin(0),z0,lc};
Point(24)={x0+r*Cos(0+Pi/6),y0+r*Sin(0+Pi/6),z0,lc};
Point(25)={x0+r*Cos(0.5*Pi+Pi/6),y0+r*Sin(0.5*Pi+Pi/6),z0,lc};
Point(26)={x0+r*Cos(Pi+Pi/6),y0+r*Sin(Pi+Pi/6),z0,lc};
Point(27)={x0+r*Cos(1.5*Pi+Pi/6),y0+r*Sin(1.5*Pi+Pi/6),z0,lc};

//
Circle(28)={23,21,24};
Circle(29)={24,21,25};
Circle(30)={25,21,26};
Circle(31)={26,21,27};
Circle(32)={27,21,22};
Circle(33)={22,21,23};
//
Line Loop(34) = {28,29,30,31,32,33};

Line(140)={23,3};

Extrude {{0,0,1}, {0,0,0}, Pi/6} { Line{140}; }
Extrude {{0,0,1}, {0,0,0}, Pi/2} { Line{141}; }
Extrude {{0,0,1}, {0,0,0}, Pi/2} { Line{145}; }
Extrude {{0,0,1}, {0,0,0}, Pi/2} { Line{149}; }
Extrude {{0,0,1}, {0,0,0}, (alpha-Pi/6)} { Line{153}; }
Extrude {{0,0,1}, {0,0,0}, (Pi/2-alpha)} { Line{157}; }

Plane Surface(170)={-14};
Plane Surface(171)={34};



// solid outlet
// extend plane surface in Z-direction to form cylinder
Extrude {0,0,-Ld} { Surface{171};}
Delete{Volume{1};}
Delete{Surface{171};}



// gas outlet
r=re;
x0=0.0;
y0=0.0;
z0=base+Ld+L2+L1-H-L3;
//arc start point
Point(60)={x0+r*Cos(0),y0+r*Sin(0),z0,lc};
Point(70)={x0+(r+th)*Cos(0),y0+(r+th)*Sin(0),z0,lc};
//arc centre point
Point(61)={x0,y0,z0,lc};
//Point(71)={x0,y0,z0,lc};
//first arc end point
Point(62)={x0+r*Cos(Pi/2),y0+r*Sin(Pi/2),z0,lc};
Point(72)={x0+(r+th)*Cos(Pi/2),y0+(r+th)*Sin(Pi/2),z0,lc};
//second arc end point
Point(63)={x0+r*Cos(Pi),y0+r*Sin(Pi),z0,lc};
Point(73)={x0+(r+th)*Cos(Pi),y0+(r+th)*Sin(Pi),z0,lc};
//third arc end point
Point(64)={x0+r*Cos(3*Pi/2),y0+r*Sin(3*Pi/2),z0,lc};
Point(74)={x0+(r+th)*Cos(3*Pi/2),y0+(r+th)*Sin(3*Pi/2),z0,lc};
//
Circle(65)={60,61,62};
Circle(66)={62,61,63};
Circle(67)={63,61,64};
Circle(68)={64,61,60};
//
Line Loop(69) = {65,66,67,68};
Plane Surface(550) = {-69};

Circle(75)={70,61,72};
Circle(76)={72,61,73};
Circle(77)={73,61,74};
Circle(78)={74,61,70};
//
Line Loop(79) = {75,76,77,78};
Plane Surface(570) = {79};

// extend planes in Z-direction
Extrude {0,0,(L3+H+gap)} { Surface{570};}
Extrude {0,0,(L3+H+Le)} { Surface{550};}


Line Loop(303)={78,77,76,75};
Line Loop(304)={68,67,66,65};
Plane Surface(305)={-303,-304};



//Gas inlet
Plane Surface(387)={-14};
Extrude {0,0,(L1-H)} { Surface{387};} 

r=r2;
x0=0.0;
y0=0.0;
z0=base+Ld+L2+L1-H;
Point(280)={x0+r*Cos(0),y0+r*Sin(0),z0,lc};
Point(281)={x0,y0,z0,lc};
Point(282)={x0+r*Cos(3*Pi/2+alpha),y0+r*Sin(3*Pi/2+alpha),z0,lc};
Point(283)={x0+r*Cos(0),y0+r*Sin(0),z0+H,lc};
Point(284)={x0,y0,z0+H,lc};
Point(285)={x0+r*Cos(3*Pi/2+alpha),y0+r*Sin(3*Pi/2+alpha),z0+H,lc};

Point(286)={x0+r*Cos(3*Pi/2+alpha),-Li,z0,lc};
Point(287)={x0+r*Cos(0),-Li,z0,lc};
Point(288)={x0+r*Cos(3*Pi/2+alpha),-Li,z0+H,lc};
Point(289)={x0+r*Cos(0),-Li,z0+H,lc};

Circle(290)={280,281,282};
Circle(291)={283,284,285};
Line(292) = {280,283};
Line(293) = {285,282};
Line Loop(294)={290,-293,-291,-292};

// gas inlet 
Line(296)={286,287};
Line(297)={287,289};
Line(298)={289,288};
Line(299)={288,286};
Line Loop(400)={296,299,298,297};
Plane Surface(401)={-400};

Line(402)={280,287};
Line(403)={282,286};
Line(404)={285,288};
Line(405)={283,289};
Line Loop(407)={290,403,296,-402};
Plane Surface(408)={407};
Extrude {0,0,H} { Surface{408};}
Extrude {0,0,H} { Surface{646};} 
Extrude {0,0,gap} { Surface{700};} 

Delete { Surface{408,646,700,732};}
Delete { Volume{1,2,3,4,5,6};}



// roof:
Line Loop(800)={702,703,704,705,706,707};
Line Loop(801)={572,573,574,575};
Plane Surface(802)={800,801};



//extend gas outlet via a curved pipe
height = base+Ld+L2+L1+Le;
centre=1.5*De;
Extrude {{0.0, 1.0, 0.0}, {centre,0.0,height}, Pi/2} { Line{594};}
Extrude {{0.0, 1.0, 0.0}, {centre,0.0,height}, Pi/2} { Line{595};}
Extrude {{0.0, 1.0, 0.0}, {centre,0.0,height}, Pi/2} { Line{596};}
Extrude {{0.0, 1.0, 0.0}, {centre,0.0,height}, Pi/2} { Line{597};}

// and close the resulting line loop into a surface for subsequent extrusion
Line Loop(816) ={803,807,811,815};
Plane Surface(817) = {816};
// extend plane surface in X-direction to form tube to outlet
Extrude {Lre,0,0} { Surface{817};}
Delete { Volume{6};}


//
// reduce the solid outlet diameter to allow pressure balancing
// (use if CFD solver restricts available boundary conditions) 
//
r=rsout;
x0=0;
y0=0;
z0=base;
Point(901)={x0,y0,z0,lc};
Point(902)={x0+r*Cos(1.5*Pi+alpha),y0+r*Sin(1.5*Pi+alpha),z0,lc};
Point(903)={x0+r*Cos(0),y0+r*Sin(0),z0,lc};
Point(904)={x0+r*Cos(0+Pi/6),y0+r*Sin(0+Pi/6),z0,lc};
Point(905)={x0+r*Cos(0.5*Pi+Pi/6),y0+r*Sin(0.5*Pi+Pi/6),z0,lc};
Point(906)={x0+r*Cos(Pi+Pi/6),y0+r*Sin(Pi+Pi/6),z0,lc};
Point(907)={x0+r*Cos(1.5*Pi+Pi/6),y0+r*Sin(1.5*Pi+Pi/6),z0,lc};

//
Circle(908)={903,901,904};
Circle(909)={904,901,905};
Circle(910)={905,901,906};
Circle(911)={906,901,907};
Circle(912)={907,901,902};
Circle(913)={902,901,903};
//
Line Loop(914) = {908,909,910,911,912,913};
Line Loop(915) = {173,174,175,176,177,178};
Delete { Surface{203};}
Plane Surface(916)={914};
Plane Surface(917)={915,914};



// external surface plus inlet and outlets
Surface Loop(950)={916,917, 182,186,190,194,198,202, 164,144,148,152,156,160, 625,645,641,637,633,629, 683,679,-659,408,401,-668,-667,695,691,687, 719,715,711,731,727,723, 802, 579,583,587,591, 305, 601,605,609,613, 818,814,810,806, 827,839,835,831, 840};
// cyclone internal volume for meshing
Volume(1000)={950};






// Component surfaces - each line defines one part of the cyclone
//Surface Loop(900)={916,917,
// 182,186,190,194,198,202,
// 164,144,148,152,156,160,
// 625,645,641,637,633,629,
// 683,679,-659,408,401,-668,-667,695,691,687,
// 719,715,711,731,727,723,
// 802,
// 579,583,587,591,
// 305,
// 601,605,609,613,
// 818,814,810,806,
// 827,839,835,831,
// 840}


View "comments" {
// 10 pixels from the left and 15 pixels from the top of the graphic
// window:
T2(10,15,0){"Model of cyclone geometry by John F. Porter"};
};

Coherence;//+
Delete {
  Surface{700};
}
//+
Delete {
  Surface{732};
}
//+
Delete {
  Surface{592};
}
//+
Delete {
  Surface{646};
}
//+
Delete {
  Surface{570};
}
//+
Point(908) = {0, -0.5, 9, lc};
Point(909) = {0, +0.5, 9, lc};
Point(910) = {-0.5, 0, 9, lc};
Point(911) = {0.5, 0, 9, lc};

Point(912) = {0, -0.5, 8, lc};
Point(913) = {0, +0.5, 8, lc};
Point(914) = {-0.5, 0, 8, lc};
Point(915) = {0.5, 0, 8, lc};
Point(916) = {0, 0, 8, lc};
//+
Circle(1001) = {908, 29, 910};
//+
Circle(1002) = {910, 29, 909};
//+
Circle(1003) = {909, 29, 911};
//+
Circle(1004) = {911, 29, 908};
//+
Circle(1005) = {912, 916, 914};
//+
Circle(1006) = {914, 916, 913};


//+
Circle(1007) = {913, 916, 915};
//+
Circle(1008) = {915, 916, 912};
//+
Line(1009) = {908, 912};
//+
Line(1010) = {911, 915};
//+
Line(1011) = {909, 913};
//+
Line(1012) = {910, 914};
//+
Line Loop(1013) = {1001, 1002, 1003, 1004};
//+
Plane Surface(1014) = {915, 1013};
//+
Line Loop(1015) = {1008, 1005, 1006, 1007};
//+
Plane Surface(1016) = {1015};
//+
Line Loop(1017) = {1004, 1009, -1008, -1010};
//+
Ruled Surface(1018) = {1017};
//+
Line Loop(1019) = {1003, 1010, -1007, -1011};
//+
Ruled Surface(1020) = {1019};
//+
Line Loop(1021) = {1006, -1011, -1002, 1012};
//+
Ruled Surface(1022) = {1021};
//+
Line Loop(1023) = {1005, -1012, -1001, 1009};
//+
Ruled Surface(1024) = {1023};
//+
Surface Loop(1025) = {1024, 1016, 1018, 1014, 1020, 1022, 917, 916};
//+
Volume(1026) = {1025};


// Defining simulation boundaries 
Physical Surface("wall")={ 182,186,190,194,198,202, 164,144,148,152,156,160, 625,645,641,637,633,629, 683,679,-659,408,-668,-667,695,691,687, 719,715,711,731,727,723, 802, 579,583,587,591, 305, 601,605,609,613, 818,814,810,806, 827,839,835,831,1014,1016,1018,1020,1022,1024};
Physical Surface("inlet")={401};
//Physical Surface("solid_outlet")={916,917};
Physical Surface("gas_outlet")={840};
//Physical Surface("roof")={802};
Physical Volume("internal_volume")={1000,1026};
