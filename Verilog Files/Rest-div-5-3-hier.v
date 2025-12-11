module restdiv(
    input [4:0] X, 
    input [2:0] D, 
    output [2:0] Q, 
    output [2:0] R
);

wire [2:0] sel;
wire [2:0] subout2;
wire [2:0] subout1;
wire [2:0] subout0;
wire [2:0] bout2;
wire [3:0] bout1;
wire [3:0] bout0;
wire [2:0] PR2;
wire [2:0] PR1;

//Layer 2
HalfSubtractor HS20 (.a(X[2]), .b(D[0]), .diff(subout2[0]), .bout(bout2[0]));
Mux M20 (.a(X[2]), .b(subout2[0]), .sel(sel[2]), .out(PR2[0]));

FullSubtractor FS21 (.a(X[3]), .b(D[1]), .bin(bout2[0]), .diff(subout2[1]), .bout(bout2[1]));
Mux M21 (.a(X[3]), .b(subout2[1]), .sel(sel[2]), .out(PR2[1]));

FullSubtractor FS22 (.a(X[4]), .b(D[2]), .bin(bout2[1]), .diff(subout2[2]), .bout(bout2[2]));
Mux M22 (.a(X[4]), .b(subout2[2]), .sel(sel[2]), .out(PR2[2]));

assign Q[2] = !bout2[2];
assign sel[2] = Q[2];

//Layer 1
HalfSubtractor HS10 (.a(X[1]), .b(D[0]), .diff(subout1[0]), .bout(bout1[0]));
Mux M10 (.a(X[1]), .b(subout1[0]), .sel(sel[1]), .out(PR1[0]));

FullSubtractor FS11 (.a(X[PR2[0]]), .b(D[1]), .bin(bout1[0]), .diff(subout1[1]), .bout(bout1[1]));
Mux M11 (.a(PR2[0]), .b(subout1[1]), .sel(sel[1]), .out(PR1[1]));

FullSubtractor FS12 (.a(PR2[1]), .b(D[2]), .bin(bout1[1]), .diff(subout1[2]), .bout(bout1[2]));
Mux M12 (.a(PR2[1]), .b(subout1[2]), .sel(sel[1]), .out(PR1[2]));

assign bout1[3] = !PR2[2] & bout1[2];
assign Q[1] = !bout1[3];
assign sel[1] = Q[1];

//Layer 0

HalfSubtractor HS00 (.a(X[0]), .b(D[0]), .diff(subout0[0]), .bout(bout0[0]));
Mux M00 (.a(X[0]), .b(subout0[0]), .sel(sel[0]), .out(R[0]));

FullSubtractor FS01 (.a(X[PR1[0]]), .b(D[1]), .bin(bout0[0]), .diff(subout0[1]), .bout(bout0[1]));
Mux M01 (.a(PR1[0]), .b(subout0[1]), .sel(sel[0]), .out(R[1]));

FullSubtractor FS02 (.a(PR1[1]), .b(D[2]), .bin(bout0[1]), .diff(subout0[2]), .bout(bout0[2]));
Mux M02 (.a(PR1[1]), .b(subout0[2]), .sel(sel[0]), .out(R[2]));

assign bout0[3] = !PR1[2] & bout0[2];
assign Q[0] = !bout0[3];
assign sel[0] = Q[0];

endmodule

module HalfSubtractor (
    input a,
    input b,
    output diff,
    output bout
);
    assign diff = a ^ b;  // Difference
    assign bout = ~a & b;  // Borrow out
endmodule

module FullSubtractor (
    input a,
    input b,
    input bin,
    output diff,
    output bout
);
    assign diff = a ^ b ^ bin;  // Difference
    assign bout = (~a & b) | ((~a | b) & bin);  // Borrow out
endmodule

module Mux (
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? b : a;  // 2-to-1 Multiplexer
endmodule
