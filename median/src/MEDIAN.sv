
module MEDIAN #(parameter N=8)
      (input [N-1:0] DI,
       input DSI,
       input nRST,
       input CLK,
       output [N-1:0] DO,
       output logic DSO);


logic BYP;
enum logic [2:0] {INIT0,INIT1,INIT2,S1,S2,S3,S4,S5} state;
logic [3:0] counter,i;

MED I_MED(.DI(DI),.DSI(DSI),.BYP(BYP),.CLK(CLK),.DO(DO));





always_ff @(posedge CLK or negedge nRST)

begin

if(nRST==0) begin
    state<=INIT0;
    BYP<=1'b1;
    DSO<=1'b0;
end

else begin

 case(state)

          INIT0:begin
              DSO<=1'b0;
              if(DSI==1) state<=INIT1;
              counter<=8;
              i<=1;
          end

          INIT1:begin

 	          if(i<counter)
 	            i<=i+1;
            else begin
              state<=INIT2;
              BYP<=1'b0;
 	          end
          end

          INIT2:begin
            state<=S1;
            counter<=8;
            i<=1;
            BYP<=1'b0;
          end

          S1:begin
            if(i<counter) begin
              BYP<=1'b0;i<=i+1;
            end
            else begin
              if(i==9) begin
                state<=S2;
                counter<=7;
                i<=1;
                BYP<=1'b0;
              end
              else begin
                BYP<=1'b1;
                i<=i+1;
              end
            end
          end

          S2:begin
            if(i<counter) begin
              BYP<=1'b0;
              i<=i+1;
            end
            else begin
              if(i==9) begin
                state<=S3;
                counter<=6;
                i<=1;
                BYP<=1'b0;
              end
              else begin
                BYP<=1'b1;
                i<=i+1;
              end
            end
          end

          S3:begin
            if(i<counter) begin
              BYP<=1'b0;
              i<=i+1;
            end
            else begin
              if(i==9) begin
                state<=S4;
                counter<=5;
                i<=1;
                BYP<=1'b0;
              end
              else begin
                BYP<=1'b1;
                i<=i+1;
              end
            end
          end

          S4:begin
            if(i<counter) begin
              BYP<=1'b0;
              i<=i+1;
            end
            else begin
              if(i==9) begin
                state<=S5;
                counter<=4;
                i<=1;
                BYP<=1'b0;
              end
              else begin
                BYP<=1'b1;
                i<=i+1;
              end
            end
          end

          S5:begin
              if(i<counter)
         	      BYP<=1'b0;
              else begin
         	      DSO<=1;
         	      BYP<=1'b1;
         	      state<=INIT0;
              end
              i<=i+1;
          end

 endcase

end

end

endmodule
