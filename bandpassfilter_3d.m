function [cwx_band,cwy_band,cwz_band] = bandpassfilter_3d(cwx,cwy,cwz,lower_limit,lower_filter_order,upper_limit,upper_filter_order,pixel_size)

%%
% input complex wave images relating the displamements in the x,y, and z
% directions: cwx, cwy and cwz

% input the pixel size in mm: pixel_size

% input the upper and lower limits for the bandpass filter: upper_limit and
% lower_limit. The limits represent the wavenumber in pixels at which
% cutoff should occur.

% input the order of the filters. Should be an integer value > 1. The
% higher the value the sharper the cutoff for the filter:
% lower_filter_order and upper_filter_order
%%

% calculate the filter to apply the frequency domain of the complex wave
% images
f = bandpassfilter(cwx,lower_limit,lower_filter_order,upper_limit,upper_filter_order,pixel_size);

%%
% perform fast Fourier transforms on the complex wave images and shift
% frequency domain data
fourier_x = fftshift(fftn(cwx));
fourier_y = fftshift(fftn(cwy));
fourier_z = fftshift(fftn(cwz));

%%
% apply the mask to the frequency domain images
filter_x = fourier_x.*f;
filter_y = fourier_y.*f;
filter_z = fourier_z.*f;

%%
% inverse Fourier shift followed by inverse Fourier trasform to take
% create the filtered complex wave image in the spatial domain
cwx_band = ifftn(ifftshift(filter_x));
cwy_band = ifftn(ifftshift(filter_y));
cwz_band = ifftn(ifftshift(filter_z));

end

