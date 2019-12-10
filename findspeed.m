function speedingTrue = findspeed(im1,im2)
i = imread(im1);

i2 = imread(im2);
carOneCentroid = detectCar(i);
carOneCentroidY = carOneCentroid(2);% 2 represents the y value of the centroid
disp("carOne position:" + carOneCentroidY);

carTwoCentroid = detectCar(i2);
carTwoCentroidY = carTwoCentroid(2);
disp("carTwo position:" + carTwoCentroidY); 

distanceMeter = (carOneCentroidY*0.016 - carTwoCentroidY*0.016)*cos(pi/3);
% max view of camera = 14m (7/sin30), so 14m = 640 pixel 
%therefore 1 pixel = 0.02916666666m

%12.1244

%641x481
meterPerSecond = distanceMeter / 0.1;
disp("meter per seconds:"+meterPerSecond)
milesPerHour = 2.23694 * meterPerSecond;
disp("distance travelled :" + distanceMeter);
disp("Miles/h :" + milesPerHour);
if (milesPerHour > 30)
    disp("Car is Speeding");
    speedingTrue = "true";
else
    disp("Car is not speeding");
    speedingTrue = "false";
end



end


%function that finds where the car is and returns the centroid
function carCentroid = detectCar(inputImg) 

%segment by colors  L*a*b (luminosity layer 'L*', chromaticity-layer 'a*' ,chromaticity-layer 'b*'
lab_he = rgb2lab(inputImg);
ab = lab_he(:,:,2:3);
ab = im2single(ab);
nColors = 3;
% repeat the clustering 3 times to avoid local minima

pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);
%pixel_labels = imsegkmeans(featureSet,nColors,'NumAttempts',3);
figure,imshow(pixel_labels,[]),title('Image Labeled by Cluster Index');


imBw = imbinarize(pixel_labels);
figure,imshow(imBw ),title('binary image');

%figure, imshow(imBw);
%remove black holes
se = strel('disk',5);
closeIm = imclose(imBw,se); 
figure,imshow(closeIm),title('close im');


%remove small white circles
se = strel('disk',2);
openIm = imopen(closeIm,se);
figure , imshow(openIm);

%remove all obj with  less than p pixels
deleteSmallHole = bwareaopen(openIm,300);
figure , imshow(deleteSmallHole ), title("Delete white areas");

stats = regionprops(deleteSmallHole,'Centroid');
centroids = cat(1,stats.Centroid);
%figure , imshow(imErode);
hold on
plot(centroids(:,1),centroids(:,2),'b*');
hold off
%figure , imshowpair(imClose,imErode,'montage');

carCentroid = centroids;
end