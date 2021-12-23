$fn=100;
module door(height, widthRatio, thickness, segNum, segDepthRatio, borderSize, knobHeight, knobWidth, knobPieceHeight, knobPieceWidth){
    width = height*widthRatio;
    difference() {
    cube([width, thickness, height], center=true);
    segThickness = segDepthRatio*thickness;
    segHeight = (height-(segNum+1)*borderSize)/segNum;
    segWidth = width-borderSize*2;
    for (i=[0:1:segNum-1]) {
        translate([0,(thickness-segThickness)/2,borderSize+i*(segHeight+borderSize)+segHeight/2-height/2]) cube([segWidth, segThickness+0.01, segHeight], center=true);
    }
    }
    translate([-(-width+borderSize)/2, (thickness+knobPieceHeight)/2, 0]) rotate([90, 0, 0]) cylinder(r=knobPieceWidth/2,h=knobPieceHeight, center=true);
    translate([-(-width+borderSize)/2, thickness/2+knobPieceHeight, 0]) resize([knobWidth, knobWidth, knobHeight]) sphere(r=1);
}
door(40, rands(0.3,0.6,1)[0], 2, 4, 0.2, 2, 2, 1, 1, 1);