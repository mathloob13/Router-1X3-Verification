class router_source_agent_config extends uvm_object;
	
	`uvm_object_utils(router_source_agent_config)
	
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	
	virtual src_if src_inf;
	
	function new(string name = "router_source_agent_config");
		super.new(name);
	endfunction
endclass
