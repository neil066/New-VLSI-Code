// Simple gate example for testing basic functionality

module simple_circuit(a, b, c, y);
    input a, b, c;
    output y;
    
    wire w1, w2;
    
    and and1(w1, a, b);
    or or1(w2, w1, c);
    not not1(y, w2);
endmodule
