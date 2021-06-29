//------------------------------------------------------------------
// Project Name: Implementation of Hummingbird Encryption Algorithm
// Team Number:  xohw21-114
// Participants: Elie Cudkowicz, Itamar Yunnian
// Supervisor:	 Uri Stroh
// Date:		 June 2021
//------------------------------------------------------------------

module hummingbird_top (
	// inputs
	input 			clk,
	input			rst,
	input 	[127:0] key,
	input 	[127:0] pt,
	input 	[63:0]  iv,
	// output
	output	[127:0]	ct
);

//internal signals
	// internal registers for first word
     wire [15:0] r1_in;
	 wire [15:0] r2_in;
	 wire [15:0] r3_in;
	 wire [15:0] r4_in;
	 wire [15:0] r5_in;
	 wire [15:0] r6_in;
	 wire [15:0] r7_in;
	 wire [15:0] r8_in;
	// internal registers for second word
	 wire [15:0] r1_w1;
	 wire [15:0] r2_w1;
	 wire [15:0] r3_w1;
	 wire [15:0] r4_w1;
	 wire [15:0] r5_w1;
	 wire [15:0] r6_w1;
	 wire [15:0] r7_w1;
	 wire [15:0] r8_w1;
	// internal registers for third word
	 wire [15:0] r1_w2;
	 wire [15:0] r2_w2;
	 wire [15:0] r3_w2;
	 wire [15:0] r4_w2;
	 wire [15:0] r5_w2;
	 wire [15:0] r6_w2;
	 wire [15:0] r7_w2;
	 wire [15:0] r8_w2;
	// internal registers for fourth word 
	 wire [15:0] r1_w3;
	 wire [15:0] r2_w3;
	 wire [15:0] r3_w3;
	 wire [15:0] r4_w3;
	 wire [15:0] r5_w3;
	 wire [15:0] r6_w3;
	 wire [15:0] r7_w3;
	 wire [15:0] r8_w3;
	// internal registers for fifth word 
	 wire [15:0] r1_w4;
	 wire [15:0] r2_w4;
	 wire [15:0] r3_w4;
	 wire [15:0] r4_w4;
	 wire [15:0] r5_w4;
	 wire [15:0] r6_w4;
	 wire [15:0] r7_w4;
	 wire [15:0] r8_w4;
	// internal registers for sixth word 
	 wire [15:0] r1_w5;
	 wire [15:0] r2_w5;
	 wire [15:0] r3_w5;
	 wire [15:0] r4_w5;
	 wire [15:0] r5_w5;
	 wire [15:0] r6_w5;
	 wire [15:0] r7_w5;
	 wire [15:0] r8_w5;
	// internal registers for seventh word 
	 wire [15:0] r1_w6;
	 wire [15:0] r2_w6;
	 wire [15:0] r3_w6;
	 wire [15:0] r4_w6;
	 wire [15:0] r5_w6;
	 wire [15:0] r6_w6;
	 wire [15:0] r7_w6;
	 wire [15:0] r8_w6;
	// internal registers for eigth word 
	 wire [15:0] r1_w7;
	 wire [15:0] r2_w7;
	 wire [15:0] r3_w7;
	 wire [15:0] r4_w7;
	 wire [15:0] r5_w7;
	 wire [15:0] r6_w7;
	 wire [15:0] r7_w7;
	 wire [15:0] r8_w7;
	// internal registers for next word 
	 wire [15:0] r1_w8;
	 wire [15:0] r2_w8;
	 wire [15:0] r3_w8;
	 wire [15:0] r4_w8;
	 wire [15:0] r5_w8;
	 wire [15:0] r6_w8;
	 wire [15:0] r7_w8;
	 wire [15:0] r8_w8;

	// initialization with IV
	initialization init	(clk,
						 rst,
						 iv,
						 key,
						 r1_in,
						 r2_in,
						 r3_in,
						 r4_in,
						 r5_in,
						 r6_in,
						 r7_in,
						 r8_in
	);
	
	// encryption of word 1
	encryption w1 (	clk,
					rst,
					pt[127:112],
					key,
					r1_in,
					r2_in,
					r3_in,
					r4_in,
					r5_in,
					r6_in,
					r7_in,
					r8_in,
					ct [127:112],
					r1_w1,
					r2_w1,
					r3_w1,
					r4_w1,
					r5_w1,
					r6_w1,
					r7_w1,
					r8_w1
	);
	
	// encryption of word 2
	encryption w2 (	clk,
					rst,
					pt[111:96],
					key,
					r1_w1,
					r2_w1,
					r3_w1,
					r4_w1,
					r5_w1,
					r6_w1,
					r7_w1,
					r8_w1,
					ct [111:96],
					r1_w2,
					r2_w2,
					r3_w2,
					r4_w2,
					r5_w2,
					r6_w2,
					r7_w2,
					r8_w2
	);
	
	// encryption of word 3
	encryption w3 (	clk,
					rst,
					pt[95:80],
					key,
					r1_w2,
					r2_w2,
					r3_w2,
					r4_w2,
					r5_w2,
					r6_w2,
					r7_w2,
					r8_w2,
					ct [95:80],
					r1_w3,
					r2_w3,
					r3_w3,
					r4_w3,
					r5_w3,
					r6_w3,
					r7_w3,
					r8_w3
	);
	
	// encryption of word 4
	encryption w4 (	clk,
					rst,
					pt[79:64],
					key,
					r1_w3,
					r2_w3,
					r3_w3,
					r4_w3,
					r5_w3,
					r6_w3,
					r7_w3,
					r8_w3,
					ct [79:64],
					r1_w4,
					r2_w4,
					r3_w4,
					r4_w4,
					r5_w4,
					r6_w4,
					r7_w4,
					r8_w4
	);
	
	// encryption of word 5
	encryption w5 ( clk,
					rst,
					pt[63:48],
					key,
					r1_w4,
					r2_w4,
					r3_w4,
					r4_w4,
					r5_w4,
					r6_w4,
					r7_w4,
					r8_w4,
					ct [63:48],
					r1_w5,
					r2_w5,
					r3_w5,
					r4_w5,
					r5_w5,
					r6_w5,
					r7_w5,
					r8_w5
	);
	
	// encryption of word 6
	encryption w6 (	clk,
					rst,
					pt[47:32],
					key,
					r1_w5,
					r2_w5,
					r3_w5,
					r4_w5,
					r5_w5,
					r6_w5,
					r7_w5,
					r8_w5,
					ct [47:32],
					r1_w6,
					r2_w6,
					r3_w6,
					r4_w6,
					r5_w6,
					r6_w6,
					r7_w6,
					r8_w6
	);
	
	// encryption of word 7
	encryption w7 (	clk,
					rst,
					pt[31:16],
					key,
					r1_w6,
					r2_w6,
					r3_w6,
					r4_w6,
					r5_w6,
					r6_w6,
					r7_w6,
					r8_w6,
					ct [31:16],
					r1_w7,
					r2_w7,
					r3_w7,
					r4_w7,
					r5_w7,
					r6_w7,
					r7_w7,
					r8_w7
	);
	
	// encryption of word 8
	encryption w8 (	clk,
					rst,
					pt[15:0],
					key,
					r1_w7,
					r2_w7,
					r3_w7,
					r4_w7,
					r5_w7,
					r6_w7,
					r7_w7,
					r8_w7,
					ct [15:0],
					r1_w8,
					r2_w8,
					r3_w8,
					r4_w8,
					r5_w8,
					r6_w8,
					r7_w8,
					r8_w8
	);

endmodule

