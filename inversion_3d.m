function [G_3d] = inversion_3d(cwx,cwy,cwz,density,freq,pixel_size)

% calculate the pixel size in metres
dx = pixel_size/1000;
dy = pixel_size/1000;
dz = pixel_size/1000;

% angular frequency
ang_freq = 2*pi*freq;

% calculate the first spatial derivatives
[gradx_x gradx_y gradx_z] = gradient(cwx,dx,dy,dz);
[grady_x grady_y grady_z] = gradient(cwy,dx,dy,dz);
[gradz_x gradz_y gradz_z] = gradient(cwz,dx,dy,dz);

% calculate the second spatial derivatives
[gradx_xx gradx_xy gradx_xz] = gradient(gradx_x,dx,dy,dz);
[gradx_yx gradx_yy gradx_yz] = gradient(gradx_y,dx,dy,dz);
[gradx_zx gradx_zy gradx_zz] = gradient(gradx_z,dx,dy,dz);

[grady_xx grady_xy grady_xz] = gradient(grady_x,dx,dy,dz);
[grady_yx grady_yy grady_yz] = gradient(grady_y,dx,dy,dz);
[grady_zx grady_zy grady_zz] = gradient(grady_z,dx,dy,dz);

[gradz_xx gradz_xy gradz_xz] = gradient(gradz_x,dx,dy,dz);
[gradz_yx gradz_yy gradz_yz] = gradient(gradz_y,dx,dy,dz);
[gradz_zx gradz_zy gradz_zz] = gradient(gradz_z,dx,dy,dz);

% calculate the laplacian in each direction
laplac_x = gradx_xx + gradx_yy + gradx_zz;
laplac_y = grady_xx + grady_yy + grady_zz;
laplac_z = gradz_xx + gradz_yy + gradz_zz;

% 3-d direct inversion algorithm
G_3d = -density*ang_freq^2*((cwx + cwy + cwz)./(laplac_x + laplac_y + laplac_z));

real_G = real(G_3d);
imag_G = imag(G_3d);

real_G = abs(real_G);
imag_G = abs(imag_G);

G_3d = real_G + i*imag_G;
