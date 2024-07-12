function S_local_db = shim_local_db(A)
% This function calculates the local dB of a shimmer signal
% A is the amplitude of the signal

    N = length(A); % Get the number of elements in A
    sum_log_diff = 0; % Initialize the sum to zero

    for i = 1:(N - 1)
        sum_log_diff = sum_log_diff + 20 * abs(log10(A(i+1) / A(i)));
    end

    S_local_db = sum_log_diff / (N - 1); 
end
