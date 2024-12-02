class router_dest_mon extends uvm_monitor;

	`uvm_component_utils(router_dest_mon)
	
	virtual dst_if.DST_MON dst_inf;
	
	router_dest_agent_config m_dest_agnt_cfg;
	
	uvm_analysis_port#(router_dst_xtn) dst_mon_ap;
	
	function new(string name = "router_dest_mon", uvm_component parent);
			super.new(name,parent);
			dst_mon_ap=new("dst_mon_ap",this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);
		
		if(!uvm_config_db #(router_dest_agent_config)::get(this," ","router_dest_agent_config",m_dest_agnt_cfg))
			`uvm_fatal( "CONFIG","cannot get()interface uvm_config_db. Have you set() it?")	
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		dst_inf=m_dest_agnt_cfg.dst_inf;
	endfunction
	
	task run_phase(uvm_phase phase);
		forever
			collect_data();
	endtask: run_phase
	
	task collect_data;
		router_dst_xtn xtnm;
		xtnm=router_dst_xtn::type_id::create("xtnm");
	
	//	@(dst_inf.dst_mon_cb);
		while(dst_inf.dst_mon_cb.read_enb == 0)		
		@(dst_inf.dst_mon_cb);

		@(dst_inf.dst_mon_cb);


		xtnm.header = dst_inf.dst_mon_cb.data_out;
	
			//@(dst_inf.dst_mon_cb);

		xtnm.payload = new[xtnm.header[7:2]];
		@(dst_inf.dst_mon_cb);
			
		foreach(xtnm.payload[i])
			begin
				while(dst_inf.dst_mon_cb.read_enb == 0)
			       @(dst_inf.dst_mon_cb);
				
				//@(dst_inf.dst_mon_cb);
				xtnm.payload[i]=dst_inf.dst_mon_cb.data_out;
				
				@(dst_inf.dst_mon_cb);

			end
			
		while(dst_inf.dst_mon_cb.read_enb == 0)
			@(dst_inf.dst_mon_cb);
			
		       xtnm.parity=dst_inf.dst_mon_cb.data_out;
			@(dst_inf.dst_mon_cb);
	 	
		`uvm_info("ROUTER_DESTINATION_MONITOR",$sformatf("printing from monitor \n %s",xtnm.sprint()),UVM_LOW)
		
	     		dst_mon_ap.write(xtnm);
	endtask
	
endclass
