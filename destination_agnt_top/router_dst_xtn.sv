class router_dst_xtn extends uvm_sequence_item;
	`uvm_object_utils(router_dst_xtn)
	
	bit [7:0] header;
	bit [7:0] payload[];
	bit [7:0] parity;
	bit valid_out;
	bit read_enb;
	rand bit [5:0] delay;
	
	function new (string name = "router_dst_xtn");
		super.new(name);
	endfunction
	
	/*function void do_copy(uvm_object rhs);
		router_dst_xtn rhs_;
		
		if(!$cast(rhs_,rhs))
			begin
			`uvm_fatal("do_copy","cast of the rsrcxtn object failed")
			end
			
			super.do_copy(rhs);
			
			header=rhs_.header;
			payload=new[header[7:2]];
			foreach(payload[i])
				payload[i]=rhs_.payload[i];
			parity=rhs_.parity;
			valid_out=rhs_.valid_out;
			read_enb=rhs_.read_enb;
			delay=rhs_.delay;
			
	endfunction*/
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		
		printer.print_field("header",this.header,8,UVM_DEC);
		foreach(payload[i])
			printer.print_field($sformatf("payload[%0d]",i),this.payload[i],8,UVM_DEC);
		printer.print_field( "parity", 			this.parity, 	    8,		 UVM_DEC);
		printer.print_field( "valid_out", 			this.valid_out, 	    1,		 UVM_DEC);
		printer.print_field( "read_enb", 		this.read_enb,     1,		 UVM_DEC		);
		printer.print_field( "delay", 		this.delay,     6,		 UVM_DEC		);
	endfunction
endclass
