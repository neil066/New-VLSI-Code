module Mod7Multiplier (
    input a2, a1, a0, b2, b1, b0,
    output Z2, Z1, Z0
);
    wire P00, P01, P02, P10, P11, P12, P20, P21, P22;
    wire S20, S21, S22, C20, C21, C22;
    wire S10, C10, S11, C11, S12, C12;
    wire t0, t1, t2;
    
    // Generate partial products
    assign P00 = a0 & b0;
    assign P01 = a0 & b1;
    assign P02 = a0 & b2;
    assign P10 = a1 & b0;
    assign P11 = a1 & b1;
    assign P12 = a1 & b2;
    assign P20 = a2 & b0;
    assign P21 = a2 & b1;
    assign P22 = a2 & b2;
    
    FullAdder FA1 (.a(P00), .b(P12), .cin(P21), .s(S20), .cout(C20));
    FullAdder FA2 (.a(P01), .b(P10), .cin(P22), .s(S21), .cout(C21));
    FullAdder FA3 (.a(P02), .b(P11), .cin(P20), .s(S22), .cout(C22));
    
    HalfAdder HA1 (.a(S20), .b(C22), .sum(S10), .carry(C10));
    FullAdder FA4 (.a(C10), .b(C20), .cin(S21), .s(S11), .cout(C11));
    FullAdder FA5 (.a(C11), .b(C21), .cin(S22), .s(S12), .cout(C12));
    
    HalfAdder HA2 (.a(S10), .b(C12), .sum(Z0), .carry(t0));
    HalfAdder HA3 (.a(t0), .b(S11), .sum(Z1), .carry(t1));
    HalfAdder HA4 (.a(t1), .b(S12), .sum(Z2), .carry(t2));
    
endmodule

module HalfAdder (input a, input b, output sum, output carry);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

module FullAdder (input a, input b, input cin, output s, output cout);
    assign s = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

