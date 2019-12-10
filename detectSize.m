function sizeVal = detectSize(inputImg)
rgb = imread(inputImg);
%segment by colors  L*a*b (luminosity layer 'L*', chromaticity-layer 'a*' ,chromaticity-layer 'b*'
labIm = rgb2lab(rgb);
figure,imshow(labIm);
ab = labIm(:,:,2:3);

ab = im2single(ab);
% use K means clustering to segment the image
nColors = 3;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',10);
figure,imshow(pixel_labels,[]),title('Image Labeled by Cluster Index');

% convert im to binary 
imBw = imbinarize(pixel_labels);

figure, imshow(imBw);





%remove black holes
se = strel('disk',6);
closeIm = imclose(imBw,se); 

figure,imshow(closeIm),title('close im');

se = strel('disk',2);
%remove small white circles
openIm = imopen(closeIm,se);
figure , imshow(openIm);

%remove all obj with  less than p pixels
deleteSmallHole = bwareaopen(openIm,300);
figure , imshow(deleteSmallHole );

   
    


stats = regionprops(deleteSmallHole ,'BoundingBox');
carBox = cat(1,stats.BoundingBox);
disp("car box:" + carBox);



figure , imshow(deleteSmallHole);
hold on
rectangle('Position', [carBox(1), carBox(2),carBox(3), carBox(4)],'EdgeColor','r', 'LineWidth', 3)
hold off
%width is carBox(3), length is carBox(4)

% dont need to convert to meter as it is a ratio
widthLengthRatio = (carBox(4)*cos(pi/6)) / (carBox(3)*sin(pi/6)) ;

 %segment the red-green axis colors of the rgb img
 mask = pixel_labels==2;
 cluster2 = rgb  .* uint8(mask);
 figure,imshow(cluster2),title('Objects in Cluster 2');
   
 
 colVal = 'unknown';
 %average color and compare the channels
 meanRGB = mean(reshape(cluster2, [], 3), 1);
 if(meanRGB(1) > meanRGB(2) && meanRGB(1) > meanRGB(3))
    %if the red > green and red > blue      
     disp("This is red");
     colVal = "red";
 %if the blue >red and blue > green 
 elseif(meanRGB(3) > meanRGB(1) && meanRGB(3) > meanRGB(2))
      disp("This is blue");
      colVal = "blue";
      
 elseif(meanRGB(2) > meanRGB(1) && meanRGB(2) > meanRGB(3))
     disp("This is green");
      colVal = "green";
 
 end
 disp("meanRGB:  red:" + meanRGB(1) + " green:" + meanRGB(2) + " blue:" + meanRGB(3));      

fireReturn = 'false';
if(widthLengthRatio > 2.5 && colVal == "red")
   
    %if the red > green and red > blue      
    disp("This is a fire engine");
    fireReturn = 'true';
    
   
 
    
end


%convert pixel to meter
disp("car size:" + carBox(3) * 0.0256 * sin(pi/6))
carSize = carBox(3) * 0.0256 * sin(pi/6);

% return values of if the car is oversized in postion 1
% returns value if it is a fire engine in postion 2
if (carSize > 2.5)
    disp("Car is Oversized");
    sizeVal = ["true",fireReturn,colVal];
else
    disp("Car is not overSized");
    sizeVal = ["false",fireReturn,colVal];
end


 

end