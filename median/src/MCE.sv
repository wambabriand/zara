

module MCE #(parameter N = 7)(
 input [N:0] A , B ,
 output logic [N:0] MAX , MIN
) ;


always_comb

  begin
    if (A > B)
      begin
           MAX = A;
           MIN = B;
      end
    else
      begin
         MAX = B;
         MIN = A;
      end
  end

endmodule
