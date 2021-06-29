//------------------------------------------------------------------
// Project Name: Implementation of Hummingbird Encryption Algorithm
// Team Number:  xohw21-114
// Participants: Elie Cudkowicz, Itamar Yunnian
// Supervisor:	 Uri Stroh
// Date:		 June 2021
//------------------------------------------------------------------

module initialization(
	// inputs
	input wire			clk,
	input wire 			rst,
	input wire 	[63:0] 	iv,
	input wire  [127:0] key,
	// output
	output wire [15:0] r1,
	output wire [15:0] r2,
	output wire [15:0] r3,
	output wire [15:0] r4,
	output wire [15:0] r5,
	output wire [15:0] r6,
	output wire [15:0] r7,
	output wire [15:0] r8
	);
	
// internal signals
	// R for the first round
	wire [15:0] r1_in = iv[63:48];
	wire [15:0] r2_in = iv[47:32];
	wire [15:0] r3_in = iv[31:16];
	wire [15:0] r4_in = iv[15:0];
	wire [15:0] r5_in = iv[63:48];
	wire [15:0] r6_in = iv[47:32];
	wire [15:0] r7_in = iv[31:16];
	wire [15:0] r8_in = iv[15:0];
	// R for the second round
	wire [15:0] r1_1;
	wire [15:0] r2_1;
	wire [15:0] r3_1;
	wire [15:0] r4_1;
	wire [15:0] r5_1;
	wire [15:0] r6_1;
	wire [15:0] r7_1;
	wire [15:0] r8_1;
	// R for the third round
	wire [15:0] r1_2;
	wire [15:0] r2_2;
	wire [15:0] r3_2;
	wire [15:0] r4_2;
	wire [15:0] r5_2;
	wire [15:0] r6_2;
	wire [15:0] r7_2;
	wire [15:0] r8_2;
	// R for the fourth round
	wire [15:0] r1_3;
	wire [15:0] r2_3;
	wire [15:0] r3_3;
	wire [15:0] r4_3;
	wire [15:0] r5_3;
	wire [15:0] r6_3;
	wire [15:0] r7_3;
	wire [15:0] r8_3;
	// R output of the initialization
	wire [15:0] r1_4;
	wire [15:0] r2_4;
	wire [15:0] r3_4;
	wire [15:0] r4_4;
	wire [15:0] r5_4;
	wire [15:0] r6_4;
	wire [15:0] r7_4;
	wire [15:0] r8_4;
	// temporary signals for calculs
	wire [15:0] r1_1_temp;
	wire [15:0] r2_1_temp;
	wire [15:0] r3_1_temp;
	wire [15:0] r4_1_temp;
	wire [15:0] r1_2_temp;
	wire [15:0] r2_2_temp;
	wire [15:0] r3_2_temp;
	wire [15:0] r4_2_temp;
	wire [15:0] r1_3_temp;
	wire [15:0] r2_3_temp;
	wire [15:0] r3_3_temp;
	wire [15:0] r4_3_temp;
	wire [15:0] r1_4_temp;
	wire [15:0] r2_4_temp;
	wire [15:0] r3_4_temp;
	wire [15:0] r4_4_temp;
	// output of each round
	wire [15:0] t1_1;
	wire [15:0] t2_1;
	wire [15:0] t3_1;
	wire [15:0] t4_1;
	wire [15:0] t1_2;
	wire [15:0] t2_2;
	wire [15:0] t3_2;
	wire [15:0] t4_2;
	wire [15:0] t1_3;
	wire [15:0] t2_3;
	wire [15:0] t3_3;
	wire [15:0] t4_3;
	wire [15:0] t1_in;
	wire [15:0] t2_in;
	wire [15:0] t3_in;
	wire [15:0] t4_in;
	// sub-keys
	wire [15:0] key_1 = key[127:112];
	wire [15:0] key_2 = key[111:96];
	wire [15:0] key_3 = key[95:80];
	wire [15:0] key_4 = key[79:64];
	wire [15:0] key_5 = key[63:48];
	wire [15:0] key_6 = key[47:32];
	wire [15:0] key_7 = key[31:16];
	wire [15:0] key_8 = key[15:0];
	
