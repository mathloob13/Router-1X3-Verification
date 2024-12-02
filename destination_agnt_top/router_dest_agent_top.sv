class router_dest_agent_top extends uvm_env;

	`uvm_component_utils(router_dest_agent_top)
	
	router_dest_agent dagnth[];
	
	
	router_env_config m_env_cfg;
	
	function new (string name = "router_dest_agent_top", uvm_component parent);
			super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		
		if(!uvm_config_db #(router_env_config)::get(this," ","router_env_config",m_env_cfg))
			`uvm_fatal("ENV_IF CONFIG","cannot get()interface env_if from uvm_config_db. Have you set() it?")		
		
		super.build_phase(phase);
		
		dagnth = new[m_env_cfg.no_of_destination_agent];
		foreach (dagnth[i])
			begin
		uvm_config_db #(router_dest_agent_config)::set(this,$sformatf("dagnth[%0d]*",i),"router_dest_agent_config",m_env_cfg.mdst_cfg[i]);
				
				dagnth[i]=router_dest_agent::type_id::create($sformatf("dagnth[%0d]",i),this);
			end
	endfunction	
endclass
