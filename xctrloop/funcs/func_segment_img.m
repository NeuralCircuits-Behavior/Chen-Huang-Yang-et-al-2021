function imgs = func_segment_img(img,re16,re40,olp40)
if nargin == 1
    re16 = 0.75576; % um per p
    re40 = 0.27361;
    olp40 = 0.1;
end
olp16 = 1 - 3 * ( 1 - olp40) * re40 / re16;

z0 = round(re40 *1200 / re16); % 1200 40x 
z1 = round((0.5 * re40 + (olp40 - 1) * re40 + 0.5 * re16) * 1200 / re16);
z2 = round(olp40 * re40 *1200 / re16); % overlap

%{
    0 1 2
    3 4 5
    6 7 8
%}
img1 = img(1:z1,1:z1);
img2 = img(1:z1,z1-z2:z1-z2+z0);
img3 = img(1:z1,end-z1:end);

img4 = img(z1-z2:z1-z2+z0,1:z1);
img5 = img(z1-z2:z1-z2+z0,z1-z2:z1-z2+z0);
img6 = img(z1-z2:z1-z2+z0,end-z1:end);

img7 = img(end-z1:end,1:z1);
img8 = img(end-z1:end,z1-z2:z1-z2+z0);
img9 = img(end-z1:end,end-z1:end);
imgs = {img1,img2,img3,img4,img5,img6,img7,img8,img9};
end