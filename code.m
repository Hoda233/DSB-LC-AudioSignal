% Read the audio signal
clear;
[y,fs] = audioread('myaudio.mp3');
% sound(y,fs);
y =y(:,1) + y(:,2);

%time domain
t = (0:length(y) - 1)*20/length(y);

% Plot signal in time domain
subplot(3,1,1);
plot(t,y);
title(" Original signal in time domain");
xlabel('Time(s)');
ylabel('Amplitude ');

% freq domain
Y = fft(y);
Y_shift = fftshift(Y);
dfs=fs/length(y);
f=-fs/2:dfs:fs/2-dfs;

% Plot signal in frequency domain
subplot(3,1,2);
plot(f,abs(Y_shift));
title("Magnitude in freq domain");
ylabel('Magnitude');
subplot(3,1,3);
plot(f,unwrap(angle(Y)));
title("Phase in freq domain");
ylabel('Phase');

% Modulation ------------------------------------
BW=bandwidth(y)./(2.*pi);
fc=(fs/2)-BW;
wc=2*pi*fc;
Ac = abs(min(y));
c= cos(wc*t).';
y_mod = (y+Ac).*c;

% Plot signal in time domain
fig=figure();
subplot(4,1,1);
plot(t,y_mod);
title(" Modulated signal in time domain");
xlabel('Time(s)');
ylabel('Amplitude ');

% freq domain
Y_mod = fft(y_mod);
Y_shift_mod = fftshift(Y_mod);

% Plot signal in frequency domain
subplot(3,1,2);
plot(f,abs(Y_shift_mod));
title("Magnitude in freq domain");
ylabel('Magnitude');
subplot(3,1,3);
plot(f,unwrap(angle(Y_mod)));
title("Phase in freq domain");
ylabel('Phase');

% Demodulation ------------------------------------
y_demod = y_mod.*c;
y_demod_lpf = lowpass(y_demod,10000,fs);
y_demod_lpf=y_demod_lpf*2;
y_demod_lpf = y_demod_lpf -Ac;

% Plot signal in time domain
fig1=figure();
subplot(3,1,1);
plot(t,y_demod_lpf);
title(" Demodulated signal in time domain");
xlabel('Time(s)');
ylabel('Amplitude ');

% freq domain
Y_demod = fft(y_demod_lpf);
Y_shift_demod = fftshift(Y_demod);

% Plot signal in frequency domain
subplot(3,1,2);
plot(f,abs(Y_shift_demod));
title("Magnitude in freq domain");
ylabel('Magnitude');
subplot(3,1,3);
plot(f,unwrap(angle(Y_demod)));
title("Phase in freq domain");
ylabel('Phase');
sound(y_demod_lpf,fs);
