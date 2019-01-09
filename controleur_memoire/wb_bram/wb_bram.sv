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


	logic [ 3: 0] [ 7:0] memoire [0: 2**mem_adr_width ]; 

	enum logic[2:0] { INIT, WR , RD } state;
	
	//always_comb
	
	always_ff @( posedge wb_s.clk )  
	begin
		
		if(wb_s.rst) begin
			state <= INIT ;
		end
		else begin 
			if(wb_s.we == 1 && wb_s.stb ==1)begin
				state <= WR ;
				//wb_s.ack <= 1'b1 ;
			end 
			else if(wb_s.we == 0 && wb_s.stb ==1) begin
				wb_s.ack <= 1'b1 ;
				state <= RD ;
			end 
			else begin
				wb_s.ack <= 1'b0 ;
				state <= INIT ;
			end 
		end
	end

	always_comb //state == WR && 
	begin 		
		if(wb_s.stb ==0)begin wb_s.ack = 1'b0 ; end

		if( wb_s.stb ==1 && wb_s.we == 1  && wb_s.cyc == 1) begin


			if( wb_s.sel[0] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 0 ] = wb_s.dat_ms[7:0] ;
			end

			if( wb_s.sel[1] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 1 ] = wb_s.dat_ms[15:8] ;
			end

			if( wb_s.sel[2] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 2 ] = wb_s.dat_ms[23:16] ;
			end

			if( wb_s.sel[3] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 3 ] = wb_s.dat_ms[31:24] ;
			end
			wb_s.ack = 1'b1 ;
		end //state == RD &&  
	
		else if(  wb_s.stb ==1 && wb_s.we == 0 && wb_s.cyc == 1 ) begin

			if( wb_s.sel[0] == 1 ) begin
				wb_s.dat_sm[7:0]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 0 ]  ;
			end

			if( wb_s.sel[1] == 1 ) begin
				wb_s.dat_sm[15:8] = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 1 ]  ;
			end

			if( wb_s.sel[2] == 1 ) begin
				wb_s.dat_sm[23:16] = memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 2 ]  ;
			end

			if( wb_s.sel[3] == 1 ) begin
				wb_s.dat_sm[31:24] = memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 3 ]  ;
			end

/*			wb_s.ack <= 1'b1 ;
			if(wb_s.ack == 1) begin
				wb_s.ack <= 1'b0 ;
			end*/
		end
/*		
		else begin 
			wb_s.ack = 1'b0 ;
		end
*/
	end 
/*


		if(wb_s.stb == 0)begin
			read = 0;
			write = 0;
			wb_s.ack = 0;
		end 


		// si je  stb = 1  et we = 1 je pourrais ecrire

		else if( wb_s.stb ==1 && wb_s.we == 1  && wb_s.cyc == 1) begin

			if( write == 1  ) begin  // si j ai ecris sur le bus le cycle passe je n ecris pas pour ce cylce 
				write = 0 ;
				wb_s.ack = 1'b0 ;
			end 
			else begin               // si je n'ai pas ecris sur le bus le cycle le passé j'écris sur le bus ce cycle
				write = 1 ;
				wb_s.ack = 1'b1 ;
			end
		end



*/


		// si je  stb = 1  et we = 0 je pourrais lire		
/*
		else if ( wb_s.stb ==1 && wb_s.we ==0  && wb_s.cyc == 1)begin
			if( read == 1) begin 
				read = 0;
				wb_s.ack = 1'b0 ;
			end
			else begin 

			end
		end


*/



		// si nous sommes en mode écriture
/*
		if( write ==1 ) begin               // pour une ecriture wb_s.we est à un  mem[(wb_s.adr-offset)/4][0] <= wb_s.dat_ms[7:0];

			if( wb_s.sel[0] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 0 ] = wb_s.dat_ms[7:0] ;
			end

			if( wb_s.sel[1] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 1 ] = wb_s.dat_ms[15:8] ;
			end

			if( wb_s.sel[2] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 2 ] = wb_s.dat_ms[23:16] ;
			end

			if( wb_s.sel[3] == 1 ) begin
				memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 3 ] = wb_s.dat_ms[31:24] ;
			end
		end

	end

*//*
	always_ff @( posedge wb_s.clk )  //or negedge wb_s.rst
	begin	// si nous sommes en mode lecture

		 if( wb_s.cyc == 1 &&  wb_s.stb ==1 && wb_s.we ==0 ) begin

			if( wb_s.sel[0] == 1 ) begin
				wb_s.dat_sm[7:0]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 0 ]  ;
			end

			if( wb_s.sel[1] == 1 ) begin
				wb_s.dat_sm[15:8] = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 1 ]  ;
			end

			if( wb_s.sel[2] == 1 ) begin
				wb_s.dat_sm[23:16] = memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 2 ]  ;
			end

			if( wb_s.sel[3] == 1 ) begin
				wb_s.dat_sm[31:24] = memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 3 ]  ;
			end
			wb_s.ack <= 1'b1 ;
			if(wb_s.ack == 1) begin
				wb_s.ack <= 1'b0 ;
			end
		end

	end

*/

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

			case(sel) 
			0001 : memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 0 ] = wb_s.dat_ms[7:0] ;
			0010 : memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 1 ] = wb_s.dat_ms[15:8] ;
			0100 : memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 2 ] = wb_s.dat_ms[23:16] ;
			1000 : memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 3 ] = wb_s.dat_ms[31:23] ;
			0011 : memoire[ wb_s.adr[mem_adr_width+1: 2] ][ 1:0 ] = wb_s.dat_ms[15:0] ;
			1100 : memoire[ wb_s.adr[mem_adr_width+1: 2] ][3:2 ] = wb_s.dat_ms[31:16] ;
			1111 : memoire[ wb_s.adr[mem_adr_width+1: 2] ]      = wb_s.dat_ms[31:0] ;

			endcase


			
			case(sel) 
			0001 : wb_s.dat_sm[7:0]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 0 ]  ;
			0010 : wb_s.dat_sm[15:8]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 1 ]  ;
			0100 : wb_s.dat_sm[23:16]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 2 ]  ;
			1000 : wb_s.dat_sm[31:24]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 3 ]  ;
			0011 : wb_s.dat_sm[15:0]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 1:0 ]  ;
			1100 : wb_s.dat_sm[31:16]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ][ 3:2 ]  ;
			1111 : wb_s.dat_sm[31:0]  = memoire[  wb_s.adr[mem_adr_width+1: 2] ] ;

			endcase



*/

