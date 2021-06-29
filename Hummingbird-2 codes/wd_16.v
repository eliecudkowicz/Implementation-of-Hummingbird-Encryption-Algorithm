//------------------------------------------------------------------
// Project Name: Implementation of Hummingbird Encryption Algorithm
// Team Number:  xohw21-114
// Participants: Elie Cudkowicz, Itamar Yunnian
// Supervisor:	 Uri Stroh
// Date:		 June 2021
//------------------------------------------------------------------

module wd_16(
	// inputs
	input wire 			clk,
	input wire			rst,
	input wire	[15:0] 	data_in,
	input wire	[15:0] 	key_1,
	input wire	[15:0] 	key_2,
	input wire	[15:0] 	key_3,
	input wire	[15:0] 	key_4,
	// output
	output wire	[15:0] 	data_out
);

	// internal signals
	reg 	[15:0] data_in_1 ;
	reg 	[15:0] data_in_2 ;
	reg 	[15:0] data_in_3 ;
	reg 	[15:0] data_in_4 ;
	wire 	[15:0] data_out_1 ;
	wire 	[15:0] data_out_2 ;
	wire 	[15:0] data_out_3 ;
	reg 	[15:0] data_out_1_sampled;
	reg 	[15:0] data_out_2_sampled;
	reg 	[15:0] data_out_3_sampled;
	
	// sample the data that get in mix_func
	always @(posedge clk or posedge rst)
		if (rst)
		begin
			data_in_1 <= 16'd0;
			data_in_2 <= 16'd0;
			data_in_3 <= 16'd0;
			data_in_4 <= 16'd0;
		end
		else
			begin
				 data_in_1 <= data_in ^ key_1;
				 data_in_2 <= data_out_1_sampled ^ key_2;
				 data_in_3 <= data_out_2_sampled ^ key_3;
				 data_in_4 <= data_out_3_sampled ^ key_4;
			end
	
	// sample the data that get out mix func	
	always @(posedge clk or posedge rst)
		if (rst)
		begin
			data_out_1_sampled <= 16'd0;
			data_out_2_sampled <= 16'd0;
			data_out_3_sampled <= 16'd0;
		end
		else
			begin
				data_out_1_sampled <= data_out_1;
				data_out_2_sampled <= data_out_2;
				data_out_3_sampled <= data_out_3;
			end
	
	// data_out = mix_func(mix_func(mix_func(mix_func(data_in xor key_1) xor key_2) xor key_3) xor key_4)
	mix_func f1 (.word_in		(data_in_1),
				 .clk			(clk),
				 .rst			(rst),
				 .mixed_word	(data_out_1)
				);
				 			
	mix_func f2 (.word_in		(data_in_2),
				 .clk			(clk),
				 .rst			(rst),
				 .mixed_word	(data_out_2)
				 );
	
	mix_func f3 (.word_in		(data_in_3),
				 .clk			(clk),
				 .rst			(rst),
				 .mixed_word	(data_out_3)
				 );
		
	mix_func f4 (.word_in		(data_in_4),
				 .clk			(clk),
				 .rst			(rst),
				 .mixed_word	(data_out)
				 ); 

endmodule