class router_src_base_seqs extends uvm_sequence#(router_src_xtn);
	`uvm_object_utils(router_src_base_seqs)
	
	function new(string name = "router_src_base_seqs");
		super.new(name);
	endfunction
	
endclass
	
class router_src_small_pkt extends router_src_base_seqs;
	bit [1:0] addr;
	`uvm_object_utils(router_src_small_pkt)
	
	function new(string name = "router_src_base_seqs");
		super.new(name);
	endfunction
	
	task body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal( "addr","cannot get() addr uvm_config_db. Have you set() it?")
//	repeat(5)

$display("---------------------------------%d",addr);
		begin
		req=router_src_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[1:20]}; header[1:0]==addr;});
		finish_item(req);
		end
	endtask
endclass
	
class router_src_medium_pkt extends router_src_base_seqs;

	`uvm_object_utils(router_src_medium_pkt)
	bit [1:0] addr;
	function new(string name = "router_src_medium_pkt");
		super.new(name);
	endfunction
	
	task body();
	//	super.body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal( "addr","cannot get() addr uvm_config_db. Have you set() it?")

		begin
		req=router_src_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[21:40]}; header[1:0]==addr;});
		finish_item(req);
		end
	endtask
endclass

class router_src_large_pkt extends router_src_base_seqs;

	`uvm_object_utils(router_src_large_pkt)
	bit [1:0] addr;
	function new(string name = "router_src_large_pkt");
		super.new(name);
	endfunction
	
	task body();
	//	super.body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal( "addr","cannot get() addr uvm_config_db. Have you set() it?")

		begin
		req=router_src_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[41:63]}; header[1:0]==addr;});
	
	finish_item(req);
		end
	endtask
endclass
	
