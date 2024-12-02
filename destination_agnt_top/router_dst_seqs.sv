class router_dst_base_seqs extends uvm_sequence#(router_dst_xtn);
	`uvm_object_utils(router_dst_base_seqs)
	
	function new(string name = "router_dst_base_seqs");
		super.new(name);
	endfunction
endclass

class router_dst_delay_1 extends router_dst_base_seqs;

	`uvm_object_utils(router_dst_delay_1)
	
	function new(string name = "router_dst_delay_1");
		super.new(name);
	endfunction
	
	task body();
		begin
			req=router_dst_xtn::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {delay < 29;});
			finish_item(req);
		end
	endtask
endclass

class router_dst_delay_2 extends router_dst_base_seqs;

	`uvm_object_utils(router_dst_delay_2)
	
	function new(string name = "router_dst_delay_2");
		super.new(name);
	endfunction
	
	task body();
	//	super.body();
		begin
			req=router_dst_xtn::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {delay > 29;});
			finish_item(req);
		end
	endtask
endclass

