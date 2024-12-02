class router_src_drv extends uvm_driver#(router_src_xtn);
	
	`uvm_component_utils(router_src_drv)
	
	router_source_agent_config m_src_agnt_cfg;
	
	virtual src_if.SRC_DRV src_inf;
	
	function new(string name = "router_src_drv", uvm_component parent = null);
		super.new(name,parent);
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
	
task rst();
@(src_inf.src_drv_cb);
			src_inf.src_drv_cb.resetn <= 1'b0;
		@(src_inf.src_drv_cb);
			src_inf.src_drv_cb.resetn <= 1'b1;


endtask
	task run_phase(uvm_phase phase);
		
	rst();			
		forever 
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask
	
	task send_to_dut(router_src_xtn xtnh);
		
		
		
		//check wether busy is low or not
		while(src_inf.src_drv_cb.busy == 1'b1)
			@(src_inf.src_drv_cb);
		
		src_inf.src_drv_cb.pkt_valid <= 1'b1;
		
		src_inf.src_drv_cb.data_in <= xtnh.header;
			@(src_inf.src_drv_cb);
			
		foreach(xtnh.payload[i])
			begin
				while(src_inf.src_drv_cb.busy == 1'b1)
					@(src_inf.src_drv_cb);
				src_inf.src_drv_cb.data_in <= xtnh.payload[i];
					@(src_inf.src_drv_cb);
			end
		
		while(src_inf.src_drv_cb.busy == 1'b1)
			@(src_inf.src_drv_cb);
			
		src_inf.src_drv_cb.pkt_valid <= 1'b0;
		
		
		src_inf.src_drv_cb.data_in <= xtnh.parity;
		
		@(src_inf.src_drv_cb);
		`uvm_info("ROUTER_SOURCE_DRIVER",$sformatf("printing from driver \n %s",xtnh.sprint()),UVM_LOW)
		
		
	endtask
	
endclass
			
	


