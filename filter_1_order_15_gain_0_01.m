function Hd = filter_1_order_15_gain_0_01
%FILTER_1_ORDER_15_GAIN_0.01 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.13 and Signal Processing Toolbox 9.1.
% Generated on: 15-Dec-2024 18:57:47

% Elliptic Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in kHz.
Fs = 6144;  % Sampling Frequency

Fpass = 20;          % Passband Frequency
Fstop = 24;          % Stopband Frequency
Apass = 0.01;        % Passband Ripple (dB)
Astop = 122.16;      % Stopband Attenuation (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);

% [EOF]
