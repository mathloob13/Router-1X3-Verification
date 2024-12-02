class router_virtual_base_seqs extends uvm_sequence#(uvm_sequence_item);
	`uvm_object_utils(router_virtual_base_seqs)

	router_virtual_seqr v_seqrh;

	router_src_seqr m_src_seqrh;
	router_dest_seqr m_dst_seqrh[];

	router_src_small_pkt ssph;
	router_src_medium_pkt smph;
	router_src_large_pkt slph;
	
	router_dst_delay_1 dd1h;
	router_dst_delay_2 dd2h;
	
	

	router_env_config m_env_cfgh;
	
	//bit [1:0]addr;
	
	function new(string name = "router_virtual_base_seqs");
		super.new(name);
	endfunction
	
	task body();
		if(!uvm_config_db #(router_env_config)::get(null,get_full_name(),"router_env_config",m_env_cfgh))
			`uvm_fatal("config","config not getting have you set are not ?...")

		//router_src_seqr=new[m_env_cfgh.no_of_source_agent];
		m_dst_seqrh = new[m_env_cfgh.no_of_destination_agent];

		 if(!$cast(v_seqrh,m_sequencer))
			begin
			`uvm_error(get_full_name(),"casting filed");
		 	end
		
		m_src_seqrh = v_seqrh.ms_src_seqrh;
		foreach(m_dst_seqrh[i])
			begin
			m_dst_seqrh[i]=v_seqrh.md_dst_seqrh[i];
			end
	endtask
endclass
/*-------------------------------------------------------------------
					small packet sequence
---------------------------------------------------------------------*/
class router_small_vseqs extends router_virtual_base_seqs;
	`uvm_object_utils(router_small_vseqs)
	bit [1:0] addr;
	function new(string name = "router_small_vseqs");
		super.new(name);
	endfunction

	task body();
		super.body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("config","get failed")

		ssph = router_src_small_pkt::type_id::create("ssph");
		dd1h = router_dst_delay_1::type_id::create("dd1h");
	fork
		if(m_env_cfgh.has_src_agent)
			begin
			ssph.start(m_src_seqrh);
			end
		if(m_env_cfgh.has_dst_agent)
			begin
			dd1h.start(m_dst_seqrh[addr]);
			end
	join
	endtask
endclass
/*-------------------------------------------------------------------
					small packet soft reset sequence
---------------------------------------------------------------------*/
class router_small_sr_vseqs extends router_virtual_base_seqs;
	`uvm_object_utils(router_small_sr_vseqs)
bit [1:0] addr;

	function new(string name = "router_small_sr_vseqs");
		super.new(name);
	endfunction

	task body();
		super.body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("config","get failed")

		ssph = router_src_small_pkt::type_id::create("ssph");
		dd2h = router_dst_delay_2::type_id::create("dd2h");
	fork
		if(m_env_cfgh.has_src_agent)
			begin
			ssph.start(m_src_seqrh);
			end
		if(m_env_cfgh.has_dst_agent)
			begin
			dd2h.start(m_dst_seqrh[addr]);
			end
	join
	endtask
endclass
/*-------------------------------------------------------------------
					medium packet sequence
---------------------------------------------------------------------*/
class router_medium_vseqs extends router_virtual_base_seqs;
	`uvm_object_utils(router_medium_vseqs)
	bit [1:0] addr;

	function new(string name = "router_medium_vseqs");
		super.new(name);
	endfunction

	task body();
		super.body();
	
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("config","get failed")

		smph = router_src_medium_pkt::type_id::create("smph");
		dd1h = router_dst_delay_1::type_id::create("dd1h");
	fork
		if(m_env_cfgh.has_src_agent)
			begin
			smph.start(m_src_seqrh);
			end
		if(m_env_cfgh.has_dst_agent)
			begin
			dd1h.start(m_dst_seqrh[addr]);
			end
	join
	endtask
endclass
/*-------------------------------------------------------------------
					medium packet soft reset sequence
---------------------------------------------------------------------*/
class router_medium_sr_vseqs extends router_virtual_base_seqs;
	`uvm_object_utils(router_medium_sr_vseqs)
bit [1:0] addr;

	function new(string name = "router_medium_sr_vseqs");
		super.new(name);
	endfunction

	task body();
		super.body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("config","get failed")

		smph = router_src_medium_pkt::type_id::create("smph");
		dd2h = router_dst_delay_2::type_id::create("dd1h");
	fork
		if(m_env_cfgh.has_src_agent)
			begin
			smph.start(m_src_seqrh);
			end
		if(m_env_cfgh.has_dst_agent)
			begin
			dd2h.start(m_dst_seqrh[addr]);
			end
	join
	endtask
endclass
/*-------------------------------------------------------------------
					large packet sequence
---------------------------------------------------------------------*/
class router_large_vseqs extends router_virtual_base_seqs;
	`uvm_object_utils(router_large_vseqs)
bit [1:0] addr;

	function new(string name = "router_large_vseqs");
		super.new(name);
	endfunction

	task body();
		super.body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("config","get failed")

		slph = router_src_large_pkt::type_id::create("slph");
		dd1h = router_dst_delay_1::type_id::create("dd1h");
	fork
		if(m_env_cfgh.has_src_agent)
			begin
			slph.start(m_src_seqrh);
			end
		if(m_env_cfgh.has_dst_agent)
			begin
			dd1h.start(m_dst_seqrh[addr]);
			end
	join	
	endtask
endclass
/*-------------------------------------------------------------------
					large packet soft reset sequence
---------------------------------------------------------------------*/
class router_large_sr_vseqs extends router_virtual_base_seqs;
	`uvm_object_utils(router_large_sr_vseqs)
bit [1:0] addr;

	function new(string name = "router_large_sr_vseqs");
		super.new(name);
	endfunction

	task body();
		super.body();
		if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
			`uvm_fatal("config","get failed")

		slph = router_src_large_pkt::type_id::create("slph");
		dd2h = router_dst_delay_2::type_id::create("dd1h");
	fork
		if(m_env_cfgh.has_src_agent)
			begin
			slph.start(m_src_seqrh);
			end
		if(m_env_cfgh.has_dst_agent)
			begin
			dd2h.start(m_dst_seqrh[addr]);
			end
	join
	endtask
endclass




		

		
	

			


	