// i = 0 - first round of initialization
	wd_16 t1_in_0(			.clk		(clk),
							.rst		(rst),
							.data_in	((r1_in + 16'd0)% 17'd65536),
				            .key_1		(key_1),
				            .key_2		(key_2),
				            .key_3		(key_3),
				            .key_4		(key_4),
				            .data_out	(t1_in)
			);
	wd_16 t2_in_0 (			.clk		(clk),
							.rst		(rst),
							.data_in	((r2_in + t1_in)% 17'd65536),
							.key_1		(key_5),
							.key_2		(key_6),
							.key_3		(key_7),
							.key_4		(key_8),
							.data_out	(t2_in)
			);
	wd_16 t3_in_0 (			.clk		(clk),
							.rst		(rst),
							.data_in	((r3_in + t2_in)% 17'd65536),
							.key_1		(key_1),
							.key_2		(key_2),
							.key_3		(key_3),
							.key_4		(key_4),
							.data_out	(t3_in)
			);	
	wd_16 t4_in_0 (			.clk		(clk),
							.rst		(rst),
							.data_in	((r4_in + t3_in)% 17'd65536),
							.key_1		(key_5),
							.key_2		(key_6),
							.key_3		(key_7),
							.key_4		(key_8),
							.data_out	(t4_in)
			);
	
// i = 1 -second round of initialization
	wd_16 t1_in_1 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r1_1 + 16'd1)% 17'd65536),
						.key_1		(key_1),
						.key_2		(key_2),
						.key_3		(key_3),
						.key_4		(key_4),
						.data_out	(t1_1)
			);
	wd_16 t2_in_1 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r2_1 + t1_1)% 17'd65536),
						.key_1		(key_5 ),
						.key_2		(key_6),
						.key_3		(key_7),
						.key_4		(key_8),
						.data_out	(t2_1)
				);
	wd_16 t3_in_1 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r3_1 + t2_1)% 17'd65536),
						.key_1		(key_1),
						.key_2		(key_2),
						.key_3		(key_3),
						.key_4		(key_4),
						.data_out	(t3_1)
				);			
	wd_16 t4_in_1 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r4_1 + t3_1)% 17'd65536),
						.key_1		(key_5),
						.key_2		(key_6),
						.key_3		(key_7),
						.key_4		(key_8),
						.data_out	(t4_1)
				);
				
// i = 2 - third round of initialization
	wd_16 t1_in_2 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r1_2 + 16'd2)% 17'd65536),
						.key_1		(key_1),
						.key_2		(key_2),
						.key_3		(key_3),
						.key_4		(key_4),
						.data_out	(t1_2)
			);
	wd_16 t2_in_2 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r2_2 + t1_2)% 17'd65536),
						.key_1		(key_5 ),
						.key_2		(key_6),
						.key_3		(key_7),
						.key_4		(key_8),
						.data_out	(t2_2)
				);
	wd_16 t3_in_2 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r3_2 + t2_2)% 17'd65536),
						.key_1		(key_1),
						.key_2		(key_2),
						.key_3		(key_3),
						.key_4		(key_4),
						.data_out	(t3_2)
				);
	wd_16 t4_in_2 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r4_2 + t3_2)% 17'd65536),
						.key_1		(key_5),
						.key_2		(key_6),
						.key_3		(key_7),
						.key_4		(key_8),
						.data_out	(t4_2)
				);
				
