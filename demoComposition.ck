TriOsc sinewav => dac;
SawOsc saw => LPF lpf => dac;
20000 => lpf.freq;
// float, int, string
// float: 1.2, 1.0
// int: 1 5 3 6 3 
// string: "hello world"

2.0 => float beatDuration;
0.5::second => dur beatDur;

0.1 => saw.gain;

int chance;


while(true){
    Math.random2(0, 9) => chance;
    
    if(chance < 3){
        // idea 1
        220 => sinewav.freq;
        0.1 => sinewav.gain;
        219 => saw.freq;
        beatDur => now;
        120 => sinewav.freq;
        121 => saw.freq;
        beatDur/4 => now;
    }
    if(sinewav.freq() > 100){
        220 => sinewav.freq;
        0.1 => sinewav.gain;
        219 => saw.freq;
        beatDur => now;
        120 => sinewav.freq;
        121 => saw.freq;
        beatDur/4 => now;
    }
    
    if(chance > 1 && chance < 8){
        //idea 2
        0.1 => saw.gain;
        Math.random2f(0.1, 0.3) => sinewav.gain;
        80*Math.random2f(0.99,1.01) => sinewav.freq;
        161 *Math.random2f(0.99,1.01) => saw.freq;
        beatDur/11 => now;
        0 => saw.gain;
        0 => sinewav.gain;
        beatDur/21 => now;
    }
    
    if(chance < 8){
        //idea 3
        for(0 => int i; i < 5; i++){
            0.2 => saw.gain;
            100 => saw.freq;
            121 => sinewav.freq;
            50::ms => now;
            Math.random2(100, 3000) => lpf.freq;
            Math.random2(50, 100) => int beat;
            0 => saw.gain;
            beat::ms => now;
        }
    }
    
}






