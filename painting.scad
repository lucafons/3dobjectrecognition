module painting(height, width, thickness, frameRatioThickness, frameWidth) {
    difference() {
        cube([width, thickness, height], center=true);
        translate([0, -(-thickness+frameRatioThickness*thickness)/2,0]) cube([width-frameWidth*2, frameRatioThickness*thickness+0.01, height-frameWidth*2], center=true);
    }
}
painting(30, 20, 3, 0.3, 2);