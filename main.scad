hook_len = 12;

paper_slot_t      = 1;
paper_slot_iw     = 75;
paper_slot_ih     = 25.5;
paper_slot_id     = 5;
paper_slot_w      = paper_slot_iw+paper_slot_t*2;
paper_slot_hole_w = 6;

main_plate_t    = 2;
main_plate_w    = 144;
main_plate_h    = paper_slot_t + paper_slot_ih + 1;
support_plate_t = main_plate_t;
support_plate_w = paper_slot_iw;
support_plate_h = main_plate_h;


module plate(w,h,t,hook_len,is_inward){
	plate_half(w/2,h,t,hook_len,is_inward);
	rotate([0,0,180]) translate([-w,-h,0])
		plate_half(w/2,h,t,hook_len,is_inward);
}

module plate_half(w,h,t,hook_len,is_inward){
	cube([w,h,t]);
	if(is_inward){
		translate([0,0,t]) rotate([0,45,0]) cube([t,h,hook_len]);
	}else{
		translate([hook_len/sqrt(2),0,0]) rotate([0,-45,0]) cube([t,h,hook_len]);
	}
		
}

module paper_slot(iw,ih,id,t,hole_w){
	difference(){
		cube([iw+t,ih+t*2,id+t]);
                translate([0,t,0]) cube([iw,ih,id]);
                translate([0,t+ih/2-hole_w/2,0]) cube([iw,hole_w,100]);
	}
}

plate(main_plate_w,main_plate_h,main_plate_t,hook_len,false);
translate([0,36,0]) plate(support_plate_w,support_plate_h,support_plate_t,hook_len,true);
translate([main_plate_w/2-paper_slot_w/2,0,main_plate_t-0.01])
	paper_slot(paper_slot_iw,paper_slot_ih,paper_slot_id,paper_slot_t,paper_slot_hole_w);
