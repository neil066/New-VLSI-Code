// Test file demonstrating all supported gate types
module test_all_gates(
    input a,
    input b,
    input c,
    input d,
    input s0,
    input s1,
    output and_out,
    output or_out,
    output not_out,
    output nand_out,
    output nor_out,
    output xor_out,
    output xnor_out,
    output ha_sum,
    output ha_carry,
    output fa_sum,
    output fa_carry,
    output hs_diff,
    output hs_borrow,
    output fs_diff,
    output fs_borrow,
    output mux2_out,
    output mux4_out
);

    // Basic gates
    and AND1(a, b, and_out);
    or OR1(a, b, or_out);
    not NOT1(a, not_out);
    nand NAND1(a, b, nand_out);
    nor NOR1(a, b, nor_out);
    xor XOR1(a, b, xor_out);
    xnor XNOR1(a, b, xnor_out);
    
    // Arithmetic gates
    ha HA1(a, b, ha_carry, ha_sum);
    fa FA1(a, b, c, fa_carry, fa_sum);
    
    // Subtraction gates
    hs HS1(a, b, hs_borrow, hs_diff);
    fs FS1(a, b, c, fs_borrow, fs_diff);
    
    // Multiplexers
    mux2 MUX1(a, b, s0, mux2_out);
    mux4 MUX2(a, b, c, d, s1, s0, mux4_out);

endmodule
