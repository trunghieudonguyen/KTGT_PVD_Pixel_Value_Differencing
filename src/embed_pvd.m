function [stego, total_bits] = embed_pvd(cover, secret)

cover = uint8(cover);
stego = cover;
total_bits = 0;

ranges = [
     0   7;
     8  15;
    16  31;
    32  63;
    64 127
];

% Chuyển thông điệp sang bit
bytes = unicode2native(secret,'UTF-8');
payload_bits = reshape(dec2bin(bytes,8).'-'0',1,[]);
bit_len = length(payload_bits);

len_bits = dec2bin(bit_len,16)-'0';
payload_bits = [len_bits payload_bits];

idx = 1;
[h,w] = size(cover);

for i = 1:h
    for j = 1:2:w-1

        if idx > length(payload_bits)
            return;
        end

        p1 = double(cover(i,j));
        p2 = double(cover(i,j+1));
        d = abs(p1-p2);

        for k = 1:size(ranges,1)
            if d >= ranges(k,1) && d <= ranges(k,2)
                L = ranges(k,1);
                U = ranges(k,2);
                break;
            end
        end

        t = floor(log2(U-L+1));
        if idx+t-1 > length(payload_bits)
            t = length(payload_bits)-idx+1;
        end

        bits = payload_bits(idx:idx+t-1);
        b = bin2dec(char(bits+'0'));

        d_new = L + b;
        m = floor((p1+p2)/2);

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
        total_bits = total_bits + t;
    end
end
end
