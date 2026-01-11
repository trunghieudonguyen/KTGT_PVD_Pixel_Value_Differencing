clc; clear;

% ===== ADDPATH src & images =====
root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

% ===== ĐỌC ẢNH RGB GỐC =====
img = imread('Shivanya goc.jpg');   % images đã được addpath

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% ===== THÔNG ĐIỆP =====
secret = 'Chào con dâu Shivanya yêu dấu';

% ===== GIẤU TIN =====
B_stego = embed_pvd(B, secret);

% ===== GHÉP RGB =====
stego = cat(3,R,G,B_stego);

% ===== LƯU ẢNH =====
imwrite(stego,'images/Shivanya stego.png');

disp('✔ Đã tạo ảnh stego');
