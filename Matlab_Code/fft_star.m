f = imread('C:\Users\PhaseSpace\Documents\UofC\ENEL619\Noise\2048_100stars_noise2.jpg');
simulated = imread('C:\Users\PhaseSpace\Documents\UofC\ENEL619\Noise\2048_100stars_nonoise2.jpg');


Ip = imsubtract(f,simulated);
signalImage1 = double(simulated);
noiseOnlyImage = double(f) - signalImage1;
SNR = mean2(signalImage1 ./ noiseOnlyImage );
disp(SNR);
g = fft2(f);
h = fft2(simulated);
figure,
imshow(Ip,[]);

