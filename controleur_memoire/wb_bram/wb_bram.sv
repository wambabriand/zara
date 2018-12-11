//-----------------------------------------------------------------
// Wishbone BlockRAM
//-----------------------------------------------------------------
//
// Le paramètre mem_adr_width doit permettre de déterminer le nombre 
// de mots de la mémoire : (2048 pour mem_adr_width=11)

module wb_bram #(parameter mem_adr_width = 11) (
      // Wishbone interface
      wshb_if.slave wb_s
      );
      // a vous de jouer a partir d'ici
	// avec le cicle always_ff nous avons un processus synchrone sur( l'orloge clk )
	// dont si je fait une affectation avec <= elle aura lieu 1 cicle de clock apres 
	
	
	logic [ 3: 0][ 7:0] memoire [ 2**mem_adr_width]; 

	always_ff( posedge wb_s.clk )
	begin

		if( wb_s.stb && !wb_s.we) begin               // pour une lecture wb_s.we est à zero
			wb_s.dat_sm <= memoire[ wb_s.adr ];
			wb_s.ack <= 1`b1 ;

		end

	end


	always_ff( posedge wb_s.clk )
	begin

		if( wb_s.stb && !wb_s.we) begin               // pour une lecture wb_s.we est à zero
			wb_s.ack <= 1`b1 ;

		end

	end


   
      endmodule
/*

  // Modport for slave rtl
  modport slave (
    output dat_sm,
    output ack ,
    output err ,
    output rty ,
    input  adr ,32 bit
    input  sel ,4bit
    input  stb ,
    input  we,
    input  cyc ,
    input  dat_ms,
    input  cti,
    input  bte,
    input  clk,
    input  rst
  ) ;


*/
