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
dim = 100;
pos = [500 500];
mag = 5000.0;
radius = 500;

pos2 = [250 250];
mag2 = 3500;
radius2 = 150;


if (length(dim) == 1)
  dim = [dim dim];
end

if (nargin == 3)
  % the flip is because we use (x,y) coordinates
  pos = fliplr((dim - [1 1]) / 2);
end

x = 0:1:(dim(2)-1);
y = 0:1:(dim(1)-1);

%Star1
a = 2*pi/(radius);
f=0;
%[X,Y]=meshgrid(x,x);
[X Y] = meshgrid(0:1:1000,0:1:1000);
r = sqrt( (X-pos(1) ).^2 + (Y-pos(2) ).^2);
disp(size(r));
%img = mag * (r<=radius);
R = random('poiss',0.5,1002001,1);
f = f+mag*(2*besselj(1,a*r(:))./r(:)).^2 +R/25;
disp(size(f));

a2 = 2*pi/(radius2);
f2=0;
%[X,Y]=meshgrid(x,x);
%[X Y] = meshgrid(0:1:1000,0:1:1000);
r2 = sqrt( (X-pos2(1) ).^2 + (Y-pos2(2) ).^2);
disp(size(r2));
R2 = random('poiss',0.5,1002001,1);
f = f+mag2*(2*besselj(1,a*r2(:))./r2(:)).^2 +R2/25;
disp(size(f));

colormap(jet);
axis vis3d;

%folling lines of code perform a Fourier Transform on the circle
%which is zero padded at double the array size
%mesh(X,Y,reshape(f,size(X)));

%colormap(gray);colorbar;aixs
%mesh(R);
%for n = drange(1:100)
%   f(n) = f(n)*normrnd(0.5,1);
%end
%disp(size(f));
%disp(size(X));
%disp(size(Y));

%Z = mesh(X,Y,reshape(f,size(X))); 


Z = mesh(X,Y,reshape(f,size(X))); 
%Q = immultiply(Z,R);
%Q=mtimes(Z,R);

%meshz();

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
