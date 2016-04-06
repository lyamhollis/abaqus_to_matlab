function import_wave(x_limits,y_limits,z_limits)


%%
% import the coordinate system output from the .odb file in abaqus
[coords] = import_coords('coords.txt');

%%
% import the displacements at the time points
[time1] = import_time('time_1.txt');
[time2] = import_time('time_2.txt');
[time3] = import_time('time_3.txt');
[time4] = import_time('time_4.txt');
[time5] = import_time('time_5.txt');
[time6] = import_time('time_6.txt');
[time7] = import_time('time_7.txt');
[time8] = import_time('time_8.txt');

% remove the first column in the time points relating the nodal number
time1 = time1(:,2:end);
time2 = time2(:,2:end);
time3 = time3(:,2:end);
time4 = time4(:,2:end);
time5 = time5(:,2:end);
time6 = time6(:,2:end);
time7 = time7(:,2:end);
time8 = time8(:,2:end);

%% 
% create the new coordinate system for the data to be output at
dif = [abs(x_limits(1) - x_limits(2)),abs(y_limits(1) - y_limits(2)),abs(z_limits(1) - z_limits(2))];

[~,order] = sort(dif);

% reorder the coordinates so that the row z-axis in the new coordinate
% system is third
coord = [coords(:,order(3)),coords(:,order(2)),coords(:,order(1))];

new_coords = [x_limits;y_limits;z_limits];

x = new_coords(order(3),:);
y = new_coords(order(2),:);
z = new_coords(order(1),:);

pixel_size= [0.001,0.0015,0.002,0.0025,0.003];
pixel_name = {'wave_1mm','wave_1_5mm','wave_2mm','wave_2_5mm','wave_3mm'};



%%
for i = 1:length(pixel_size)
    % use griddata function to interpolate to the new set of coordinates
    
    [X,Y,Z] = meshgrid(x(1):pixel_size(i):x(2),y(1):pixel_size(i):y(2),z(1) - 2*pixel_size(i):pixel_size(i):z(2)+2*pixel_size(i));

    wx1 = griddata(coord(:,1),coord(:,2),coord(:,3),time1(:,1),X,Y,Z);
    wx2 = griddata(coord(:,1),coord(:,2),coord(:,3),time2(:,1),X,Y,Z);
    wx3 = griddata(coord(:,1),coord(:,2),coord(:,3),time3(:,1),X,Y,Z);
    wx4 = griddata(coord(:,1),coord(:,2),coord(:,3),time4(:,1),X,Y,Z);
    wx5 = griddata(coord(:,1),coord(:,2),coord(:,3),time5(:,1),X,Y,Z);
    wx6 = griddata(coord(:,1),coord(:,2),coord(:,3),time6(:,1),X,Y,Z);
    wx7 = griddata(coord(:,1),coord(:,2),coord(:,3),time7(:,1),X,Y,Z);
    wx8 = griddata(coord(:,1),coord(:,2),coord(:,3),time8(:,1),X,Y,Z);

    wy1 = griddata(coord(:,1),coord(:,2),coord(:,3),time1(:,2),X,Y,Z);
    wy2 = griddata(coord(:,1),coord(:,2),coord(:,3),time2(:,2),X,Y,Z);
    wy3 = griddata(coord(:,1),coord(:,2),coord(:,3),time3(:,2),X,Y,Z);
    wy4 = griddata(coord(:,1),coord(:,2),coord(:,3),time4(:,2),X,Y,Z);
    wy5 = griddata(coord(:,1),coord(:,2),coord(:,3),time5(:,2),X,Y,Z);
    wy6 = griddata(coord(:,1),coord(:,2),coord(:,3),time6(:,2),X,Y,Z);
    wy7 = griddata(coord(:,1),coord(:,2),coord(:,3),time7(:,2),X,Y,Z);
    wy8 = griddata(coord(:,1),coord(:,2),coord(:,3),time8(:,3),X,Y,Z);

    wz1 = griddata(coord(:,1),coord(:,2),coord(:,3),time1(:,3),X,Y,Z);
    wz2 = griddata(coord(:,1),coord(:,2),coord(:,3),time2(:,3),X,Y,Z);
    wz3 = griddata(coord(:,1),coord(:,2),coord(:,3),time3(:,3),X,Y,Z);
    wz4 = griddata(coord(:,1),coord(:,2),coord(:,3),time4(:,3),X,Y,Z);
    wz5 = griddata(coord(:,1),coord(:,2),coord(:,3),time5(:,3),X,Y,Z);
    wz6 = griddata(coord(:,1),coord(:,2),coord(:,3),time6(:,3),X,Y,Z);
    wz7 = griddata(coord(:,1),coord(:,2),coord(:,3),time7(:,3),X,Y,Z);
    wz8 = griddata(coord(:,1),coord(:,2),coord(:,3),time8(:,3),X,Y,Z);
    
    wx = cat(4,wx1,wx2,wx3,wx4,wx5,wx6,wx7,wx8);
    wy = cat(4,wy1,wy2,wy3,wy4,wy5,wy6,wy7,wy8);
    wz = cat(4,wz1,wz2,wz3,wz4,wz5,wz6,wz7,wz8);
    

    %%
    % perform a fourier transform to create the complex wave image of interest
    cw_x = fft(wx,[],4);
    cw_y = fft(wy,[],4);
    cw_z = fft(wz,[],4);

    cwx(:,:,:) = cw_x(:,:,:,2);
    cwy(:,:,:) = cw_y(:,:,:,2);
    cwz(:,:,:) = cw_z(:,:,:,2);
    
     
    save(pixel_name{i},'wx','wy','wz','cwx','cwy','cwz');
    
    clear w* clear cw*    
    
end

