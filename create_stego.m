clc; clear; close all;

root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

img = imread('Shivanya.png');      % Anh mau RGB
img = im2uint8(img);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

fid = fopen(fullfile(root,'secret.txt'),'r','n','UTF-8');
secret = fread(fid,'*char').';
fclose(fid);

fprintf('Do dai thong diep: %d ky tu\n', length(secret));

[B_stego, total_bits] = embed_pvd(B, secret);

stego = cat(3, R, G, B_stego);

imwrite(stego, fullfile(root,'images','Shivanya_stego.png'));

mse_value  = immse(B, B_stego);
psnr_value = 10 * log10(255^2 / mse_value);
bpp_value  = total_bits / numel(B);

fprintf('Tong so bit giau: %d bit\n', total_bits);
fprintf('Dung luong giấu tin: %.4f bpp\n', bpp_value);
fprintf('PSNR: %.2f dB\n', psnr_value);

fig_compare = figure('Name','So sanh Cover - Stego - Difference', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.15 0.05 0.45 0.85]);

subplot(3,1,1);
imshow(img);
title('Ảnh gốc (Cover Image)', ...
      'FontSize',14,'FontWeight','bold');

subplot(3,1,2);
imshow(stego);
title('Ảnh stego (Stego Image)', ...
      'FontSize',14,'FontWeight','bold');

diff_img = imabsdiff(img, stego);

subplot(3,1,3);
imshow(diff_img * 20, []);   % Phóng đại sai khác
title('Ảnh sai khác |Cover − Stego| (phóng đại x20)', ...
      'FontSize',14,'FontWeight','bold');

figure('Name','Histogram kenh B', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.15 0.2 0.6 0.45]);

results_dir = fullfile(root,'results');
if ~exist(results_dir,'dir')
    mkdir(results_dir);
end

exportgraphics(fig_compare, ...
    fullfile(results_dir,'compare_cover_stego_diff.png'), ...
    'Resolution',300);

subplot(1,2,1);
imhist(B);
title('Histogram ảnh gốc (kênh B)', ...
      'FontSize',12,'FontWeight','bold');

subplot(1,2,2);
imhist(B_stego);
title('Histogram ảnh stego (kênh B)', ...
      'FontSize',12,'FontWeight','bold');
% Lưu kết quả
results_dir = fullfile(root,'results');
if ~exist(results_dir,'dir')
    mkdir(results_dir);
end

exportgraphics(gcf, ...
    fullfile(results_dir,'histogram_PVD.png'), ...
    'Resolution',300);

disp('Hoàn thành minh họa và đánh giá thuật toán PVD');
