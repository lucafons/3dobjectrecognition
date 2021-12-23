$fn=100;
module curveSquare(radius) {
    minkowski() {
        cube([10, 10, 1],center=true);
        cylinder(h=1,r=radius,center=true);
    }
}
module pillow() {
    minkowski() {
        cube([10, 6, 2], center=true);
        scale([1,1,0.5]) sphere(r=2);
    }
}
module bed(legHeight, legWidth, legRadius, legOffset, bedSizeX, bedRatioY, bedHeight, bedRadius, sheetRatioLen, sheetRatioHeight) {
    bedSizeY = bedSizeX*bedRatioY;
    translate([((bedSizeX-legWidth-bedRadius)/2-legOffset), ((bedSizeY-legWidth-bedRadius)/2-legOffset), -(legHeight+bedHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    translate([-((bedSizeX-legWidth-bedRadius)/2-legOffset), ((bedSizeY-legWidth-bedRadius)/2-legOffset), -(legHeight+bedHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    translate([((bedSizeX-legWidth-bedRadius)/2-legOffset), -((bedSizeY-legWidth-bedRadius)/2-legOffset), -(legHeight+bedHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    translate([-((bedSizeX-legWidth-bedRadius)/2-legOffset), -((bedSizeY-legWidth-bedRadius)/2-legOffset), -(legHeight+bedHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    resize([bedSizeX, bedSizeY, bedHeight]) curveSquare(bedRadius);
}
//pillow();
bed(3, 2, 2, 1, 30, 0.8, 5, 1);
