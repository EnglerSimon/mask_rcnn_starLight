%this is a function to generate a circular disc
%the function the preforms a FT on the Circle and
%then displays the airy disc


function img = CircSignal(dim,radius,mag,pos)
%
% img = CircSignal(dim,radius,mag,[pos])
%
% Generate a circular disk signal image with dimension 'dim', 
% radius in pixels, and mag specifying the gray level value.
% 'pos' is an optional argument specigying the position of the
% center of the circ.  The center of the image is default.
%
clear all;
dim = 800;
pos = [50 50];

Nstar = 100;
f=0;
%set the star position
%pos(1) = 400;
%pos(2) = 400;
%mag = 25.0;
radius1 = 25;

a = 2*pi/(radius1);
[X Y] = meshgrid(0:1:dim,0:1:dim);

%Create random star positions
%pos = randi(dim,Nstar,2);
%disp(pos);

%Create random star radii
%radius = 25 + randi(20,Nstar);

%Create random magnitude
mag = [Nstar];
radius = [Nstar];
pos = [2 Nstar];
fid = fopen('starInfo.txt', 'w');
for i = 1:1:Nstar
mag(i) = 100 + 10^(randi(5));
radius(i) = 25 + randi(20);
pos(i) = randi(dim);
fprintf(fid, '%i %i %i %i \n\r\n', pos(i),radius(i),mag(i))
end
fclose(fid);

int8(mag);
%set the star position
%pos(1) = 400;
%pos(2) = 400;
%mag = 10000.0;
%radius = 250;

%disp(radius);
%disp(mag);

%lets keep track of each star in this image:
%starInfo = [pos radius mag];
%write the image to file
% open the file with write permission

%for j=1:1:250
    %fprintf(fid, '%i %i %i %i \n\r\n', pos(j,1),pos(j,2),radius(j),mag(j));
%end
%fclose(fid);


for i=1:1:Nstar-1
r = sqrt( (X-pos(i) ).^2 + (Y-pos(i+1) ).^2);
f = f+mag(i)*(2.*besselj(1,(2.*pi/radius(i))*r(:))./r(:)).^2;
end
length = (dim+1)*(dim+1);
disp(length);
a = mean(double(f));
%disp(a);
%R = random('poiss',0.5,length,1);
%G = random('normal',0.5,length,1);
%fn = f+R+G;
fn = f;
%write(f,'starField.mat');
colormap(gray(255));

axis vis3d;

%folling lines of code perform a Fourier Transform on the circle
%which is zero padded at double the array size
t = fn - f;

Z = mesh(X,Y,reshape(f,size(X)));
axis off; 
grid off;
%xaxis off;
%yaxis off;
map = colormap(gray(255));
ALPHA = imshow(Z); 
%write(ALPHA,map,'starField.jpg')
colormap(gray(255));




Ip = mesh(X,Y,reshape(t,size(X)));
Q = mesh(X,Y,reshape(fn,size(X)));

%imwrite(Q,'output.jpg','jpg');
signalImage1 = double(Q);
noiseOnlyImage = double(Ip);

%Calculate mean square error
mse = mean2(signalImage1 - noiseOnlyImage);

%Calculate standard deviation
standard = std2(signalImage1);
standardNoise = std2(noiseOnlyImage);
disp(mse);
disp(standard);
disp(standardNoise);

%Calculate Signal to Noise 
SNR = mean2(signalImage1 ./ noiseOnlyImage );
disp(signalImage1);
disp(noiseOnlyImage);
disp(SNR);



%x=bwareaopen(Z,0); %to remove the xtra noise nd defining the area,area cud be found out by using imtool

%figure(3)
%imshow(Z,[]);

%[q,Nstar]=bwlabel(Z,8); %label connected components in 8x8 pixels(not more than 8),n=no.of objects 
%graindata=regionprops(q,'basic');

%for j=1:Nstar
    
 %   a = graindata(j).Centroid;
 %   a = round(a);
 %   y = a(1)
 %   x = a(2)
 %   rectangle('Position',[y-4 x-4 8 8],'EdgeColor','r');
 %   drawnow;
%end



%imshow(Q,[X Y]);
%colormap(gray);colorbar;
%imshow(Z,[0 10],'InitialMagnification','fit');colormap(gray); colorbar


function y = airy2(x)
%
% AIRY
%
%   The command y = airy(r) computes the first-order Airy disk
%  over the domain r which can be either a vector or matrix.
%  The Airy disk describes the Fraunhofer diffraction pattern
%  of a circular aperature in terms of light intensity:
%
%             | J1(2pir) |2 
%        I  = |----------|
%             |    r     |  
%  
%  Where J1 is a Bessel function of integer order 1.
%
%  See also SINC, BESSEL
%
%                                                           RJM 10/18/94

y=bessel(1,x)./x;
[n,m]=find(x==0);
for i=1:length(n),
  y(n(i),m(i))=.5;
end

y=y.^2;
