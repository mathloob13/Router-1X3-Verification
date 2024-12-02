class router_dest_agent extends uvm_agent;

	`uvm_component_utils(router_dest_agent)
	
	router_dest_agent_config m_dest_agnt_cfg;
	
	router_dest_drv ddrvh;
	router_dest_mon dmonh;
	router_dest_seqr dseqrh;
	
	function new(string name = "router_dest_agent", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(router_dest_agent_config)::get(this," ","router_dest_agent_config",m_dest_agnt_cfg))
				`uvm_fatal(" CONFIG","cannot get()interface uvm_config_db. Have you set() it?")	
			
			dmonh = router_dest_mon::type_id::create("dmonh",this);
			if(m_dest_agnt_cfg.is_active == UVM_ACTIVE)
				begin
					ddrvh = router_dest_drv::type_id::create("ddrvh",this);
					dseqrh = router_dest_seqr::type_id::create("dseqrh",this);
				end
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(m_dest_agnt_cfg.is_active == UVM_ACTIVE)
			begin
				ddrvh.seq_item_port.connect(dseqrh.seq_item_export);
			end
	endfunction
endclass
