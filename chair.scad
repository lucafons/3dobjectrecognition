$fn=100;
module chairLeg(height, width, radius) {
    resize([width, width, height]) minkowski() {
        cube([10, 10, 1],center=true);
        cylinder(h=1,r=radius,center=true);
    }
}
module curvePiece(radius) {
    union() {
        minkowski() {
            cube([10, 10, 1],center=true);
            cylinder(h=1,r=radius,center=true);
        }
        translate([0, -radius*0.5, 0]) cube([10+radius*2, 10+radius, 2], center=true);
    }
}
module chair(legHeight, legWidth, legRadius, seatWidthX, seatRatioY, seatHeight, seatRadius, legOffset, backWidth, backHeight, backRatio, backRadius) {
    translate([(seatWidthX/2-legOffset-legWidth/2-seatRadius/2), (seatWidthX*seatRatioY/2-legOffset-legWidth/2-seatRadius/2), -legHeight/2-seatHeight/2]) chairLeg(legHeight, legWidth, legRadius);
    translate([-(seatWidthX/2-legOffset-legWidth/2-seatRadius/2), (seatWidthX*seatRatioY/2-legOffset-legWidth/2-seatRadius/2), -legHeight/2-seatHeight/2]) chairLeg(legHeight, legWidth, legRadius);
    translate([(seatWidthX/2-legOffset-legWidth/2-seatRadius/2), -(seatRatioY*seatWidthX/2-legOffset-legWidth/2-seatRadius/2), -legHeight/2-seatHeight/2]) chairLeg(legHeight, legWidth, legRadius);
    translate([-(seatWidthX/2-legOffset-legWidth/2-seatRadius/2), -(seatWidthX*seatRatioY/2-legOffset-legWidth/2-seatRadius/2), -legHeight/2-seatHeight/2]) chairLeg(legHeight, legWidth, legRadius);
    resize([seatWidthX, seatWidthX*seatRatioY, seatHeight]) curvePiece(seatRadius);
    translate([0, -seatWidthX*seatRatioY/2+backWidth/2, (backHeight+seatHeight)/2]) resize([seatWidthX*backRatio, backWidth, backHeight]) rotate([90, 0, 0]) curvePiece(backRadius);
}
module chairWithArms(legHeight, legWidth, legRadius, seatWidthX, seatRatioY, seatHeight, seatRadius, legOffset, backWidth, backHeight, backRatio, backRadius, armWidth, armRatio, armHeightRatio) {
    chair(legHeight, legWidth, legRadius, seatWidthX, seatRatioY, seatHeight, seatRadius, legOffset, backWidth, backHeight, backRatio, backRadius);
    armLength = (seatWidthX*seatRatioY-backWidth)*armRatio;
    translate([(seatWidthX*backRatio-armWidth)/2, (-seatWidthX*seatRatioY+armLength+backWidth)/2, backHeight*armHeightRatio+seatHeight/2]) cube([armWidth, armLength, armWidth], center=true);
    translate([(seatWidthX*backRatio-armWidth)/2, (-seatWidthX*seatRatioY/2+armLength+backWidth/2-armWidth/2), (backHeight*armHeightRatio-armWidth/2+seatHeight)/2]) cube([armWidth, armWidth, backHeight*armHeightRatio-armWidth/2], center=true);
    translate([-(seatWidthX*backRatio-armWidth)/2, (-seatWidthX*seatRatioY+armLength+backWidth)/2, backHeight*armHeightRatio+seatHeight/2]) cube([armWidth, armLength, armWidth], center=true);
    translate([-(seatWidthX*backRatio-armWidth)/2, (-seatWidthX*seatRatioY/2+armLength+backWidth/2-armWidth/2), (backHeight*armHeightRatio-armWidth/2+seatHeight)/2]) cube([armWidth, armWidth, backHeight*armHeightRatio-armWidth/2], center=true);

    
}
//chairWithArms(rands(10,30,1)[0], rands(2.5,6,1)[0], rands(0,20,1)[0], rands(25,60,1)[0], rands(0.5,1.5,1)[0], rands(2,10,1)[0], rands(0,10,1)[0], rands(1,3,1)[0], rands(2,10,1)[0], rands(20,40,1)[0], rands(0.8,1,1)[0], rands(0,10,1)[0], rands(2,8,1)[0], rands(0.5,0.9,1)[0], rands(0.3,0.6,1)[0]);
chair(rands(10,30,1)[0], rands(2.5,6,1)[0], rands(0,20,1)[0], rands(25,60,1)[0], rands(0.5,1.5,1)[0], rands(2,10,1)[0], rands(0,10,1)[0], rands(1,3,1)[0], rands(2,10,1)[0], rands(20,40,1)[0], rands(0.8,1,1)[0], rands(0,10,1)[0]);
//chair(20, 2.5, 2, 30,1, 3, 3, 0.5, 3, 30, 0.9, 2);