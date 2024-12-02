//----------------------------------------------------------------
//                      TOP MODULE
//----------------------------------------------------------------

module top;

	
	import uvm_pkg::*;
    import router_test_pkg::*;
	
	`include "uvm_macros.svh"
	
	//clock declaration
	
	bit clock;
	
	always
			#5 clock = ~clock;
			
	// declaration of interaces
	src_if src_inf(clock);
	dst_if dst_inf0(clock);
	dst_if dst_inf1(clock);
	dst_if dst_inf2(clock);
	
	// duv instantiation 
	router_top DUV (.clk(clock),
					.rstn(src_inf.resetn),
					.read_enb_0(dst_inf0.read_enb),
					.read_enb_1(dst_inf1.read_enb),
					.read_enb_2(dst_inf2.read_enb),
					.data_in(src_inf.data_in),
					.pkt_valid(src_inf.pkt_valid),
					.data_out_0(dst_inf0.data_out),
					.data_out_1(dst_inf1.data_out),
					.data_out_2(dst_inf2.data_out),
					.valid_out_0(dst_inf0.valid_out),
					.valid_out_1(dst_inf1.valid_out),
					.valid_out_2(dst_inf2.valid_out),
					.error(src_inf.error),
					.busy(src_inf.busy));
					

	initial
		begin
			`ifdef VCS
         		$fsdbDumpvars(0,top);
        		`endif
				
			//set the virtual interface using the uvm_config_db
			
				uvm_config_db #(virtual src_if)::set(null,"*","src_inf",src_inf);
				uvm_config_db #(virtual dst_if)::set(null,"*","dst_inf_0",dst_inf0);
				uvm_config_db #(virtual dst_if)::set(null,"*","dst_inf_1",dst_inf1);
				uvm_config_db #(virtual dst_if)::set(null,"*","dst_inf_2",dst_inf2);
				
				run_test();
		end
	
	
	
	
	
	
endmodule
			
