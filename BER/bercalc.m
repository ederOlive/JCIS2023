function ber = bercalc(vector_tx, vector_rx_trimmed)
  xorvector = zeros(1, length(vector_tx));
  bitvector = zeros(1, 8);
  
  for i = 1:length(vector_tx)
    xorvector(i) = bitxor(vector_tx(i), vector_rx_trimmed(i)); %  calculates different bits of each byte
    bitvector = bitget(xorvector(i), 8:-1:1); % explicits the bits of a byte in a vector
    xorvector(i) = sum(bitvector); % sums the number of bit errors of each byte
  endfor

  num_biterror = sum(xorvector);
  num_bittx = 8*length(vector_tx);
  ber = num_biterror/num_bittx;
  
endfunction
