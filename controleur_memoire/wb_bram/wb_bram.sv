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


	logic [ 3: 0][ 7:0] memoire [0: ( (1<<mem_adr_width+10) -1) ]; // nous avons 2^mem_adr.. Mots et chaque mot vaut 4 octects  et 1 octet vaut 8 bits

	//always_comb
	logic read ,write;

	always_ff @( posedge wb_s.clk )  //or negedge wb_s.rst
	begin


// geron l'ecriture

		if( wb_s.stb ==1 && wb_s.we ==1 ) begin

			if( write == 1  ) begin 
				write = 0 ;
				wb_s.ack = 1'b0 ;
			end 
			else begin 
				write = 1 ;
				wb_s.ack = 1'b1 ;
			end
		end
		else if (wb_s.stb ==0)begin
			write = 0 ;
			read = 0 ;
			wb_s.ack = 1'b0 ;
		end






		// si nous sommes en mode écriture

		if( write ==1 ) begin               // pour une ecriture wb_s.we est à un  mem[(wb_s.adr-offset)/4][0] <= wb_s.dat_ms[7:0];

			if( wb_s.sel[0] == 1 ) begin
				memoire[ (wb_s.adr >>2)  ][ 0 ] = wb_s.dat_ms[7:0] ;
			end

			if( wb_s.sel[1] == 1 ) begin
				memoire[ (wb_s.adr >>2) ][ 1 ] = wb_s.dat_ms[15:8] ;
			end

			if( wb_s.sel[2] == 1 ) begin
				memoire[ (wb_s.adr >>2) ][ 2 ] = wb_s.dat_ms[23:16] ;
			end

			if( wb_s.sel[3] == 1 ) begin
				memoire[ (wb_s.adr >>2) ][ 3 ] = wb_s.dat_ms[31:24] ;
			end
		end


		// si nous sommes en mode lecture

		else if( wb_s.stb ==1 && wb_s.we ==0 )begin

			// @(wb_s.dat_ms) begin

			if( wb_s.sel[0] == 1 ) begin
				wb_s.dat_sm[7:0] <= memoire[ (wb_s.adr >>2) ][ 0 ]  ;
			end

			if( wb_s.sel[1] == 1 ) begin
				wb_s.dat_sm[15:8] <= memoire[ (wb_s.adr >>2) ][ 1 ]  ;
			end

			if( wb_s.sel[2] == 1 ) begin
				wb_s.dat_sm[23:16] <= memoire[ (wb_s.adr >>2) ][ 2 ]  ;
			end

			if( wb_s.sel[3] == 1 ) begin
				wb_s.dat_sm[31:24] <= memoire[ (wb_s.adr >>2) ][ 3 ]  ;
			end
			wb_s.ack <= 1'b1 ;
			if(wb_s.ack == 1) begin
				wb_s.ack <= 1'b0 ;
			end
			//end
			//  QUAND EST-CE QUE wb_s.ack VA REDEVENIR 1 ?
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

