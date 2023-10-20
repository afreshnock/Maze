//////////////////////////////////
/// audio interface to DE1-SoC ///
/// March 2016                 ///
/// part 2 introducing serial  ///
/// serial shift registers     ///
/// both in and out            ///
//////////////////////////////////

// Revised 12/3/2021 by D. Gruenbacher
// Adapted from U. Toronot project
// Removed I2C interface since that is handled in SoC Computer


module audio (
aud_xclk	, // clock 12. MHz?
bclk 		, // bit stream clock
adclrck	, // left right clock ADC
adcdat	, // data stream ADC
daclrck	, // left right clock DAC
dacdat	, // data stream DAC
//sclk		, // serial clock I2C
//sdat		, // serail data I2C
ar		,
clk		,  // 50 MHz
adc_left_data,
dac_left_data,
gpio);     // 40 pin header

//output aud_xclk;
input adcdat;
input ar;
input clk;
input bclk;

input adclrck;
input daclrck;
//inout sdat;

output aud_xclk;
//output sclk;
output dacdat;
output [32:0] adc_left_data;
input [32:0] dac_left_data;

output[5:0] gpio;  // For debugging

wire swt;
assign swt = ar;


 serial_adc u2 (
 
	.serial_adc(adcdat),		// 32 bit serial in data
	//.SADCL(serial_lf),
	.SADCL(adc_left_data),
	.SADCR(serial_rt), 
	.adc_lr(adclrck),
	.clk(clk),				// 50 KHz clock
	.enable(swt)			// master reset

);

 serial_dac u3(
 
	.serial_dac(dacdat),		// 32 bit serial in data
	//.SDACL(serial_lf),
	.SDACL(dac_left_data),
	.SDACR(serial_rt), 
	.dac_lr(daclrck),
	.clk(clk),				// 50 KHz clock
	.enable(swt)			// master reset

);

///////////////////////////////////////////////////
/// variables and parameter for state machines  ///
///////////////////////////////////////////////////


 parameter clk_freq = 50000000;  // 50 Mhz
 parameter i2c_freq = 12288000;  // 12.288 Mhz

 wire[32:0] serial_lf;
 wire[32:0] serial_rt;
	
 ///////////////////////////////////////////////////////
 ////// I2C clock (50 Mhz)used for DE1-SoC video in chip ///
 ///////////////////////////////////////////////////////
	
  always @ (posedge clk or negedge swt)
  begin
		if (!swt)
		begin
			clk_div <= 0;
			ctrl_clk <= 0;
		end
		
		else
		
		begin
		
			if (clk_div <  (clk_freq/i2c_freq) )  // keeps dividing until reaches desired frequency
			clk_div <= clk_div + 1;
			
			else
			begin 
					clk_div <= 0;
					ctrl_clk <= ~ctrl_clk;
			end
		end
	end
 
 wire sclk; 
 wire sdat; 

/////////////////////////////////////////
//// internal signals
///////////////////////////////////////// 
 wire ACK ;
 wire ACK_enable;
 wire [23:0] data_23;
 wire TRN_END;
 reg ctrl_clk;
 reg [15:0] clk_div;  // clock divider

 assign aud_xclk = ctrl_clk; 
 
 assign gpio[0] = ctrl_clk;
 assign gpio[1] = bclk;
 assign gpio[2] = dacdat;
 assign gpio[3] = daclrck;
 assign gpio[4] = adcdat;
 assign gpio[5] = adclrck;
// assign gpio[6] = sclk;
 // assign gpio[7] = sdat;
 

endmodule
