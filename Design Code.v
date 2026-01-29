module traffic_light (
  input wire clk,
  input wire reset,
  output reg A_red,
  output reg A_yellow,
  output reg A_green,
  output reg B_red,
  output reg B_yellow,
  output reg B_green,
);
  
    // State encoding
    parameter S0 = 2'b00;  // A Green,  B Red
    parameter S1 = 2'b01;  // A Yellow, B Red
    parameter S2 = 2'b10;  // A Red,    B Green
    parameter S3 = 2'b11;  // A Red,    B Yellow

    reg [1:0] state, next_state;
    reg [3:0] count;

    // State and counter update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            count <= 0;
        end else begin
            if (state != next_state) begin
                state <= next_state;
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            S0: if (count == 10) next_state = S1;
            S1: if (count == 3)  next_state = S2;
            S2: if (count == 10) next_state = S3;
            S3: if (count == 3)  next_state = S0;
        endcase
    end

    // Output logic (Moore FSM)
    always @(*) begin
        A_red = 0; A_yellow = 0; A_green = 0;
        B_red = 0; B_yellow = 0; B_green = 0;

        case (state)
            S0: begin
                A_green = 1;
                B_red   = 1;
            end
            S1: begin
                A_yellow = 1;
                B_red    = 1;
            end
            S2: begin
                A_red   = 1;
                B_green = 1;
            end
            S3: begin
                A_red    = 1;
                B_yellow = 1;
            end
        endcase
    end

endmodule
