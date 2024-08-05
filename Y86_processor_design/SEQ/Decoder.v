module Decoder (
    input S0,
    input S1,
    output D0,
    output D1,
    output D2,
    output D3
);
    and(D0,~S0,~S1);
    and(D1,~S0,S1);
    and(D2,S0,~S1);
    and(D3,S0,S1);
endmodule