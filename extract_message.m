clc; clear;

root = fileparts(mfilename('fullpath'));
addpath(fullfile(root,'src'));
addpath(fullfile(root,'images'));

stego = imread('images/Shivanya_stego.png');
B = stego(:,:,3);

extracted = extract_pvd(B);

% Lưu
fid = fopen(fullfile(root,'extracted.txt'),'w','n','UTF-8');
fwrite(fid, extracted, 'char');
fclose(fid);

disp('Đã trích xuất thông điệp');

% So sánh thông điệp trích xuất với file ban đầu
orig = fileread(fullfile(root,'secret.txt'));
if isequal(orig, extracted)
    disp('Thông điệp trích xuất CHÍNH XÁC');
else
    disp('Thông điệp KHÔNG khớp');
end
