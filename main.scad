hook_len = 12;

paper_slot_t      = 1;
paper_slot_iw     = 75;
paper_slot_ih     = 25.5;
paper_slot_id     = 5;
paper_slot_w      = paper_slot_iw+paper_slot_t*2;
paper_slot_hole_w = 6;

main_plate_t           = 2;
main_plate_overhang    = 20;
main_plate_w           = 144+main_plate_overhang;
main_plate_h_max       = paper_slot_t*2 + paper_slot_ih;
main_plate_h_min       = main_plate_h_max/3;
main_plate_cutout_w    = 5;
main_plate_cutout_h    = 3;
main_plate_cutout_wall = 3;
support_plate_t        = main_plate_t;
support_plate_w        = main_plate_w;
support_plate_h        = main_plate_h_max;


module plate(w,h_min,h_max,t,hook_len,is_inward){
	plate_half(w/2,h_min,h_max,t,hook_len,is_inward);
	rotate([0,0,180]) translate([-w,-h_max,0])
		plate_half(w/2,h_min,h_max,t,hook_len,is_inward);
}

module plate_half(w,h_min,h_max,t,hook_len,is_papers){
	difference(){
		cube([w,h_max,t]);

		translate([main_plate_cutout_wall,0,0]){
			cube([main_plate_cutout_w,main_plate_cutout_h,100]);
			translate([main_plate_cutout_wall+main_plate_cutout_w,0,0]) cube([1000,h_min,100]);
		}
		translate([main_plate_cutout_wall,h_max-main_plate_cutout_h,0]){
			cube([main_plate_cutout_w,main_plate_cutout_h,100]);
			translate([main_plate_cutout_wall+main_plate_cutout_w,main_plate_cutout_h-h_min,0]) cube([1000,h_min,100]);
		}
	}
}

module paper_slot(iw,ih,id,t,floor_t,hole_w){
	difference(){
		cube([iw+t,ih+t*2,id+t]);
                translate([0,t,0]) cube([iw,ih,id]);
                translate([0,t+ih/2-hole_w/2,0]) cube([iw,hole_w,100]);
	}
	translate([0,0,-floor_t+0.001]) cube([iw+t,ih+t*2,floor_t]);
}
plate(main_plate_w,main_plate_h_min,main_plate_h_max,main_plate_t,hook_len,false);
translate([0,36,0]) plate(support_plate_w,support_plate_h/3,support_plate_h,support_plate_t,hook_len,true);
translate([main_plate_w/2-paper_slot_w/2,0,main_plate_t-0.01])
	paper_slot(paper_slot_iw,paper_slot_ih,paper_slot_id,paper_slot_t,main_plate_t,paper_slot_hole_w);
