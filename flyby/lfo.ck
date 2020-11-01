SawOsc saw => dac;
SinOsc lfo => blackhole;
SinOsc lfo2 => blackhole;


220 => saw.freq;
0.5 => saw.gain;
2 => lfo.freq;
5 => lfo2.freq;


while(true){
    lfo2.last() * 2 + lfo.freq() => lfo.freq;
    lfo.last() => saw.gain;
    1::ms => now;
}