function [timeDifference] = calcEventTimeDifference(td, event1, event2)
% returns a cell array of time differences between twp specified events
%
% EMT 2016-04-08

times1 = td.getEventFirst(event1);
times2 = td.getEventFirst(event2);

% timeDifference = cellfun(@(x,y) y-x, times1, times2, 'uniformoutput', false)

timeDifference = times2 - times1;


end