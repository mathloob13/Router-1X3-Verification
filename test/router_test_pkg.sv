package router_test_pkg;

	import uvm_pkg::*;
	
	`include "uvm_macros.svh"
	`include "router_src_xtn.sv"
	`include "router_dst_xtn.sv"
	
	`include "router_source_agent_config.sv"
	`include "router_dest_agent_config.sv"
	`include "router_env_config.sv"
		
	`include "router_src_drv.sv"	
	`include "router_src_mon.sv"
	`include "router_src_seqr.sv"
	`include "router_source_agent.sv"
	`include "router_source_agent_top.sv"
	`include "router_src_seqs.sv"	

	`include "router_dest_drv.sv"
	`include "router_dest_mon.sv"
	`include "router_dest_seqr.sv"
	`include "router_dest_agent.sv"
	`include "router_dest_agent_top.sv"
	`include "router_dst_seqs.sv"
	
	`include "router_virtual_seqr.sv"
	`include "router_virtual_seqs.sv"
	
	`include "router_scoreboard.sv"
	`include "router_env.sv"
	
	`include "router_vtest_lib.sv"
//	`include "router_assertions.sv"
endpackage
