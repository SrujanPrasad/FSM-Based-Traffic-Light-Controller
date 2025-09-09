// traffic light controller design file
//assuming a clock frequency of 100MHz so time period is 10ns

module traffic(
  input clk,
  input rst,
  output reg [2:0] signal1_light,
  output reg [2:0] signal2_light); // signal1_light is north-south direction road and signal2_light is east-west direction road
  
  parameter S0=2'b00; // signal1_light is green signal2_light is red
  parameter S1=2'b01; // signal1_light is yellow signal2_light is red
  parameter S2=2'b10; // signal1_light is red signal2_light is green
  parameter S3=2'b11; // signal1_light is red signal2_light is yellow
  
  reg [1:0] state,next_state;
  reg [3:0] count;
  
  parameter state1=5; // green light duration of signal1
  parameter state2=2; // yellow light duration of signal1
  parameter state3=5;// green light duration of signal2
  parameter state4=2;//yellow light duration of the signal2
  
  parameter greenlight=3'b001;
  parameter yellowlight=3'b010;
  parameter redlight=3'b100;
  
  wire [3:0] duration;
  assign duration =(state==S0)?state1:(state==S1)?state2:(state==S2)?state3:state4;
  
 
  always @(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          state<=S0;		//intial let it be in S0 state
          count<=1;			//initial count is 1
        end else
          begin
            if(count==duration-1)
              begin
                state<=state+1; //move to the next state
                count<=0;		//and reset the counter
          end else begin
            count<=count+1;		// if reset is zero then increment counter by 1
          end
          end
    end
    
// determining the next state values
  always @(*)
    begin
      case(state)
        S0: begin
          next_state=(count<state1)?S0:S1; 
        end
        S1: begin
          next_state=(count<state2)?S1:S2;
        end
        S2:begin
          next_state=(count<state3)?S2:S3;
        end
        S3: begin
          next_state=(count<state4)?S3:S0;
        end
        default:next_state=S0;
      endcase
    end

// dtermining the lights for the signals on both roads.
  
  always @(*)
    begin
      case(state)
        S0: begin
          signal1_light=greenlight;
          signal2_light=redlight;
        end
        S1: begin
          signal1_light=yellowlight;
          signal2_light=redlight;
        end
        S2:begin
          signal1_light=redlight;
          signal2_light=greenlight;
        end
        S3: begin
          signal1_light=redlight;
          signal2_light=yellowlight;
        end
      endcase
        end
        endmodule
        
        