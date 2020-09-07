


spork~ note(300, 2);
spork~ note(500, 3);
10::second => now;

fun void note(int freq, int duration) {
    
    SinOsc s => dac;
    freq => s.freq;
    0.2 => s.gain;
    duration::second => now;
    0 => s.gain;
   
}