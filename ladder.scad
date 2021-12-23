$fn=100;
module ladder(height, width, rungSpacing, rungWidth, rungOffset) {
    translate([(-width/2+rungWidth), 0, 0]) cylinder(h=height,r=rungWidth,center=true);
    translate([-(-width/2+rungWidth), 0, 0]) cylinder(h=height,r=rungWidth,center=true);
    for(i=[0:(height-rungOffset*2)/rungSpacing:(height-rungOffset*2)]) {
        translate([0, 0, -(height+rungWidth)/2+rungOffset+i]) rotate([0, 90, 0]) cylinder(h=width-rungWidth*2, r=rungWidth, center=true);
    }
}
ladder(50, 13, 8, 1, 3);