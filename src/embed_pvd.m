function stego = embed_pvd(cover, secret)
% PVD parity-based (1 bit / pair) – UTF-8 SAFE

cover = uint8(cover);
stego = cover;

% UTF-8 bytes
bytes = unicode2native(secret,'UTF-8');
len   = length(bytes);

bits = [dec2bin(len,32)-'0', reshape(dec2bin(bytes,8).'-'0',1,[])];
idx = 1;

for i = 1:2:size(cover,1)
    for j = 1:2:size(cover,2)-1

        if idx > length(bits)
            return;
        end

        p1 = double(stego(i,j));
        p2 = double(stego(i,j+1));
        d  = abs(p1 - p2);

        bit = bits(idx);

        % nếu parity chưa khớp → điều chỉnh nhẹ 1 pixel
        if mod(d,2) ~= bit
            if p1 < 255
                p1 = p1 + 1;
            else
                p1 = p1 - 1;
            end
        end

        stego(i,j)   = uint8(p1);
        stego(i,j+1) = uint8(p2);

        idx = idx + 1;
    end
end
end
