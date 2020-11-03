%==============================================
%Function fdisk
%necessary to run the script
%Fraunhofer diffraction from a circular aperture
%==============================================
%
%calculus of the integral
%for diffraction froma circular aperture (see Sec. 5.1.3)
%with fixed values of
%R the radius of the circular aperture in microns
%the wavelength lambda in microns
%of teta in radians
%these three values are included in the array v
%N is the number of elements of the array s
function fdisk=f(v,N)
%the array s between -1 and 1
s=linspace(-1,1,N);
%preliminary calculi
fatt1=i*v*s;
fatt2=exp(fatt1);
fatt3=s.*s;
fatt4=1-fatt3;
fatt5=sqrt(fatt4);
arg=fatt2.*fatt5;
%calculus of the integral using the simplest
%MATLAB function for the integration
fdisk=(2/pi)*trapz(s,arg);
%==============================================
%