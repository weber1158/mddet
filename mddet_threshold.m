%{
  Binarize mineral dust images using thresholding 
  © 2025 Austin M. Weber

  Read the instructions above each code block and then run the cells
  individually with Ctrl+Enter.
%}

%% 1. Define the image folder
%{
  Create a folder on your computer that contains only mineral dust images.
  The images can be from an optical microscope or an electron microscope, but
  the image type should be compatible with the imread function (.jpg, .jpeg,
  .png, .tif, .tiff).
  
  Change the name of the folder on Line 22 below to match the search path
  where your images are stored. Do not remove the quotation marks and be sure
  to include back slashes!
%}

% Example: p = "C:\Users\JohnDoe\Images\";
p = "C:\Users\JohnDoe\Images\"; % Don't forget the final "\"

% Extract the names of all the images in the folder
files = dir(p);
fileNames = {files.name}';
fileNames(1:2) = [];
fileNames = string(fileNames);

% Define the names of the images that will be generated at the end
outputFileNames = strrep(fileNames,'.jpeg',''); % Replace '.jpeg' with the correct file type
extension = "_5X_Binarized.png";

%% 2. Loop through the images in the folder
%{
  This code block will iterate through the images one-by-one and binarize
  them.
  
  User interaction will be required. For instance, on each loop, a new image
  in the folder will be displayed. You will need to draw a circle over the
  area of the image where the dust is located by simply clicking and draging
  your mouse across the image. We assume that your images were collected by
  photographing the sample through the eye lens of an optical microscope,
  which is why a circle is used. If the dust in your images is not in a
  circular area, replace the drawcircle function on Line 62 with drawrectangle.
  
  Next, the ImageViewer app will open and you will need to set the color
  threshold for each image. Threshold the image using the interactive
  histogram so that the min and max values are approximately 126 and 134,
  respectively, or until the particles are properly isolated as black areas.
  Export the resulting image to the workspace as 'img_threshold'
%}

for i = length(fileNames)
  % Read the image
  img = imread(p+fileNames(i));
  img = im2gray(img);

  % Draw region of interest to create a binary mask
  figure(1)
  imshow(img)
  roi = drawcircle();
  bwMask = createMask(roi);

  % Use mask to edit grayscale image
  img(~bwMask) = NaN;
  img = histeq(img); % Equalize contrast
  figure(2)
  imshow(img)

  % Manually threshold the image using the interactive histogram
  % and export to workspace as 'img_threshold'
  imageViewer(img);

  % Create a custom UI to pause the loop
  hFig = figure('Name', 'Resume Loop', 'NumberTitle', 'off',...
    'Position', [100, 100, 300, 100]);
  uicontrol('Style', 'text', 'Position', [50, 50, 200, 30],...
    'String', 'Close this window to continue');
  uiwait(hFig); % Wait for the custom UI to be closed

  % Binarize the image
  img_threshold = ~(img_threshold > 178 & img_threshold <= 255);

  % Clear pixels along the border
  img_threshold = imclearborder(img_threshold);

  % Fill any holes
  img_threshold = imfill(img_threshold,'holes');

  % Export the image
  outputFileName = outputFileNames(i) + extension;
  imwrite(img_threshold,outputFileName)

  % Print statement when loop is finished
  if i == length(fileNames)
    close all % Figures
    msgbox('Batch processing finished!')
  end
end