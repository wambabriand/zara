

module mce (
logic input a ,
logic input b ,
logic input max ,
logic input min ,

)


always_cmb()

  begin
    if(a > b)
      begin
          assign max = a;
          assign min = b;
      end
    else
      begin
        assign max = b;
        assign min = a;
      end


  end

endmodule
