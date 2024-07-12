function J_absolute = jitter_absolute(T)
% JITTER_ABSOLUTE - is the average absolute difference between consecutive periods, in seconds or microseconds

% T is the period of the signal, in seconds or microseconds

% J_absolute is the average absolute difference between consecutive periods, in seconds or microseconds

    J_absolute = mean(abs(diff(T)));

end
