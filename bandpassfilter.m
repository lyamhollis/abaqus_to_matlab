function f = bandpassfilter(cwx, lower_filter_limit,lower_filter_order, upper_filter_order, upper_filter_limit, pixel)
    
% use the low pass filter to create a bandpass filter       
f = lowpassfilter(cwx, upper_filter_order, upper_filter_limit, pixel) - lowpassfilter(cwx, lower_filter_limit, lower_filter_order, pixel);