$fn=50;
module curveSquare(radius) {
    minkowski() {
        cube([10, 10, 1],center=true);
        cylinder(h=1,r=radius,center=true);
    }
}
module squareTable(legHeight, legWidth, legRadius, legOffset, tableSizeX, tableRatioY, tableHeight, tableRadius) {
    tableSizeY = tableSizeX*tableRatioY;
    translate([((tableSizeX-legWidth-tableRadius)/2-legOffset), ((tableSizeY-legWidth-tableRadius)/2-legOffset), -(legHeight+tableHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    translate([-((tableSizeX-legWidth-tableRadius)/2-legOffset), ((tableSizeY-legWidth-tableRadius)/2-legOffset), -(legHeight+tableHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    translate([((tableSizeX-legWidth-tableRadius)/2-legOffset), -((tableSizeY-legWidth-tableRadius)/2-legOffset), -(legHeight+tableHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    translate([-((tableSizeX-legWidth-tableRadius)/2-legOffset), -((tableSizeY-legWidth-tableRadius)/2-legOffset), -(legHeight+tableHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    resize([tableSizeX, tableSizeY, tableHeight]) curveSquare(tableRadius);
}
module circularTable(legHeight, legWidth, legRadius, legNum, legOffset, tableRadius, tableHeight) {
    for(i=[0:360/legNum:360]) {
        rotate([0, 0, i]) translate([tableRadius-legWidth/2-legOffset, 0, -(legHeight+tableHeight)/2]) resize([legWidth, legWidth, legHeight]) curveSquare(legRadius);
    }
    cylinder(h=tableHeight, r=tableRadius, center=true);
}
//circularTable(rands(10,30,1)[0], rands(2,7,1)[0], rands(0,20,1)[0], floor(rands(4,10,1)[0]), rands(1,4,1)[0], rands(10,40,1)[0], rands(2,5,1)[0]);
squareTable(rands(10,30,1)[0], rands(2,7,1)[0], rands(0,20,1)[0], floor(rands(1,2,1)[0]), rands(15,40,1)[0], rands(0.5,2,1)[0], rands(0,10,1)[0], rands(2,5,1)[0]);