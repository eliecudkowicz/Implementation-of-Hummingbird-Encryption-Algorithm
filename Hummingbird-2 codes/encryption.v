//------------------------------------------------------------------
// Project Name: Implementation of Hummingbird Encryption Algorithm
// Team Number:  xohw21-114
// Participants: Elie Cudkowicz, Itamar Yunnian
// Supervisor:	 Uri Stroh
// Date:		 June 2021
//------------------------------------------------------------------

module encryption(
	// inputs
	input wire			clk,
	input wire			rst,
	input wire [15:0]	pt,
	input wire [127:0]	key,
	input wire [15:0]   r1,
	input wire [15:0]   r2,
	input wire [15:0]   r3,
	input wire [15:0]   r4,
	input wire [15:0]   r5,
	input wire [15:0]   r6,
	input wire [15:0]   r7,
	input wire [15:0]   r8,
	// output
	output wire	[15:0]   ct,
	output wire [15:0]   r1_o,
	output wire [15:0]   r2_o,
	output wire [15:0]   r3_o,
	output wire [15:0]   r4_o,
	output wire [15:0]   r5_o,
	output wire [15:0]   r6_o,
	output wire [15:0]   r7_o,
	output wire [15:0]   r8_o
	
);

// internal signals
	// sub-keys
	wire [15:0] key_1 = key[127:112];
	wire [15:0] key_2 = key[111:96];
	wire [15:0] key_3 = key[95:80];
	wire [15:0] key_4 = key[79:64];
	wire [15:0] key_5 = key[63:48];
	wire [15:0] key_6 = key[47:32];
	wire [15:0] key_7 = key[31:16];
	wire [15:0] key_8 = key[15:0];
	// output of each WD16
	wire [15:0] t1;
	wire [15:0] t2;
	wire [15:0] t3;
	wire [15:0] t4;
	reg [15:0] t1_sampled;
	reg [15:0] t2_sampled;
	reg [15:0] t3_sampled;
	reg [15:0] t4_sampled;
	// combination of key and r
	reg [15:0] key_55;
	reg [15:0] key_66;
	reg [15:0] key_77;
	reg [15:0] key_88;
	reg [15:0] key_15;
	reg [15:0] key_26;
	reg [15:0] key_37;
	reg [15:0] key_48;
	// data_in of WD16
	reg [15:0] data_1;
	reg [15:0] data_2;
	reg [15:0] data_3;
	reg [15:0] data_4;
	
	// sample the combination of the key and internal status
	always @(posedge clk or posedge rst)
		if (rst)
		begin
			key_55 <= 0;
            key_66 <= 0;
	        key_77 <= 0;
	        key_88 <= 0;
	        key_15 <= 0;
	        key_26 <= 0;
	        key_37 <= 0;
	        key_48 <= 0;
		end
		else
			begin
			key_55 <= key_5 ^ r5;
            key_66 <= key_6 ^ r6;
	        key_77 <= key_7 ^ r7;
	        key_88 <= key_8 ^ r8;
	        key_15 <= key_1 ^ r5;
	        key_26 <= key_2 ^ r6;
	        key_37 <= key_3 ^ r7;
	        key_48 <= key_4 ^ r8;
			end
	
	// sample data_in
	always @(posedge clk or posedge rst)
		if (rst)
		begin
			data_1 <= 0;
			data_2 <= 0;
			data_3 <= 0;
			data_4 <= 0;
		end
		else
			begin
			data_1 <= (r1 + pt)% 17'd65536;
			data_2 <= (r2 + t1)% 17'd65536;
			data_3 <= (r3 + t2)% 17'd65536;
			data_4 <= (r4 + t3)% 17'd65536;
			end
	
	// sample the data_out of each WD16
	always @(posedge clk or posedge rst)
		if (rst)
		begin
			t1_sampled <= 0;
			t2_sampled <= 0;
			t3_sampled <= 0;
			t4_sampled <= 0;
		end
		else
			begin
			t1_sampled <= t1;
			t2_sampled <= t2;
			t3_sampled <= t3;
			t4_sampled <= t4;
			end
	
	// encryption of one word
	wd_16 t1_enc (	.clk		(clk),
					.rst		(rst),
					.data_in	(data_1),
					.key_1		(key_1),
					.key_2		(key_2),
					.key_3		(key_3),
					.key_4		(key_4),
					.data_out	(t1)
			);
	wd_16 t2_enc (	.clk		(clk),
					.rst		(rst),
					.data_in	(data_2),
					.key_1		(key_55),
					.key_2		(key_66),
					.key_3		(key_77),
					.key_4		(key_88),
					.data_out	(t2)
			);
	wd_16 t3_enc (	.clk		(clk),
					.rst		(rst),
					.data_in	(data_3),
					.key_1		(key_15),
					.key_2		(key_26),
					.key_3		(key_37),
					.key_4		(key_48),
					.data_out	(t3)
			);
	wd_16 t4_enc (	.clk		(clk),
					.rst		(rst),
					.data_in	(data_4),
					.key_1		(key_5),
					.key_2		(key_6),
					.key_3		(key_7),
					.key_4		(key_8),
					.data_out	(t4)
			);

	// update the internal register for encrypting next word
	assign r1_o = (r1 + t3) % 17'd65536;
	assign r2_o = (r2 + t1) % 17'd65536;
	assign r3_o = (r3 + t2) % 17'd65536;
	assign r4_o = (r4 + r1 + t3 + t1) % 17'd65536;
	assign r5_o = r5 ^ r1_o;
	assign r6_o = r6 ^ r2_o;
	assign r7_o = r7 ^ r3_o;
	assign r8_o = r8 ^ r4_o;
	
	// output of encrypting one word
	assign ct = (t4 + r1)% 17'd65536;

endmodule
			
	