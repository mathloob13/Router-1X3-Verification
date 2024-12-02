class router_src_mon extends uvm_monitor;

	`uvm_component_utils(router_src_mon)
	
	uvm_analysis_port#(router_src_xtn) src_mon_ap;
	
	router_source_agent_config m_src_agnt_cfg;
	
	virtual src_if.SRC_MON src_inf;
	
	function new(string name = "router_src_mon", uvm_component parent);
		super.new(name,parent);
		src_mon_ap=new("src_mon_ap",this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(router_source_agent_config)::get(this,"","router_source_agent_config",m_src_agnt_cfg))
			`uvm_fatal("CONFIG", "cannot get()interface src_if from uvm_config_db. Have you set() it?")
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		src_inf=m_src_agnt_cfg.src_inf;
	endfunction
	
	task run_phase(uvm_phase phase);
		
		forever
				collect_data();
	endtask
	
	task collect_data;

			router_src_xtn xtnm;
			xtnm = router_src_xtn::type_id::create("xtnm",this);
			
			while(src_inf.src_mon_cb.busy==1'b1 || src_inf.src_mon_cb.pkt_valid==1'b0)
				@(src_inf.src_mon_cb);
		//	@(src_inf.src_mon_cb); 

			// get the header from data_in.	
			xtnm.header = src_inf.src_mon_cb.data_in;
			// get the payload from data_in.
			xtnm.payload = new[xtnm.header[7:2]];
				@(src_inf.src_mon_cb);
			foreach(xtnm.payload[i])
				begin
				while(src_inf.src_mon_cb.busy==1'b1)
					@(src_inf.src_mon_cb); 
				while(src_inf.src_mon_cb.pkt_valid==1'b0)
				@(src_inf.src_mon_cb);


					xtnm.payload[i] = src_inf.src_mon_cb.data_in;
					@(src_inf.src_mon_cb); 
	 
				end

				while(src_inf.src_mon_cb.busy==1'b1 || src_inf.src_mon_cb.pkt_valid==1'b1)
					@(src_inf.src_mon_cb);   
						

					
				xtnm.parity = src_inf.src_mon_cb.data_in;
				

				repeat(2)
					@(src_inf.src_mon_cb); 
					xtnm.error = src_inf.src_mon_cb.error;
				//	@(src_inf.src_mon_cb);
				

					src_mon_ap.write(xtnm);

					@(src_inf.src_mon_cb);
	
	`uvm_info("ROUTER_SOURCE_MONITOR",$sformatf("printing from monitor \n %s",xtnm.sprint()),UVM_LOW)
		

	endtask

endclass

	
					 
								
		
	
	
	
	
	
	
	
	


