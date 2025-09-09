// traffic light controller testbench file

module traffic_tb;
  reg clk,rst;
  wire [2:0] signal1_light;
  wire [2:0] signal2_light;
  
  traffic DUT(.clk(clk),.rst(rst),.signal1_light(signal1_light),.signal2_light(signal2_light));
  
  initial
    begin
      clk=1;
      forever #5 clk=~clk; // toggle clock every 5 ns (total time period is 5*2=10ns)
    end
  initial
    begin
      $dumpfile("traffic.vcd");
      $dumpvars(0,traffic_tb);
    end
  initial
    begin
      $display("Time \tSignal1 \tSignal2");
      rst=1; #20;
      rst=0;
      #(500);
      $finish;
    end
   always @(signal1_light or signal2_light) begin
     $display("%0t \t%s \t\t%s", $time,
      (signal1_light==3'b001) ?"GREEN"  :
      (signal1_light==3'b010) ?"YELLOW" :"RED",
      (signal2_light==3'b001) ?"GREEN"  :
      (signal2_light==3'b010) ?"YELLOW" :"RED");
    end
endmodule
  
  
