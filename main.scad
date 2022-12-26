hook_a = 45;
hook_len = 7;

paper_slot_t    = 1;
paper_slot_iw   = 75;
paper_slot_ih   = 24;

main_plate_t    = 1;
main_plate_w    = 144;
main_plate_h    = paper_slot_t + paper_slot_ih + 1;
support_plate_t = main_plate_t;
support_plate_w = paper_slot_iw;
support_plate_h = main_plate_h;


module plate(w,h,t,hook_len){
	plate_half(w/2,h,t,hook_len);
	rotate([0,0,180]) translate([-w,-h,0])
		plate_half(w/2,h,t,hook_len);
}

module plate_half(w,h,t,hook_len){
	cube([w,h,t]);
	translate([0,0,t]) rotate([0,45,0])
		cube([t,h,hook_len]);
}

plate(main_plate_w,main_plate_h,main_plate_t,hook_len);
