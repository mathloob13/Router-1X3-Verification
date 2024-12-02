class router_src_seqr extends uvm_sequencer#(router_src_xtn);

	`uvm_component_utils(router_src_seqr)
		
	function new(string name = "router_src_seqr", uvm_component parent);
		super.new(name,parent);
	endfunction
endclass