// i = 3 - fourth round of initialization
	wd_16 t1_in_3 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r1_3 + 16'd3)% 17'd65536),
						.key_1		(key_1),
						.key_2		(key_2),
						.key_3		(key_3),
						.key_4		(key_4),
						.data_out	(t1_3)
			);
	wd_16 t2_in_3 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r2_3 + t1_3)% 17'd65536),
						.key_1		(key_5 ),
						.key_2		(key_6),
						.key_3		(key_7),
						.key_4		(key_8),
						.data_out	(t2_3)
				);
	wd_16 t3_in_3 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r3_3 + t2_3)% 17'd65536),
						.key_1		(key_1),
						.key_2		(key_2),
						.key_3		(key_3),
						.key_4		(key_4),
						.data_out	(t3_3)
				);
	wd_16 t4_in_3 (		.clk		(clk),
						.rst		(rst),
						.data_in	((r4_3 + t3_3)% 17'd65536),
						.key_1		(key_5),
						.key_2		(key_6),
						.key_3		(key_7),
						.key_4		(key_8),
						.data_out	(t4_3)
				);

// i = 0 - calculate the 8 registers for second round		
		assign r1_1_temp = ((r1_in + t4_in)% 17'd65536);
		assign r2_1_temp = ((r2_in + t1_in)% 17'd65536);
		assign r3_1_temp = ((r3_in + t2_in)% 17'd65536);
		assign r4_1_temp = ((r4_in + t3_in)% 17'd65536);
		assign r1_1 = {r1_1_temp[12:0], r1_1_temp[15:13]};
		assign r2_1 = {r2_1_temp[0], r2_1_temp[15:1]};
		assign r3_1 = {r3_1_temp[7:0], r3_1_temp[15:8]};
		assign r4_1 = {r4_1_temp[14:0], r4_1_temp[15]};
		assign r5_1 = r5_in ^ r1_1;
		assign r6_1 = r6_in ^ r2_1;
		assign r7_1 = r7_in ^ r3_1;
		assign r8_1 = r8_in ^ r4_1;
		
// i = 1 - calculate the 8 registers for third round	
		assign r1_2_temp = ((r1_1 + t4_1)% 17'd65536);
		assign r2_2_temp = ((r2_1 + t1_1)% 17'd65536);
		assign r3_2_temp = ((r3_1 + t2_1)% 17'd65536);
		assign r4_2_temp = ((r4_1 + t3_1)% 17'd65536);
		assign r1_2 = {r1_2_temp[12:0], r1_2_temp[15:13]};
		assign r2_2 = {r2_2_temp[0], r2_2_temp[15:1]};
		assign r3_2 = {r3_2_temp[7:0], r3_2_temp[15:8]};
		assign r4_2 = {r4_2_temp[14:0], r4_2_temp[15]};
		assign r5_2 = r5_1 ^ r1_2;
		assign r6_2 = r6_1 ^ r2_2;
		assign r7_2 = r7_1 ^ r3_2;
		assign r8_2 = r8_1 ^ r4_2;
		
// i = 2 - calculate the 8 registers for fourth round	
		assign r1_3_temp = ((r1_2 + t4_2)% 17'd65536);
		assign r2_3_temp = ((r2_2 + t1_2)% 17'd65536);
		assign r3_3_temp = ((r3_2 + t2_2)% 17'd65536);
		assign r4_3_temp = ((r4_2 + t3_2)% 17'd65536);
		assign r1_3 = {r1_3_temp[12:0], r1_3_temp[15:13]};
		assign r2_3 = {r2_3_temp[0], r2_3_temp[15:1]};
		assign r3_3 = {r3_3_temp[7:0], r3_3_temp[15:8]};
		assign r4_3 = {r4_3_temp[14:0], r4_3_temp[15]};
		assign r5_3 = r5_2 ^ r1_3;
		assign r6_3 = r6_2 ^ r2_3;
		assign r7_3 = r7_2 ^ r3_3;
		assign r8_3 = r8_2 ^ r4_3;
		
// i = 3 - calculate the 8 register for result of initialization
		assign r1_4_temp = ((r1_3 + t4_3)% 17'd65536);
		assign r2_4_temp = ((r2_3 + t1_3)% 17'd65536);
		assign r3_4_temp = ((r3_3 + t2_3)% 17'd65536);
		assign r4_4_temp = ((r4_3 + t3_3)% 17'd65536);
		assign r1_4 = {r1_4_temp[12:0], r1_4_temp[15:13]};
		assign r2_4 = {r2_4_temp[0], r2_4_temp[15:1]};
		assign r3_4 = {r3_4_temp[7:0], r3_4_temp[15:8]};
		assign r4_4 = {r4_4_temp[14:0], r4_4_temp[15]};
		assign r5_4 = r5_3 ^ r1_4;
		assign r6_4 = r6_3 ^ r2_4;
		assign r7_4 = r7_3 ^ r3_4;
		assign r8_4 = r8_3 ^ r4_4;

// output registers of initialization		
		assign r1 = r1_4;
		assign r2 = r2_4;
		assign r3 = r3_4;
		assign r4 = r4_4;
		assign r5 = r5_4;
		assign r6 = r6_4;
		assign r7 = r7_4;
		assign r8 = r8_4;
		
endmodule