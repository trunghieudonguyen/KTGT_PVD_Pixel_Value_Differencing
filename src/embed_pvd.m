function stego = embed_pvd(cover, secret)
cover = uint8(cover);
stego = cover;

ranges = [
     0   7;
     8  15;
    16  31;
    32  63;
    64 127
];

bytes = unicode2native(secret,'UTF-8');
payload_bits = reshape(dec2bin(bytes,8).'-'0',1,[]);
bit_len = length(payload_bits);

% HEADER: [bit_len (16 bit)]
header = dec2bin(bit_len,16)-'0';

bits = [header payload_bits];
idx = 1;

[h,w] = size(stego);

for i = 1:2:h
    for j = 1:2:w-1

        if idx > length(bits)
            return;
        end

        p1 = double(stego(i,j));
        p2 = double(stego(i,j+1));
        d  = abs(p1 - p2);
        m  = floor((p1 + p2)/2);

        for r = 1:size(ranges,1)
            L = ranges(r,1); U = ranges(r,2);
            if d>=L && d<=U, break; end
        end

        t = floor(log2(U - L + 1));

        % ❗ CẮT T CHO BLOCK CUỐI
        if idx + t - 1 > length(bits)
            t = length(bits) - idx + 1;
        end

        b = bits(idx:idx+t-1);
        d_new = L + bin2dec(char(b+'0'));

        if p1 >= p2
            p1n = m + ceil(d_new/2);
            p2n = m - floor(d_new/2);
        else
            p2n = m + ceil(d_new/2);
            p1n = m - floor(d_new/2);
        end

        if p1n<0||p1n>255||p2n<0||p2n>255
            continue;
        end

        stego(i,j)   = uint8(p1n);
        stego(i,j+1) = uint8(p2n);
        idx = idx + t;
    end
end
end
