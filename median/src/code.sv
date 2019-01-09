module MED #( parameter SIZE = 8, NBR = 9 )
            ( input CLK,
              input  logic DSI, BYP,              
	      input  logic [SIZE-1:0] DI,
              output logic [SIZE-1:0] DO );

  logic [SIZE-1:0] R [0:NBR-1];
  logic vmin, vmax; 

  

  //instantiation du MCE
  MCE I_MCE (.A(R[NBR-1]), .B(R[NBR-2]), .MAX(vmax), .MIN(vmin)); 
  
  //Reception des 9 pixels
  always_ff @(posedge CLK)
  begin: loop
	int i;
	if (DSI) R[0] <= DI;
 	else 	 R[0] <= vmin;
       
  	for (i = 0; i < NBR-2; i++)
		R[i+1] <= R[i];

        if (BYP) R[NBR-1] <= R[NBR-2];
 	else 	 R[NBR-1] <= vmax;
  end
  
  assign DO = R[NBR-1];

endmodule


*************************

