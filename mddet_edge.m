%
%   Read the comments (denoted with % markers) for details and instructions.
%

%% Get names of all the images
% Make sure only images are in the folder and that the images have a valid file extension
% such as .JPEG, .PNG, or .TIF
p = "C:\Users\JohnDoe\Images\"; % Replace with the path to your images
files = dir(p);
fileNames = {file.name}';
fileNames(1:2) = [];
fileNames = string(fileNames);

%% Define  the names of the images that will be output
outputFileNames = strrep (fileNames,’.JPEG’ ,’ ’); % Replace .JPEG with the original extension
extension = "_Binarized .png";

%% Loop through the images in the folder
for i = 1: length (fileNames)
  % Read image
  img = imread(p+fileNames(i));
  img = im2gray(img);

  % Create a circular mask to remove the areas outside of the filter
  figure (1)
  imshow(img) % Displays the original image
  roi = drawcircle(); % Drag a circle across the area of the filter
  bwMask = createMask(roi);
  img(~bwMask) = NaN;

  % Detect edges
  BW = edge(img,’sobel’,0.04);

  % Perform a closing operation on the binary image and fill any holes
  SE = strel (’disk’ ,2);
  BW2 = imfill (imclose(BW,SE),’holes’);

  % Re−draw circle to remove pixels along the border
  figure(2)
  imshow(BW2)
  roi2 = drawcircle();
  bwMask2 = createMask(roi2);
  BW2(~bwMask2) = false ;

  % Export the image
  outputFileName = outputFileNames(i) + extension ;
  imwrite(BW2,outputFileName);

end % End of image processing loop