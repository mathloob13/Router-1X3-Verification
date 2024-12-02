class router_base_test extends uvm_test;

// facotory registration
	`uvm_component_utils(router_base_test)
	
	router_env envh;
	
	//declare handles for source_config,destination_sconfig,env_config.
	router_source_agent_config m_src_cfg;
	router_dest_agent_config m_dest_cfg[];
	router_env_config m_env_cfg;
	
	bit has_src_agent = 1;
	bit has_dst_agent = 1;
	bit has_scoreboard = 1;
	bit no_of_source_agent = 1;
	int no_of_destination_agent = 3;
	bit has_virtual_sequencer = 1;
	function new(string name = "router_base_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
	
		m_env_cfg=router_env_config::type_id::create("m_env_cfg",this);
		
		
		if(has_src_agent)
			begin
				m_src_cfg=router_source_agent_config::type_id::create("m_src_cfg",this);
				
				if(!uvm_config_db #(virtual src_if)::get(this," ","src_inf",m_src_cfg.src_inf))
					`uvm_fatal("CONFIG","cannot get()interface src_if from uvm_config_db. Have you set() it?") 
					
				m_src_cfg.is_active = UVM_ACTIVE;
				//assign env handle to src handle.
				m_env_cfg.msrc_cfg = m_src_cfg;
			end
	
		if(has_dst_agent)
			begin
				//assign dynamic array size for dest_config;
				m_dest_cfg = new[no_of_destination_agent];
				m_env_cfg.mdst_cfg = new[no_of_destination_agent];
				
				foreach (m_dest_cfg[i])
					begin
					m_dest_cfg[i]=router_dest_agent_config::type_id::create($sformatf("m_dst_cfg[%0d]",i));
			
				        if(!uvm_config_db #(virtual dst_if)::get(this," ",$sformatf("dst_inf_%0d",i),m_dest_cfg[i].dst_inf))
					  `uvm_fatal("DST_IF CONFIG","cannot get()interface DST_if from uvm_config_db. Have you set() it?") 
							
						m_dest_cfg[i].is_active = UVM_ACTIVE;
						//assigning dest config to env dest config.
						m_env_cfg.mdst_cfg[i] = m_dest_cfg[i];
					end
			end
		// all test paramenters are assigned to env config	
		m_env_cfg.has_src_agent = has_src_agent;
		m_env_cfg.has_dst_agent = has_dst_agent;
		m_env_cfg.no_of_source_agent = no_of_source_agent;
		m_env_cfg.no_of_destination_agent = no_of_destination_agent;
		m_env_cfg.has_virtual_sequencer = has_virtual_sequencer;
		m_env_cfg.has_scoreboard = has_scoreboard;
		//env cfg is set for src_agt_top and dst_agt_top
		uvm_config_db #(router_env_config)::set(this,"*","router_env_config",m_env_cfg);
		super.build_phase(phase);
		envh=router_env::type_id::create("envh",this);
	endfunction
	
	

	function void end_of_elaboration_phase (uvm_phase phase);
		uvm_top.print_topology();
		super.end_of_elaboration_phase(phase);
	endfunction 	
endclass
	
	
//------------------router_small_packet-----------------//
class router_small_pkt_test1 extends router_base_test;

      `uvm_component_utils(router_small_pkt_test1)
      
		bit [1:0] addr;	
		router_small_vseqs  test1_seqh;
		
		function new(string name = "router_small_pkt_test1", uvm_component parent);
			super.new(name,parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			addr = {$urandom}%3;
			
			
			uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
			
			test1_seqh = router_small_vseqs::type_id::create("test1_seqh");
			phase.raise_objection(this);
			fork	
				begin	
					test1_seqh.start(envh.ve_seqrh);
				end
			join

			envh.s_agt_toph.sagnth.sdrvh.rst();

			#60;
			phase.drop_objection(this);
		endtask
		
endclass


//----------------------test 2 using v_seqr--------------------//
class router_small_pkt_test2 extends router_base_test;

      `uvm_component_utils(router_small_pkt_test2)
      
		bit [1:0] addr;
	router_small_sr_vseqs test2_seqh;
		
		function new(string name = "router_small_pkt_test2", uvm_component parent);
			super.new(name,parent);
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			addr = {$urandom}%3;
						
			uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

			test2_seqh = router_small_sr_vseqs::type_id::create("test2_seqh");
			phase.raise_objection(this);
			fork	
				begin	
					test2_seqh.start(envh.ve_seqrh);
				end
			join
			envh.s_agt_toph.sagnth.sdrvh.rst();
			#50;
			phase.drop_objection(this);
		endtask
		
endclass

class router_medium_pkt_test1 extends router_base_test;

      `uvm_component_utils(router_medium_pkt_test1)
      
		bit [1:0] addr;
		router_medium_vseqs  test3_seqh;
		
		function new(string name = "router_medium_pkt_test1", uvm_component parent);
			super.new(name,parent);
		endfunction
		
		task run_phase(uvm_phase phase);

			addr = {$urandom}%3;			
			uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

			test3_seqh = router_medium_vseqs::type_id::create("test3_seqh");
			phase.raise_objection(this);
			fork	
				begin	
					test3_seqh.start(envh.ve_seqrh);
				end
			join
			envh.s_agt_toph.sagnth.sdrvh.rst();
			#50;
			phase.drop_objection(this);
		endtask
		
endclass

class router_medium_pkt_test2 extends router_base_test;

      `uvm_component_utils(router_medium_pkt_test2)
      
		bit [1:0] addr;

	router_medium_sr_vseqs test4_seqh;
		
		function new(string name = "router_medium_pkt_test2", uvm_component parent);
			super.new(name,parent);
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			
			addr = {$urandom}%3;			
			uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);


			test4_seqh = router_medium_sr_vseqs::type_id::create("test4_seqh");
			phase.raise_objection(this);
			fork	
				begin	
					test4_seqh.start(envh.ve_seqrh);
				end
			join
			envh.s_agt_toph.sagnth.sdrvh.rst();
			#100;
			phase.drop_objection(this);
		endtask
		
endclass

class router_large_pkt_test1 extends router_base_test;

      `uvm_component_utils(router_large_pkt_test1)
      
		bit [1:0] addr;
		router_large_vseqs test5_seqh;
		
		function new(string name = "router_large_pkt_test1", uvm_component parent);
			super.new(name,parent);
		endfunction
		
		task run_phase(uvm_phase phase);
		//	super.run_phase(phase);
			
			addr = {$urandom}%3;			
			uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);


			test5_seqh = router_large_vseqs::type_id::create("test5_seqh");
			phase.raise_objection(this);
			fork	
				begin	
					test5_seqh.start(envh.ve_seqrh);
				end
			join
			envh.s_agt_toph.sagnth.sdrvh.rst();
		//	#60;
			phase.drop_objection(this);
		endtask
		
endclass

class router_large_pkt_test2 extends router_base_test;

      `uvm_component_utils(router_large_pkt_test2)
        bit[1:0] addr; 

		router_large_sr_vseqs test6_seqh;
		
		function new(string name = "router_large_pkt_test2", uvm_component parent);
			super.new(name,parent);
		endfunction
		
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
		      	addr = {$urandom}%3;			
			uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

			test6_seqh = router_large_sr_vseqs::type_id::create("test6_seqh");
			phase.raise_objection(this);
			fork	
				begin	
					test6_seqh.start(envh.ve_seqrh);
				end
			join
			envh.s_agt_toph.sagnth.sdrvh.rst();
			#100;
			phase.drop_objection(this);
		endtask
		
endclass





