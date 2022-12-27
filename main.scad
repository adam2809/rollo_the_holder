hook_len = 12;

paper_slot_t      = 1;
paper_slot_iw     = 75;
paper_slot_ih     = 25.5;
paper_slot_id     = 5;
paper_slot_w      = paper_slot_iw+paper_slot_t*2;
paper_slot_hole_w = 6;

main_plate_t           = 2;
main_plate_mount_y     = paper_slot_ih + paper_slot_t*2 + 10;
main_plate_overhang    = 20;
main_plate_w           = 144+main_plate_overhang;
main_plate_h_min       = 9;
main_plate_cutout_w    = 5;
main_plate_cutout_h    = 3;
main_plate_cutout_wall = 3;


module plate_quarter(x,mount_x,y,mid_y,z,slope_x,cut_w,cut_d,cut_wall_t){
	l = [
		[-0.001,-0.001],
		[0,mid_y],
		[slope_x,mid_y],
		[x-mount_x,y],
		[x,y],
		[x,y-cut_wall_t*2],
		[x-cut_d*2,y-cut_wall_t*2],
		[x-cut_d*2,y-cut_wall_t*2-cut_w*2],
		[x,y-cut_wall_t*2-cut_w*2],
		[x,0]
	];
	linear_extrude(z*2){
		polygon(l);
	}
}
module plate_half(x,mount_x,y,mid_y,z,slope_x,cut_w,cut_d,cut_wall_t){
	plate_quarter(x,mount_x,y,mid_y,z,slope_x,cut_w,cut_d,cut_wall_t);
	mirror([0,1,0]) plate_quarter(x,mount_x,y,mid_y,z,slope_x,cut_w,cut_d,cut_wall_t);
}


module plate(x,mount_x,y,mid_y,z,slope_x,cut_w,cut_d,cut_wall_t){
	scale([0.5,0.5,0.5]){
		plate_half(x,mount_x,y,mid_y,z,slope_x,cut_w,cut_d,cut_wall_t);
		mirror([1,0,0]) plate_half(x,mount_x,y,mid_y,z,slope_x,cut_w,cut_d,cut_wall_t);
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
//plate(main_plate_w,main_plate_h_min,main_plate_mount_y,main_plate_t,hook_len,false);
//translate([0,36,0]) plate(support_plate_w,support_plate_h/3,support_plate_h,support_plate_t,hook_len,true);
translate([-(paper_slot_iw+paper_slot_t)/2,-(paper_slot_ih+paper_slot_t*2)/2,main_plate_t-0.01])
	paper_slot(paper_slot_iw,paper_slot_ih,paper_slot_id,paper_slot_t,main_plate_t,paper_slot_hole_w);
plate(144,11,paper_slot_ih+paper_slot_t*2+25,9,2,90,6,5,5);
