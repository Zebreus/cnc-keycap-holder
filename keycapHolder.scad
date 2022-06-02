coreWidth = 40;
baseHeight = 6;
mountRadius = 2.5;
mountDistance = 20;
mountMargin = 5;
baseDepth = mountDistance + (mountMargin*2);
baseWidth = coreWidth + (mountMargin*4);
baseBuffer = 3;
screwHeight = 7.5;
screwRadius = 2;
nutHeight = 3.5;
nutRadius = 3.9;


normalDimensions = [18,18,13,14,2.5,1,9.6];
module mirror_copy(vector){
    children();
    mirror(vector)
    children();
}

module Base(bottom){
    difference(){
if(bottom){
    union(){
    translate(-[baseWidth, baseDepth,0]/2)
    cube([baseWidth, baseDepth, baseHeight]);
cylinder(baseHeight, d=coreWidth);
}}else{
translate([0,0,baseHeight])
cylinder(screwHeight+nutHeight-baseHeight, d=coreWidth);
}
for(i = [0,90,180,270])
rotate(i, [0,0,1])
translate([coreWidth/2-mountMargin,0,0])
union(){
translate([0,0,-1])
cylinder($fn=6, nutHeight+1,r = nutRadius);
translate([0,0,nutHeight-1])
cylinder($fn=20, screwHeight+2, r = screwRadius);
}
mirror_copy([1,0,0])
mirror_copy([0,1,0])
translate([baseWidth/2 - (mountMargin),mountDistance/2,-1])
cylinder(baseHeight+2,r=mountRadius);
translate([-9,-9,baseHeight/2])
cube([18,18,baseHeight/2+0.01]);
    }
}

module keycap(dimensions){  
width = dimensions[0];
length = dimensions[1];
topWidth = dimensions[2];
topLength = dimensions[3];
xOffset = dimensions[4];
yOffset = dimensions[5];
height = dimensions[6];

CubePoints = [
  [  0,  0,  0 ],  //0
  [ width,  0,  0 ],  //1
  [ width,  length,  0 ],  //2
  [  0,  length,  0 ],  //3
  [  xOffset,  yOffset,  height],  //4
  [ xOffset+topWidth,  yOffset,  height],  //5
  [ xOffset+topWidth,  yOffset+topLength,  height],  //6
  [  xOffset,  yOffset+topLength,  height]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
translate(-[width, length,0]/2)
polyhedron( CubePoints, CubeFaces );
}
difference(){
Base(false);
translate([0, 0,baseHeight]/2)
keycap(normalDimensions);
}
