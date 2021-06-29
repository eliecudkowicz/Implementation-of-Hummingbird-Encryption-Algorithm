//------------------------------------------------------------------
// Project Name: Implementation of Hummingbird Encryption Algorithm
// Team Number:  xohw21-114
// Participants: Elie Cudkowicz, Itamar Yunnian
// Supervisor:	 Uri Stroh
// Date:		 June 2021
//------------------------------------------------------------------

module top_wrapper_arduino (
	// inputs
	input  wire			    clk,
	input  wire			    rst,
	input  wire				ack_ard,
	input  wire				req_ard,
	input  wire				ct_valid,
	input  wire	[7:0]		led_out,
	input  wire 			data_in,
	output reg	[15:0]		data_to_led,
	// outputs
	output reg				ct_out,
	output wire				ack_bas,
	output wire  			req_bas
);

//internal signals
	// registers to store input data
	reg  [127:0] 	pt_in;
	reg  [127:0] 	key_in;
	reg  [63:0] 	iv_in;
	reg  [127:0] 	pt;
	reg  [127:0] 	key;
	reg  [63:0] 	iv;
	// output of encryption
	wire [127:0]    ct;
	// count up to 320 to insert data_in to relevant register
	reg  [8:0]  	cntr;
	// ack from basys to arduino
	reg				ack_in;
	// count when req from arduino is high to check if stable
	reg	[3:0]  		cntr_req_1;
	wire			req_real_1;
	// count when req from arduino is low to check if stable
	reg	[3:0]  		cntr_req_0;
	wire			req_real_0;
	// count when ack from arduino is high to check if stable
	reg	[3:0]  		cntr_ack;
	wire			ack_real;
	// count up to 128 to send the ciphertext
	reg [7:0]  		cntr_send;
	// request from basys
	reg				req_bas_in;
	//count when ct_valid from arduino is high to check if stable
	reg	[3:0]  		cntr_ct_valid;
	wire			ct_valid_real;
	
