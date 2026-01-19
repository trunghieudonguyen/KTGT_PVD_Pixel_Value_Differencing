clc; clear;

root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

stego_gray = imread('images/modi_stego_gray.png');

% Đảm bảo ảnh là uint8
stego_gray = im2uint8(stego_gray);

extracted = extract_pvd(stego_gray);

fid = fopen(fullfile(root,'extracted_gray.txt'),'w','n','UTF-8');
fwrite(fid, extracted, 'char');
fclose(fid);

disp('Đã trích xuất thông điệp');

orig = fileread(fullfile(root,'secret_gray.txt'));

if isequal(orig, extracted)
    disp('Thông điệp trích xuất CHÍNH XÁC');
else
    disp('Thông điệp KHÔNG khớp');
end
