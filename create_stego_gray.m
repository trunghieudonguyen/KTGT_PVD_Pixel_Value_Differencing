clc; clear; close all;

root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));


img_rgb  = imread('modi.png');      % Ảnh màu RGB
img_rgb  = im2uint8(img_rgb);
img_gray = rgb2gray(img_rgb);           % Ảnh mức xám


fid = fopen(fullfile(root,'secret_gray.txt'),'r','n','UTF-8');
secret = fread(fid,'*char').';
fclose(fid);

fprintf('Độ dài thông điệp: %d ký tự\n', length(secret));


[stego_gray, total_bits] = embed_pvd(img_gray, secret);

imwrite(stego_gray, ...
    fullfile(root,'images','modi_stego_gray.png'));


mse_value  = immse(img_gray, stego_gray);
psnr_value = 10 * log10(255^2 / mse_value);
bpp_value  = total_bits / numel(img_gray);

fprintf('Tổng số bit giấu: %d bit\n', total_bits);
fprintf('Dung lượng giấu tin: %.4f bpp\n', bpp_value);
fprintf('PSNR: %.2f dB\n', psnr_value);


results_dir = fullfile(root,'results');
if ~exist(results_dir,'dir')
    mkdir(results_dir);
end


fig_compare = figure('Name','So sánh Cover - Stego (Grayscale)', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.2 0.25 0.5 0.45]);

subplot(1,2,1);
imshow(img_gray);
title('Ảnh gốc (Grayscale Cover Image)', ...
      'FontSize',14,'FontWeight','bold');

subplot(1,2,2);
imshow(stego_gray);
title('Ảnh stego (Grayscale Stego Image)', ...
      'FontSize',14,'FontWeight','bold');

exportgraphics(fig_compare, ...
    fullfile(results_dir,'compare_cover_stego_gray.png'), ...
    'Resolution',300);


diff_img = imabsdiff(img_gray, stego_gray);

fig_diff = figure('Name','Ảnh sai khác (Grayscale)', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.3 0.2 0.35 0.55]);

imshow(diff_img * 20, []);
title('Ảnh sai khác |Cover − Stego| (phóng đại ×20)', ...
      'FontSize',14,'FontWeight','bold');

exportgraphics(fig_diff, ...
    fullfile(results_dir,'difference_cover_stego_gray.png'), ...
    'Resolution',300);


fig_hist = figure('Name','Histogram ảnh mức xám', ...
       'NumberTitle','off', ...
       'Units','normalized', ...
       'Position',[0.2 0.25 0.6 0.45]);

subplot(1,2,1);
imhist(img_gray);
title('Histogram ảnh gốc (Grayscale)', ...
      'FontSize',12,'FontWeight','bold');

subplot(1,2,2);
imhist(stego_gray);
title('Histogram ảnh stego (Grayscale)', ...
      'FontSize',12,'FontWeight','bold');

exportgraphics(fig_hist, ...
    fullfile(results_dir,'histogram_PVD_gray.png'), ...
    'Resolution',300);

disp('Hoàn thành minh họa và đánh giá thuật toán PVD trên ảnh mức xám');
