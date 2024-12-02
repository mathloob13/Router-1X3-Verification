class router_dest_drv extends uvm_driver#(router_dst_xtn);

	`uvm_component_utils(router_dest_drv)
	
	virtual dst_if.DST_DRV dst_inf;
	
	router_dest_agent_config m_dest_agnt_cfg;
	
	function new(string name = "router_dest_drv", uvm_component parent);
			super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);
		
		if(!uvm_config_db #(router_dest_agent_config)::get(this," ","router_dest_agent_config",m_dest_agnt_cfg))
			`uvm_fatal( "CONFIG","cannot get()interface uvm_config_db. Have you set() it?")	
	endfunction
	
	function void connect_phase(uvm_phase phase);
	//	super.connect_phase(phase);
			dst_inf=m_dest_agnt_cfg.dst_inf;
	endfunction 	
	
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		
		forever 
			begin
				seq_item_port.get_next_item(req);
	 			send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask
	
	task send_to_dut(router_dst_xtn xtnd);
	
		while(dst_inf.dst_drv_cb.valid_out == 1'b0)
			@(dst_inf.dst_drv_cb);
		
		repeat(xtnd.delay)
			@(dst_inf.dst_drv_cb);

			dst_inf.dst_drv_cb.read_enb <= 1'b1;
			
			while(dst_inf.dst_drv_cb.valid_out == 1'b1)
				@(dst_inf.dst_drv_cb);
			
			@(dst_inf.dst_drv_cb);
			dst_inf.dst_drv_cb.read_enb <= 1'b0;
			`uvm_info("ROUTER_DESTINATION_DRIVER",$sformatf("printing from driver \n %s",xtnd.sprint()),UVM_LOW)
	
	endtask
	
endclass

	
	
	
	
