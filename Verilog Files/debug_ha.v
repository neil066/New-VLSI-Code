module debug_ha(
    input a, b,
    output ha_carry, ha_sum
);

    ha HA1(a, b, ha_carry, ha_sum);

endmodule
