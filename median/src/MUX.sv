

module MUX #(parameter N = 7) (
input [N:0] DI,
input  DSI, CLK ,
input [N:0] VAL,
output logic [N:0] OUT
);


always_ff @ ( posedge CLK) begin
	if(DSI==1) begin
		OUT <= DI ;
	end
	else begin
		OUT <= VAL ;
	end
end

endmodule
