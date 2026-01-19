clc; clear; close all;

root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

% Đọc ảnh RGB
img = imread('Shivanya.png');
img = im2uint8(img);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% Đọc thông điệp bí mật
fid = fopen(fullfile(root,'secret_rgb.txt'),'r','n','UTF-8');
secret = fread(fid,'*char').';
fclose(fid);

fprintf('Độ dài thông điệp: %d ký tự\n', length(secret));

% Giấu tin bằng PVD vào kênh B
[B_stego, total_bits] = embed_pvd(B, secret);

stego = cat(3, R, G, B_stego);
% Lưu ảnh stego
imwrite(stego, fullfile(root,'images','Shivanya_stego.png'));

% Đánh giá chất lượng
mse_value  = immse(B, B_stego);
psnr_value = 10 * log10(255^2 / mse_value);
bpp_value  = total_bits / numel(B);

fprintf('Tổng số bit giấu: %d bit\n', total_bits);
fprintf('Dung lượng giấu tin: %.4f bpp\n', bpp_value);
fprintf('PSNR: %.2f dB\n', psnr_value);

% Tạo thư mục results
results_dir = fullfile(root,'results');
if ~exist(results_dir,'dir')
    mkdir(results_dir);
end


fig_compare = figure('Name','So sánh Cover - Stego', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.15 0.2 0.5 0.5]);

subplot(1,2,1);
imshow(img);
title('Ảnh gốc (Cover Image)', ...
      'FontSize',14,'FontWeight','bold');

subplot(1,2,2);
imshow(stego);
title('Ảnh stego (Stego Image)', ...
      'FontSize',14,'FontWeight','bold');

exportgraphics(fig_compare, ...
    fullfile(results_dir,'compare_cover_stego.png'), ...
    'Resolution',300);


diff_img = imabsdiff(img, stego);

fig_diff = figure('Name','Ảnh sai khác', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.25 0.15 0.4 0.6]);

imshow(diff_img * 20, []);   % Phóng đại sai khác
title('Ảnh sai khác |Cover − Stego| (phóng đại ×20)', ...
      'FontSize',14,'FontWeight','bold');

exportgraphics(fig_diff, ...
    fullfile(results_dir,'difference_cover_stego.png'), ...
    'Resolution',300);


fig_hist = figure('Name','Histogram kênh B', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.15 0.2 0.6 0.45]);

subplot(1,2,1);
imhist(B);
title('Histogram ảnh gốc (kênh B)', ...
      'FontSize',12,'FontWeight','bold');

subplot(1,2,2);
imhist(B_stego);
title('Histogram ảnh stego (kênh B)', ...
      'FontSize',12,'FontWeight','bold');

exportgraphics(fig_hist, ...
    fullfile(results_dir,'histogram_PVD.png'), ...
    'Resolution',300);

disp('Hoàn thành minh họa và đánh giá thuật toán PVD');
