function secret = extract_pvd(stego)

stego = uint8(stego);

ranges = [
     0   7;
     8  15;
    16  31;
    32  63;
    64 127
];

bits = [];
[h,w] = size(stego);

bit_len = -1;
need_bits = inf;

for i = 1:h
    for j = 1:2:w-1

        p1 = double(stego(i,j));
        p2 = double(stego(i,j+1));
        d = abs(p1-p2);

        for k = 1:size(ranges,1)
            if d >= ranges(k,1) && d <= ranges(k,2)
                L = ranges(k,1);
                U = ranges(k,2);
                break;
            end
        end

        t = floor(log2(U-L+1));
        bits = [bits dec2bin(d-L,t)-'0'];

        if bit_len < 0 && length(bits) >= 16
            bit_len = bin2dec(char(bits(1:16)+'0'));
            need_bits = 16 + bit_len;
        end

        if length(bits) >= need_bits
            payload = bits(17:16+bit_len);
            bytes = uint8(bin2dec(reshape(char(payload+'0'),8,[]).'));
            secret = native2unicode(bytes,'UTF-8');
            secret = secret(:).';
            return;
        end
    end
end
end
