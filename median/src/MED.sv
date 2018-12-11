module MED #(parameter N = 7,parameter SIZE = 9) (
input [N:0] DI,
input  DSI,
input  BYP,
input  CLK,
output logic [N:0] DO
);



logic [N:0] R [0 : SIZE -1] ;
logic [N:0] vmin , vmax;
integer i ;

	MUX MUX_1( .DI(DI), .DSI(DSI), .CLK(CLK), .VAL(vmin), .OUT( R[0]) ) ;

	MUX MUX_2( .DI(R[SIZE-2]), .DSI(BYP), .CLK(CLK), .VAL(vmax), .OUT( R[SIZE-1]) ) ;

	MCE I_MCE( .A(R[SIZE-1]), .B(R[SIZE-2]), .MAX(vmax), .MIN(vmin)  ) ;

	always_ff @ (posedge CLK) begin

		for(i=0 ;i < SIZE-2 ; i++) begin
			R[i+1] <= R[i];
		end
	end

	assign DO = R[SIZE-1] ;

endmodule