// handshake when arduino send data to basys3	
	always @(posedge clk)
	begin
		if (rst)
			begin
			pt   	<= 128'd0;
			cntr 	<= 9'd0;
			key   	<= 128'd0;
			iv   	<= 64'd0;
			ack_in  <= 0;
			end
		else
			if (req_real_1 && ~ack_in)
				begin
					if (cntr < 9'd320)
						begin
						cntr    <= cntr + 9'd1;
						ack_in  <= 1'd1;
						end
				end
			else
				if (ack_in)
					begin
					case (cntr)
							1:	  pt[127]   	<= data_in;
							2:    pt[126]  	 	<= data_in;
							3:    pt[125]  		<= data_in;
							4:    pt[124]  		<= data_in;
							5:    pt[123]  		<= data_in;
							6:    pt[122]  		<= data_in;
							7:    pt[121] 		<= data_in;
							8:    pt[120]		<= data_in;
							9:	  pt[119]   	<= data_in;
							10:   pt[118]  		<= data_in;
							11:   pt[117]  		<= data_in;
							12:   pt[116]  		<= data_in;
							13:   pt[115]  		<= data_in;
							14:   pt[114]  		<= data_in;
							15:   pt[113] 		<= data_in;
							16:   pt[112]		<= data_in;
							17:	  pt[111]   	<= data_in;
							18:	  pt[110]   	<= data_in;
							19:	  pt[109]   	<= data_in;
							20:	  pt[108]   	<= data_in;
							21:	  pt[107]   	<= data_in;
							22:	  pt[106]   	<= data_in;
							23:	  pt[105]   	<= data_in;
							24:	  pt[104]   	<= data_in;
							25:	  pt[103]   	<= data_in;
							26:	  pt[102]   	<= data_in;
							27:	  pt[101]   	<= data_in;
							28:	  pt[100]   	<= data_in;
							29:	  pt[99]   	    <= data_in;
							30:	  pt[98]   	    <= data_in;
							31:	  pt[97]   	    <= data_in;
							32:	  pt[96]   	    <= data_in;
							33:	  pt[95]   	    <= data_in;   
							34:   pt[94]        <= data_in;   
							35:   pt[93]        <= data_in;   
							36:   pt[92]        <= data_in;   
							37:   pt[91]        <= data_in;   
							38:   pt[90]        <= data_in;   
							39:   pt[89]        <= data_in;   
							40:   pt[88]        <= data_in;   
							41:   pt[87]        <= data_in;   
							42:   pt[86]        <= data_in;   
							43:   pt[85]        <= data_in;   
							44:   pt[84]        <= data_in;   
							45:   pt[83]        <= data_in;   
							46:   pt[82]        <= data_in;   
							47:   pt[81]        <= data_in;   
							48:   pt[80]        <= data_in;   
							49:   pt[79]        <= data_in;   
							50:   pt[78]        <= data_in;   
							51:   pt[77]        <= data_in;   
							52:   pt[76]        <= data_in;   
							53:   pt[75]        <= data_in;   
							54:   pt[74]        <= data_in;   
							55:   pt[73]        <= data_in;   
							56:   pt[72]        <= data_in;   
							57:   pt[71]        <= data_in;   
							58:   pt[70]        <= data_in;   
							59:   pt[69]        <= data_in;   
							60:   pt[68]        <= data_in;   
							61:   pt[67]        <= data_in;   
							62:   pt[66]        <= data_in;   
							63:   pt[65]        <= data_in;   
							64:   pt[64]        <= data_in;   
							65:	  pt[63]   	    <= data_in;   
							67:   pt[61]        <= data_in;   
							66:   pt[62]        <= data_in;   
							68:   pt[60]        <= data_in;   
							69:   pt[59]        <= data_in;   
							70:   pt[58]        <= data_in;   
							71:   pt[57]        <= data_in;   
							72:   pt[56]        <= data_in;   
							73:   pt[55]        <= data_in;   
							74:   pt[54]        <= data_in;   
							75:   pt[53]        <= data_in;   
							76:   pt[52]        <= data_in;   
							77:   pt[51]        <= data_in;   
							78:   pt[50]        <= data_in;   
							79:   pt[49]        <= data_in;   
							80:   pt[48]        <= data_in;   
							81:   pt[47]        <= data_in;   
							82:   pt[46]        <= data_in;   
							83:   pt[45]        <= data_in;   
							84:   pt[44]        <= data_in;   
							85:   pt[43]        <= data_in;   
							86:   pt[42]        <= data_in;   
							87:   pt[41]        <= data_in;   
							88:   pt[40]        <= data_in;   
							89:   pt[39]        <= data_in;   
							90:   pt[38]        <= data_in;   
							91:   pt[37]        <= data_in;   
							92:   pt[36]        <= data_in;   
							93:   pt[35]        <= data_in;   
							94:   pt[34]        <= data_in;   
							95:   pt[33]        <= data_in;   
							96:   pt[32]        <= data_in;   
							97:	  pt[31]   	    <= data_in;		
							98:   pt[30]        <= data_in;   
							99:   pt[29]        <= data_in;   
							100:  pt[28]        <= data_in;   
							101:  pt[27]        <= data_in;   
							102:  pt[26]        <= data_in;   
							103:  pt[25]        <= data_in;   
							104:  pt[24]        <= data_in;   
							105:  pt[23]        <= data_in;   
							106:  pt[22]        <= data_in;   
							107:  pt[21]        <= data_in;   
							108:  pt[20]        <= data_in;   
							109:  pt[19]        <= data_in;   
							110:  pt[18]        <= data_in;   
							111:  pt[17]        <= data_in;   
							112:  pt[16]        <= data_in;   
							113:  pt[15]        <= data_in;   
							114:  pt[14]        <= data_in;   
							115:  pt[13]        <= data_in;   
							116:  pt[12]        <= data_in;   
							117:  pt[11]        <= data_in;   
							118:  pt[10]        <= data_in;   
							119:  pt[9]         <= data_in;   
							120:  pt[8]         <= data_in;   
							121:  pt[7]         <= data_in;   
							122:  pt[6]         <= data_in;   
							123:  pt[5]         <= data_in;   
							124:  pt[4]         <= data_in;   
							125:  pt[3]         <= data_in;   
							126:  pt[2]         <= data_in;   
							127:  pt[1]         <= data_in;   
							128:  pt[0]         <= data_in;
							129:  key[127]   	<= data_in;
							130:  key[126]  	<= data_in;
							131:  key[125]  	<= data_in;
							132:  key[124]  	<= data_in;
							133:  key[123]  	<= data_in;
							134:  key[122]  	<= data_in;
							135:  key[121] 		<= data_in;
							136:  key[120]		<= data_in;
							137:  key[119]   	<= data_in;
							138:  key[118]  	<= data_in;
							139:  key[117]  	<= data_in;
							140:  key[116]  	<= data_in;
							141:  key[115]  	<= data_in;
							142:  key[114]  	<= data_in;
							143:  key[113] 		<= data_in;
							144:  key[112]		<= data_in;
							145:  key[111]   	<= data_in;
							146:  key[110]   	<= data_in;
							147:  key[109]   	<= data_in;
							148:  key[108]   	<= data_in;
							149:  key[107]   	<= data_in;
							150:  key[106]   	<= data_in;
							151:  key[105]   	<= data_in;
							152:  key[104]   	<= data_in;
							153:  key[103]   	<= data_in;
							154:  key[102]   	<= data_in;
							155:  key[101]   	<= data_in;
							156:  key[100]   	<= data_in;
							157:  key[99]   	<= data_in;
							158:  key[98]   	<= data_in;
							159:  key[97]   	<= data_in;
							160:  key[96]   	<= data_in;
							161:  key[95]   	<= data_in;
							162:  key[94]       <= data_in;
							163:  key[93]       <= data_in;
							164:  key[92]       <= data_in;
							165:  key[91]       <= data_in;
							166:  key[90]       <= data_in;
							167:  key[89]       <= data_in;
							168:  key[88]       <= data_in;
							169:  key[87]       <= data_in;
							170:  key[86]       <= data_in;
							171:  key[85]       <= data_in;
							172:  key[84]       <= data_in;
							173:  key[83]       <= data_in;
							174:  key[82]       <= data_in;
							175:  key[81]       <= data_in;
							176:  key[80]       <= data_in;
							177:  key[79]       <= data_in;
							178:  key[78]       <= data_in;
							179:  key[77]       <= data_in;
							180:  key[76]       <= data_in;
							181:  key[75]       <= data_in;
							182:  key[74]       <= data_in;
							183:  key[73]       <= data_in;
							184:  key[72]       <= data_in;
							185:  key[71]       <= data_in;
							186:  key[70]       <= data_in;
							187:  key[69]       <= data_in;
							188:  key[68]       <= data_in;
							189:  key[67]       <= data_in;
							190:  key[66]       <= data_in;
							191:  key[65]       <= data_in;
							192:  key[64]       <= data_in;
							193:  key[63]   	<= data_in;
							194:  key[61]       <= data_in;
							195:  key[62]       <= data_in;
							196:  key[60]       <= data_in;
							197:  key[59]       <= data_in;
							198:  key[58]       <= data_in;
							199:  key[57]       <= data_in;
							200:  key[56]       <= data_in;
							201:  key[55]       <= data_in;
							202:  key[54]       <= data_in;
							203:  key[53]       <= data_in;
							204:  key[52]       <= data_in;
							205:  key[51]       <= data_in;
							206:  key[50]       <= data_in;
							207:  key[49]       <= data_in;
							208:  key[48]       <= data_in;
							209:  key[47]       <= data_in;
							210:  key[46]       <= data_in;
							211:  key[45]       <= data_in;
							212:  key[44]       <= data_in;
							213:  key[43]       <= data_in;
							214:  key[42]       <= data_in;
							215:  key[41]       <= data_in;
							216:  key[40]       <= data_in;
							217:  key[39]       <= data_in;
							218:  key[38]       <= data_in;
							219:  key[37]       <= data_in;
							220:  key[36]       <= data_in;
							221:  key[35]       <= data_in;
							222:  key[34]       <= data_in;
							223:  key[33]       <= data_in;
							224:  key[32]       <= data_in;
							225:  key[31]   	<= data_in;
							226:  key[30]       <= data_in;
							227:  key[29]       <= data_in;
							228:  key[28]       <= data_in;
							229:  key[27]       <= data_in;
							230:  key[26]       <= data_in;
							231:  key[25]       <= data_in;
							232:  key[24]       <= data_in;
							233:  key[23]       <= data_in;
							234:  key[22]       <= data_in;
							235:  key[21]       <= data_in;
							236:  key[20]       <= data_in;
							237:  key[19]       <= data_in;
							238:  key[18]       <= data_in;
							239:  key[17]       <= data_in;
							240:  key[16]       <= data_in;
							241:  key[15]       <= data_in;
							242:  key[14]       <= data_in;
							243:  key[13]       <= data_in;
							244:  key[12]       <= data_in;
							245:  key[11]       <= data_in;
							246:  key[10]       <= data_in;
							247:  key[9]        <= data_in;
							248:  key[8]        <= data_in;
							249:  key[7]        <= data_in;
							250:  key[6]        <= data_in;
							251:  key[5]        <= data_in;
							252:  key[4]        <= data_in;
							253:  key[3]        <= data_in;
							254:  key[2]        <= data_in;
							255:  key[1]        <= data_in;
							256:  key[0]        <= data_in;
							257:  iv[63]   	    <= data_in;
							258:  iv[62]        <= data_in;
							259:  iv[61]        <= data_in;
							260:  iv[60]        <= data_in;
							261:  iv[59]        <= data_in;
							262:  iv[58]        <= data_in;
							263:  iv[57]        <= data_in;
							264:  iv[56]        <= data_in;
							265:  iv[55]        <= data_in;
							266:  iv[54]        <= data_in;
							267:  iv[53]        <= data_in;
							268:  iv[52]        <= data_in;
							269:  iv[51]        <= data_in;
							270:  iv[50]        <= data_in;
							271:  iv[49]        <= data_in;
							272:  iv[48]        <= data_in;
							273:  iv[47]        <= data_in;
							274:  iv[46]        <= data_in;
							275:  iv[45]        <= data_in;
							276:  iv[44]        <= data_in;
							277:  iv[43]        <= data_in;
							278:  iv[42]        <= data_in;
							279:  iv[41]        <= data_in;
							280:  iv[40]        <= data_in;
							281:  iv[39]        <= data_in;
							282:  iv[38]        <= data_in;
							283:  iv[37]        <= data_in;
							284:  iv[36]        <= data_in;
							285:  iv[35]        <= data_in;
							286:  iv[34]        <= data_in;
							287:  iv[33]        <= data_in;
							288:  iv[32]        <= data_in;
							289:  iv[31]   	    <= data_in;
							290:  iv[30]        <= data_in;
							291:  iv[29]        <= data_in;
							292:  iv[28]        <= data_in;
							293:  iv[27]        <= data_in;
							294:  iv[26]        <= data_in;
							295:  iv[25]        <= data_in;
							296:  iv[24]        <= data_in;
							297:  iv[23]        <= data_in;
							298:  iv[22]        <= data_in;
							299:  iv[21]        <= data_in;
							300:  iv[20]        <= data_in;
							301:  iv[19]        <= data_in;
							302:  iv[18]        <= data_in;
							303:  iv[17]        <= data_in;
							304:  iv[16]        <= data_in;
							305:  iv[15]        <= data_in;
							306:  iv[14]        <= data_in;
							307:  iv[13]        <= data_in;
							308:  iv[12]        <= data_in;
							309:  iv[11]        <= data_in;
							310:  iv[10]        <= data_in;
							311:  iv[9]         <= data_in;
							312:  iv[8]         <= data_in;
							313:  iv[7]         <= data_in;
							314:  iv[6]         <= data_in;
							315:  iv[5]         <= data_in;
							316:  iv[4]         <= data_in;
							317:  iv[3]         <= data_in;
							318:  iv[2]         <= data_in;
							319:  iv[1]         <= data_in;
							320:  iv[0]         <= data_in;
							default: pt <= 128'd0;
						endcase
					end
		   if (ack_in & req_real_0)
				ack_in <= 1'd0;			
	end				
	assign ack_bas = ack_in;

	// output the register (pt, key, iv) to the LED of the Basys3
	always @(posedge clk or posedge rst)
		if (rst)
			data_to_led <= 16'd0;
		else
			case (led_out)
				8'b10000000: 	data_to_led <= pt_in[127:112];
				8'b11000000: 	data_to_led <= pt_in[111:96];
				8'b11100000: 	data_to_led <= pt_in[95:80];
				8'b11110000: 	data_to_led <= pt_in[79:64];
				8'b11111000: 	data_to_led <= pt_in[63:48];
				8'b11111100: 	data_to_led <= pt_in[47:32]; 
				8'b11111110: 	data_to_led <= pt_in[31:16];
				8'b11111111: 	data_to_led <= pt_in[15:0];
				8'b01111111: 	data_to_led <= key_in[127:112];
				8'b00111111: 	data_to_led <= key_in[111:96];
				8'b00011111: 	data_to_led <= key_in[95:80];
				8'b00001111: 	data_to_led <= key_in[79:64];
				8'b00000111: 	data_to_led <= key_in[63:48];
				8'b00000011: 	data_to_led <= key_in[47:32]; 
				8'b00000001: 	data_to_led <= key_in[31:16];
				8'b00000000: 	data_to_led <= key_in[15:0];
				8'b10100000: 	data_to_led <= iv_in[63:48];
				8'b10110000: 	data_to_led <= iv_in[47:32]; 
				8'b10111000: 	data_to_led <= iv_in[31:16];
				8'b10111100: 	data_to_led <= iv_in[15:0];
				8'b10010000: 	data_to_led <= ct[127:112];
				8'b10011000: 	data_to_led <= ct[111:96];
				8'b10011100: 	data_to_led <= ct[95:80];
				8'b10011110: 	data_to_led <= ct[79:64];
				8'b10011111: 	data_to_led <= ct[63:48];
				8'b10001000: 	data_to_led <= ct[47:32]; 
				8'b10001100: 	data_to_led <= ct[31:16];
				8'b10001110: 	data_to_led <= ct[15:0];
				default:		data_to_led <= 16'd0;
			endcase
	 
	// check that req from arduino is stable when high
	always @(posedge clk or posedge rst)
		if (rst)
		begin	
			cntr_req_1 <= 4'd0;
		end
		else
			if (req_ard & ~req_real_1)
				cntr_req_1 <= cntr_req_1 + 4'd1;
			else
				if (~req_ard)
					begin
					cntr_req_1 <= 4'd0;
					end
					
	assign req_real_1 = (cntr_req_1 == 4'd10);				

	// check that req from arduino is stable when low
	always @(posedge clk or posedge rst)
		if (rst)
		begin	
			cntr_req_0 <= 4'd0;
		end
		else
			if (~req_ard & ~req_real_0)
				cntr_req_0 <= cntr_req_0 + 4'd1;
			else
				if (req_ard)
					begin
					cntr_req_0 <= 4'd0;
					end
					
	assign req_real_0 = (cntr_req_0 == 4'd10);
	
	// insert the data read from arduino to registers
	always @(posedge clk or posedge rst)
		if (rst)
		begin
			pt_in <= 128'd0;
			key_in <= 128'd0;
			iv_in <= 64'd0;
		end
		else
			begin
				pt_in <=  pt;
				key_in <= key;
				iv_in <=  iv; 
			end
	
	// run encryption with the 3 registers we got from arduino
	hummingbird_top hummingbird_top (	
						.clk	(clk),
						.rst	(rst),
						.key	(key_in),
						.pt		(pt_in),
						.iv		(iv_in),
						.ct		(ct)
	);

	// check that ack from arduino is stable when high
	always @(posedge clk or posedge rst)
		if (rst)
		begin	
			cntr_ack <= 0;
		end
		else
			if (ack_ard & ~ack_real)
				cntr_ack <= cntr_ack + 1;
			else
				if (~ack_ard)
					begin
					cntr_ack <= 0;
					end
					
	assign ack_real = (cntr_ack == 10);	
	
	// check that ct_valid from arduino is stable when high
	always @(posedge clk or posedge rst)
		if (rst)
		begin	
			cntr_ct_valid <= 0;
		end
		else
			if (ct_valid & ~ct_valid_real)
				cntr_ct_valid <= cntr_ct_valid + 1;
			else
				if (~ct_valid)
					begin
					cntr_ct_valid <= 0;
					end
					
	assign ct_valid_real = (cntr_ct_valid == 10);

	// handshake when basys3 send data to arduino 
	always @(posedge clk)
	begin
		if (rst)
			begin
			req_bas_in  <= 0;
			ct_out    	<= 0;
			cntr_send 	<= 0;
			end
		else
			if (ct_valid_real & ~ack_real & ~req_bas_in & cntr_send < 127)
				begin
				req_bas_in <= 1;
				ct_out <= ct[cntr_send];
				end
			else
				if (ack_real & req_bas_in)
				begin
					req_bas_in <= 0;
					cntr_send <= cntr_send + 1;
				end
	end	
	
	assign req_bas = req_bas_in;

endmodule