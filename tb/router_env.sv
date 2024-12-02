class router_env extends uvm_env;

	`uvm_component_utils(router_env)
	
	router_source_agent_top s_agt_toph;
	router_dest_agent_top d_agt_toph;
	router_scoreboard scbh;
	router_virtual_seqr ve_seqrh;
	router_env_config m_env_cfg;
	
	function new(string name = "router_env", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		
		if(!uvm_config_db #(router_env_config)::get(this," ","router_env_config",m_env_cfg))
			`uvm_fatal("CONFIG","cannot get()interface src_if from uvm_config_db. Have you set() it?") 
		
			if(m_env_cfg.has_src_agent)
					s_agt_toph = router_source_agent_top::type_id::create("s_agt_toph", this);
			if(m_env_cfg.has_dst_agent)
					d_agt_toph = router_dest_agent_top::type_id::create("d_agt_toph",this);
			if(m_env_cfg.has_virtual_sequencer)
					ve_seqrh=router_virtual_seqr::type_id::create("ve_seqrh",this);
			if(m_env_cfg.has_scoreboard)
					scbh = router_scoreboard::type_id::create("scbh",this);		
		super.build_phase(phase);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		if(m_env_cfg.has_src_agent)
			begin
			ve_seqrh.ms_src_seqrh=s_agt_toph.sagnth.sseqrh;
			end
		if(m_env_cfg.has_dst_agent)
			foreach(m_env_cfg.mdst_cfg[i])
				begin
				ve_seqrh.md_dst_seqrh[i]=d_agt_toph.dagnth[i].dseqrh;
				end
		if(m_env_cfg.has_scoreboard)
			begin
				s_agt_toph.sagnth.smonh.src_mon_ap.connect(scbh.src_fifoh.analysis_export);
			end
			begin
				foreach(m_env_cfg.mdst_cfg[i])
					d_agt_toph.dagnth[i].dmonh.dst_mon_ap.connect(scbh.dst_fifoh[i].analysis_export);
			end
	endfunction
			
endclass
