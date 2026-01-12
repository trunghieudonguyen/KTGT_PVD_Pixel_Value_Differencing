clc; clear;

% ADDPATH src & images 
root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

% ĐỌC ẢNH STEGO RGB
stego = imread('images/Shivanya stego.png');

% LẤY ĐÚNG KÊNH B
B = stego(:,:,3);

% TRÍCH XUẤT
extracted = extract_pvd(B);

% GHI RA FILE TXT (UTF-8) 
fid = fopen(fullfile(root,'extracted.txt'),'w','n','UTF-8');
assert(fid~=-1,'Không ghi được extracted.txt');
fwrite(fid, extracted, 'char');
fclose(fid);

disp('Đã trích xuất thông điệp ra file extracted.txt');
