class router_virtual_seqr extends uvm_sequencer #(uvm_sequence_item);
	`uvm_component_utils(router_virtual_seqr)

	router_src_seqr ms_src_seqrh;
	router_dest_seqr md_dst_seqrh[];

	
	router_env_config m_env_cfgh;
	
	function new(string name = "router_virtual_seqr", uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		
		if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_env_cfgh))
			`uvm_fatal("config","getting failed")
		
		//router_src_seqr=new[m_env_cfg.no_sourrce_agnet];
		md_dst_seqrh = new[m_env_cfgh.no_of_destination_agent];
	endfunction
endclass

