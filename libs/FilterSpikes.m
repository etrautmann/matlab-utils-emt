function out = FilterSpikes(SD, in)

s = size(in);
if s(1) == 1
    in = in';
end

gausswidth = 8*SD;  % 2.5 is the default for the function gausswin
F = normpdf(1:gausswidth, gausswidth/2, SD);  %F = gausswin(gausswidth);  % will be
 
F = F/(sum(F));

shift = floor(length(F)/2); % this is the amount of time that must be added to the beginning and end;
last = length(in); % length of incoming data
prefilt = [zeros(shift,1)+mean(in(1:SD));in;(zeros(shift,1)+mean(in(last-SD:last)))]; % pads the beginning and end with copies of first and last value (not zeros)
postfilt = filter(F,1,prefilt); % filters the data with the impulse response in Filter

out = postfilt(1+2*shift:length(postfilt))*1000;  % Shifts the data back by 'shift', half the filter length
                                               
                                                
