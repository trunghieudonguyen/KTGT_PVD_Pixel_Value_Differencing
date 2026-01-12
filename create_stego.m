clc; clear;

% ADDPATH src & images
root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

% ĐỌC ẢNH RGB GỐC 
img = imread('Shivanya.png');   % ảnh nằm trong images/

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% ĐỌC SECRET TỪ FILE TXT (UTF-8)
fid = fopen(fullfile(root,'secret.txt'),'r','n','UTF-8');
assert(fid~=-1,'Không mở được secret.txt');
secret = fread(fid,'*char').';
fclose(fid);

% GIẤU TIN VÀO KÊNH B 
B_stego = embed_pvd(B, secret);

% GHÉP RGB 
stego = cat(3, R, G, B_stego);

% LƯU ẢNH STEGO 
imwrite(stego, fullfile(root,'images','Shivanya stego.png'));

disp('Đã đọc secret từ secret.txt');
disp('Đã tạo ảnh stego: images/Shivanya stego.png');
