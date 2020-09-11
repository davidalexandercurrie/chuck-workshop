SawOsc s => LPF lpf => dac;

0.1 => s.gain;
440 => s.freq;
lpf.freq(600);

2::second => now;