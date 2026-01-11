function secret = extract_pvd(stego)
stego = uint8(stego);
bits = [];

for i = 1:2:size(stego,1)
    for j = 1:2:size(stego,2)-1
        d = abs(double(stego(i,j)) - double(stego(i,j+1)));
        bits(end+1) = mod(d,2); %#ok<AGROW>
    end
end

% Đọc độ dài
msg_len = bin2dec(char(bits(1:32) + '0'));

msg_bits = bits(33:32 + msg_len*8);

bytes = uint8( ...
    bin2dec(reshape(char(msg_bits + '0'),8,[]).') ...
);

secret = native2unicode(bytes,'UTF-8');
secret = secret(:).';   % ⭐ FIX HIỂN THỊ DỌC → NGANG
end
