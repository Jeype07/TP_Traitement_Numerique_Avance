function Hd = filter_lp_elliptic_order_13
%FILTER_LP_ELLIPTIC_ORDER_13 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.13 and Signal Processing Toolbox 9.1.
% Generated on: 11-Dec-2024 17:07:00

% Elliptic Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in kHz.
Fs = 6144;  % Sampling Frequency

Fpass = 20;      % Passband Frequency
Fstop = 24;      % Stopband Frequency
Apass = 1;       % Passband Ripple (dB)
Astop = 122.16;  % Stopband Attenuation (dB)
match = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);

% [EOF]
