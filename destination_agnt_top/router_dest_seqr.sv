class router_dest_seqr extends uvm_sequencer#(router_dst_xtn);

	`uvm_component_utils(router_dest_seqr)
	
	function new(string name = "router_dest_seqr", uvm_component parent);
		super.new(name,parent);
	endfunction
endclass