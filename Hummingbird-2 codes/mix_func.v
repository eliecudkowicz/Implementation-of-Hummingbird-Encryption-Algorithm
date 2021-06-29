//------------------------------------------------------------------
// Project Name: Implementation of Hummingbird Encryption Algorithm
// Team Number:  xohw21-114
// Participants: Elie Cudkowicz, Itamar Yunnian
// Supervisor:	 Uri Stroh
// Date:		 June 2021
//------------------------------------------------------------------

module mix_func (
	// inputs
	input wire 	[15:0] 	word_in,
	input wire 			clk,
	input wire			rst,
	// output
	output wire [15:0]	mixed_word
);
// intenal signals
	// output of each S-box
	reg  [3:0] 	sb_1;
	reg  [3:0] 	sb_2;
	reg  [3:0] 	sb_3;
	reg  [3:0] 	sb_4;
	// concatenation of 4 S-box
	wire [15:0]	sb_out;

	// S-box 1
	always @ (posedge clk or posedge rst)
		begin
		if (rst)
			sb_1 <= 4'd0;
		else
			case (word_in[15:12])
				4'd0: 		sb_1 <= 4'd7;
				4'd1: 		sb_1 <= 4'd12;
				4'd2: 		sb_1 <= 4'd14;
				4'd3: 		sb_1 <= 4'd9;
				4'd4: 		sb_1 <= 4'd2;
				4'd5: 		sb_1 <= 4'd1;
				4'd6: 		sb_1 <= 4'd5;
				4'd7: 		sb_1 <= 4'd15;
				4'd8: 		sb_1 <= 4'd11;
				4'd9: 		sb_1 <= 4'd6;
				4'd10: 		sb_1 <= 4'd13;
				4'd11: 		sb_1 <= 4'd0;
				4'd12: 		sb_1 <= 4'd4;
				4'd13: 		sb_1 <= 4'd8;
				4'd14: 		sb_1 <= 4'd10;
				4'd15: 		sb_1 <= 4'd3;
				default:	sb_1 <= 4'd0;
			endcase
		end
		
	// S-box 2
	always @ (posedge clk or posedge rst)
		begin
		if (rst)
			sb_2 <= 4'd0;
		else
			case (word_in[11:8])
				4'd0: 		sb_2 <= 4'd4;
				4'd1: 		sb_2 <= 4'd10;
				4'd2: 		sb_2 <= 4'd1;
				4'd3: 		sb_2 <= 4'd6;
				4'd4: 		sb_2 <= 4'd8;
				4'd5: 		sb_2 <= 4'd15;
				4'd6: 		sb_2 <= 4'd7;
				4'd7: 		sb_2 <= 4'd12;
				4'd8: 		sb_2 <= 4'd3;
				4'd9: 		sb_2 <= 4'd0;
				4'd10: 		sb_2 <= 4'd14;
				4'd11: 		sb_2 <= 4'd13;
				4'd12: 		sb_2 <= 4'd5;
				4'd13: 		sb_2 <= 4'd9;
				4'd14: 		sb_2 <= 4'd11;
				4'd15: 		sb_2 <= 4'd2;
				default:	sb_2 <= 4'd0;
			endcase
		end
		
	// S-box 3
	always @ (posedge clk or posedge rst)
		begin
		if (rst)
			sb_3 <= 4'd0;
		else
			case (word_in[7:4])
				4'd0: 		sb_3 <= 4'd2;
				4'd1: 		sb_3 <= 4'd15;
				4'd2: 		sb_3 <= 4'd12;
				4'd3: 		sb_3 <= 4'd1;
				4'd4: 		sb_3 <= 4'd5;
				4'd5: 		sb_3 <= 4'd6;
				4'd6: 		sb_3 <= 4'd10;
				4'd7: 		sb_3 <= 4'd13;
				4'd8: 		sb_3 <= 4'd14;
				4'd9: 		sb_3 <= 4'd8;
				4'd10: 		sb_3 <= 4'd3;
				4'd11: 		sb_3 <= 4'd4;
				4'd12: 		sb_3 <= 4'd0;
				4'd13: 		sb_3 <= 4'd11;
				4'd14: 		sb_3 <= 4'd9;
				4'd15: 		sb_3 <= 4'd7;
				default:	sb_3 <= 4'd0;
			endcase
		end
		
	// S-box 4
	always @ (posedge clk or posedge rst)
		begin
		if (rst)
			sb_4 <= 4'd0;
		else
			case (word_in[3:0])
				4'd0: 		sb_4 <= 4'd15;
				4'd1: 		sb_4 <= 4'd4;
				4'd2: 		sb_4 <= 4'd5;
				4'd3: 		sb_4 <= 4'd8;
				4'd4: 		sb_4 <= 4'd9;
				4'd5: 		sb_4 <= 4'd7;
				4'd6: 		sb_4 <= 4'd2;
				4'd7: 		sb_4 <= 4'd1;
				4'd8: 		sb_4 <= 4'd10;
				4'd9: 		sb_4 <= 4'd3;
				4'd10: 		sb_4 <= 4'd0;
				4'd11: 		sb_4 <= 4'd14;
				4'd12: 		sb_4 <= 4'd6;
				4'd13: 		sb_4 <= 4'd12;
				4'd14: 		sb_4 <= 4'd13;
				4'd15: 		sb_4 <= 4'd11;
				default:	sb_4 <= 4'd0;
			endcase
		end
		
	// output of the 4 S-box - sb_out = {S1,S2,S3,S4}
	assign sb_out = {sb_1, sb_2, sb_3, sb_4};
	
	// output of the permutation - mixed_word = sb_out xor (sb_out<<<6) xor (sb_out<<<10)
	assign mixed_word = sb_out ^ ({sb_out[9:0], sb_out[15:10]}) ^ ({sb_out[5:0], sb_out[15:6]});
	
endmodule









