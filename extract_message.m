clc; clear;

% ===== ADDPATH CHUNG src & images =====
root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

% ===== ĐỌC ẢNH STEGO RGB =====
stego = imread('Shivanya stego.png');   % images đã addpath

% ===== LẤY ĐÚNG KÊNH ĐÃ GIẤU (B) =====
B = stego(:,:,3);

% ===== TRÍCH XUẤT =====
extracted = extract_pvd(B);

disp('Chuỗi trích xuất:');
disp(extracted);
