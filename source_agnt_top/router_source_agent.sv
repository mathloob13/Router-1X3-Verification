class router_source_agent extends uvm_agent;
	`uvm_component_utils(router_source_agent)
	
	router_source_agent_config m_src_agnt_cfg;
	
	router_src_drv sdrvh;
	router_src_mon smonh;
	router_src_seqr sseqrh;
	
	function new (string name = "router_source_agent", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(router_source_agent_config)::get(this," ","router_source_agent_config",m_src_agnt_cfg))
			`uvm_fatal("SRC_AGNT CONFIG","cannot get()interface agt_cfg from uvm_config_db. Have you set() it?")
			
			smonh = router_src_mon::type_id::create("router_src_mon",this);
			if(m_src_agnt_cfg.is_active == UVM_ACTIVE)
				begin
					sdrvh = router_src_drv::type_id::create("sdrvh",this);
					sseqrh = router_src_seqr::type_id::create("sseqrh",this);
				end
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
			if(m_src_agnt_cfg.is_active == UVM_ACTIVE)
				begin	
					sdrvh.seq_item_port.connect(sseqrh.seq_item_export);
				end
	endfunction
endclass