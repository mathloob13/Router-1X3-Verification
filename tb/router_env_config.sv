class router_env_config extends uvm_object;
	`uvm_object_utils(router_env_config)
	
	bit has_src_agent;
	bit has_dst_agent;
	bit has_scoreboard;
	bit no_of_source_agent = 1;
	int no_of_destination_agent = 3;
	bit has_virtual_sequencer = 1;
	router_source_agent_config msrc_cfg;
	router_dest_agent_config mdst_cfg[];
	
	function new(string name = "router_env_config");
		super.new(name);
	endfunction
		
endclass

