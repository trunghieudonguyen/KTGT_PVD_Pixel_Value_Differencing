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

for i = 1:2:h
    for j = 1:2:w-1

        if length(bits) >= need_bits
            break;
        end

        p1 = double(stego(i,j));
        p2 = double(stego(i,j+1));
        d  = abs(p1 - p2);

        for r = 1:size(ranges,1)
            L=ranges(r,1); U=ranges(r,2);
            if d>=L && d<=U, break; end
        end

        t = floor(log2(U - L + 1));
        if length(bits) + t > need_bits
            t = need_bits - length(bits);
        end

        bits = [bits dec2bin(d - L, t)-'0'];

        if bit_len < 0 && length(bits) >= 16
            bit_len = bin2dec(char(bits(1:16)+'0'));
            need_bits = 16 + bit_len;
        end
    end
end

payload = bits(17:16+bit_len);
bytes = uint8(bin2dec(reshape(char(payload+'0'),8,[]).'));
secret = native2unicode(bytes,'UTF-8');
secret = secret(:).';
end
