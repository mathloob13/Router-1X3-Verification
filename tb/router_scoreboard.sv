class router_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(router_scoreboard)
	
	router_src_xtn s_xtnh;
	router_dst_xtn d_xtnh;
	
	uvm_tlm_analysis_fifo#(router_src_xtn) src_fifoh;
	uvm_tlm_analysis_fifo#(router_dst_xtn) dst_fifoh[];
	
	router_env_config m_env_cfgh;
	
	bit[1:0] addr;
	
	covergroup cg1;

		option.per_instance = 1;
		
		ADDR: coverpoint s_xtnh.header[1:0]{bins addr_0 = {1};
			                        	bins addr_1 = {1};
							bins addr_2 = {1};}
		
		PAYLOAD_LENGTH: coverpoint s_xtnh.header[7:2]{bins small_pkt = {[1:20]};
								bins medium_pkt = {[21:40]};
								 bins large_pkt = {[41:63]};
								  }
													  
		ERROR: coverpoint s_xtnh.error {bins err1 = {0};}
		
	       

	endgroup
	
	covergroup cg2;

		option.per_instance = 1;
		ADDR: coverpoint d_xtnh.header[1:0]{bins addr_0 = {1};
							bins addr_1 = {1};
							bins addr_2 = {1};}
		
		PAYLOAD_LENGTH: coverpoint d_xtnh.header[7:2]{bins small_pkt = {[1:20]};
								  bins medium_pkt = {[21:40]};
								  bins large_pkt = {[41:63]};
									  }
												  
	endgroup

	
	function new(string name = "router_scoreboard", uvm_component parent);
		super.new(name,parent);
		cg1=new;
		cg2=new;
		
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			if(!uvm_config_db #(router_env_config)::get(this," ","router_env_config",m_env_cfgh))
				`uvm_fatal("Config","getting failed")
				//alllocation of memory.
				//src_fifoh=new[m_env_cfgh.no_of_source_agent];
				dst_fifoh=new[m_env_cfgh.no_of_destination_agent];
				//create a memory
				src_fifoh=new("src_fifoh",this);
				foreach(dst_fifoh[i])
					begin
						dst_fifoh[i]=new($sformatf("dst_fifoh[%0d]",i),this);
					end
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			forever 
				begin	
					fork
						begin
							src_fifoh.get(s_xtnh);
							//s_xtnh.print();
							`uvm_info("Score board connected to src",s_xtnh.sprint(),UVM_LOW)
							cg1.sample();
							
						end
						begin
							if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
									`uvm_fatal("config","get failed")
							dst_fifoh[addr].get(d_xtnh);
							//d_xtnh.print();
							`uvm_info("Score board connected to dst",d_xtnh.sprint(),UVM_LOW)
							cg2.sample();

						end
					join
				end
	compare(s_xtnh,d_xtnh);
	
	endtask
	
	task compare (router_src_xtn s_xtn, router_dst_xtn d_xtn);
		
		if(s_xtn.header == d_xtn.header)
			$display("Header compared successfully");
		else
			$display("Header compared unsuccessfully");
			
		if(s_xtn.payload == d_xtn.payload)
			$display("payload compared successfully");
		else
			$display("payload compared unsuccessfully");
			
				
		if(s_xtn.parity == d_xtn.parity)
			$display("parity compared successfully");
		else
			$display("parity compared unsuccessfully");
	endtask
	
endclass
					
				
