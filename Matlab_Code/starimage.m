

%this is a function to generate a circular disc
%the function the preforms a FT on the Circle and
%then displays the airy disc

function img = CircSignal(dim,Nstars,radius,mag)
%
% img = CircSignal(dim,radius,mag,[pos])
%
% Generate a circular disk signal image with dimension 'dim', 
% radius in pixels, and mag specifying the gray level value.
% 'pos' is an optional argument specigying the position of the
% center of the circ.  The center of the image is default.
%
% Set the CCD Camera chip size to be dimxdim
dim = 500;

% Set the number of stars in the image
Nstars = 100;

% Set the radius of the star images (Randomly generated)
radius = 5;

% Set the position of each of the stars
pos = randi([0,Nstars],100,1)
%pos = randi(Nstars,2,dim);
%pos = [1,2.5];
%disp(size(pos));
% Set the magnitude of each of the stars at position
mag = 25.0;

% Set the radius of each of the stars
radius = 2.5;

%create array size of CCD chip
dim = [dim dim];
x = 1:1:dim(1);
y = 1:1:dim(2);

a = 2*pi/(radius);

[X Y] = meshgrid(1:1:dim,1:1:dim);
size(pos)
size([X,Y])
r = sqrt( (X-pos ).^2 + (X-pos ).^2);

%disp(size(r));
img = mag * (r<=radius);

%Random noise across the CCD Chip
R = random('poiss',0.1,1002001,1);
%r = [Nstars,dim];
r = [1,1];
%Calculate r for star across chip
%for i=1:1:1
%       a = 2*pi/(radius);
       r = sqrt((X-pos(1,1)).^2 + (Y-pos(1,2).^2));
%       disp(r);
%end
%disp(X);
%disp(Y);
%disp(pos(1,1));
%disp(pos(1,2));
%disp(r);
%disp(size(r)); 
 
f = mag*(2*besselj(1,a*r(:))./r(:)).^2;
%disp(f);

%disp(size(f));
colormap(gray);
axis vis3d;

%folling lines of code perform a Fourier Transform on the circle
%which is zero padded at double the array size
%mesh(X,Y,reshape(f,size(X)));
 
Z = mesh(X,Y,reshape(f,size(X))); 



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
