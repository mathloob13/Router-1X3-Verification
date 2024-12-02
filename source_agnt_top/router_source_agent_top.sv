
class router_source_agent_top extends uvm_component;

	`uvm_component_utils(router_source_agent_top)
	
	router_source_agent sagnth;
	
	router_env_config m_env_cfg;
	
	function new (string name = "router_source_agent_top", uvm_component parent);
			super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		
		if(!uvm_config_db #(router_env_config)::get(this," ","router_env_config",m_env_cfg))
			`uvm_fatal("ENV_IF CONFIG","cannot get()interface src_env_if from uvm_config_db. Have you set() it?")		
		
		super.build_phase(phase);
		
		uvm_config_db #(router_source_agent_config)::set(this,"sagnth*","router_source_agent_config",m_env_cfg.msrc_cfg);
		
		sagnth = router_source_agent::type_id::create("sagnth",this);
	endfunction	
endclass
		
