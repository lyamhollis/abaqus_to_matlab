function f = lowpassfilter(cwx, cutoff, filter_order, pixel)

% use the complex wave image to calculate the size of the filter required
[m,n,o] = size(cwx);

% create the coordinate system over which to create the filter
[x,y,z] = meshgrid(-pixel*((n-1)/2):pixel:pixel*((n-1)/2),-pixel*((m-1)/2):pixel:pixel*((m-1)/2),-pixel*((o-1)/2):pixel:pixel*(o/2));

% A matrix with every pixel = radius relative to centre.
radius = sqrt(x.^2 + y.^2 + z.^2);        

% create the filter
f = sqrt(1 ./ (1.0 + (radius ./ cutoff).^(2*filter_order))); 


 