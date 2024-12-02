class router_src_xtn extends uvm_sequence_item;

	`uvm_object_utils(router_src_xtn)
	
	rand bit [7:0] header;
	rand bit [7:0] payload[]; // payload size3 is 1 to 63.
	bit [7:0] parity;
	bit pkt_valid;
	bit error,busy,resetn;
	
	constraint address{header[1:0] != 2'b11;
			   payload.size==header[7:2];
			   header[7:2] != 0;} 
	extern function new(string name = "router_src_xtn");
	extern function void do_copy(uvm_object rhs);
	extern function void do_print(uvm_printer printer);
	extern function void post_randomize();
endclass

	function router_src_xtn::new(string name = "router_src_xtn");
		super.new(name);
	endfunction
	
	function void router_src_xtn::do_copy(uvm_object rhs);
		router_src_xtn rhs_;
		
		if(!$cast(rhs_,rhs))
			begin
			`uvm_fatal("do_copy","cast of the rsrcxtn object failed")
			end
			
			super.do_copy(rhs);
			
			header=rhs_.header;
			payload=new[header[7:2]];
			foreach(payload[i])
				payload[i]=rhs_.payload[i];
			pkt_valid=rhs_.pkt_valid;
			parity=rhs_.parity;
			error=rhs_.error;
			busy=rhs_.busy;
			resetn=rhs_.resetn;
	endfunction
	
	

	function void router_src_xtn::do_print(uvm_printer printer);
		super.do_print(printer);
		
		    printer.print_field( "header", 			this.header, 	    	8,		 UVM_DEC		);
			foreach(payload[i])
				printer.print_field( $sformatf("payload[%0d]",i), 		this.payload[i], 	   8,		 UVM_DEC		);
			printer.print_field( "parity", 			this.parity, 	    8,		 UVM_DEC		);
			printer.print_field( "pkt_valid", 			this.pkt_valid, 	    1,		 UVM_DEC		);
			printer.print_field( "error", 		this.error,     1,		 UVM_DEC		);
			printer.print_field( "busy", 		this.busy,     1,		 UVM_DEC		);
			printer.print_field( "resetn", 		this.resetn,     1,		 UVM_DEC		);
	endfunction
	
	function void router_src_xtn::post_randomize();
	//	parity=header;
			//foreach(payload[i])
				begin
			//	parity=parity^payload[i];
				parity = 55;
				end
	endfunction : post_randomize
   
			
			
   
