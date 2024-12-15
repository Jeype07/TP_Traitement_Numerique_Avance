function Hd = filter_3_order_3
%FILTER_3_ORDER_3 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.13 and Signal Processing Toolbox 9.1.
% Generated on: 15-Dec-2024 14:49:10

% Elliptic Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in kHz.
Fs = 6144;  % Sampling Frequency

Fpass = 20;      % Passband Frequency
Fstop = 1536;    % Stopband Frequency
Apass = 1;       % Passband Ripple (dB)
Astop = 122.16;  % Stopband Attenuation (dB)
match = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);

% [EOF]
