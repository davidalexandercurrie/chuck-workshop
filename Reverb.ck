SawOsc s => ADSR env => PRCRev reverb => dac;
env => LPF lpf => dac;
SinOsc s2 => reverb;

s2.gain(0.2);
// attack decay sustain release
env.set(0.005::second, 0::second, 1, 0.2::second);
110 => s.freq; // frequency of sine wave
0.2 => s.gain; // volume of sound wave
0.2 => reverb.mix; // mix level of reverb


//filter
200 => lpf.freq;

int chance;
200 => float newFreq;
dur beat;
0.01::second => beat;



while(true){
    Math.random2(0,10) => chance;
    
    
    if(chance > 5){
        
        <<<"chance == ", chance, " and so this is running">>>;
        // another rhythmic element here
        env.keyOn();
        beat => now;
        env.keyOff();
        beat*4 => now;
        env.keyOn();
        beat => now;
        env.keyOff();
        beat*4 => now;
    }else{
        Math.random2f(0.1, 0.3) => s.gain;
    }
    if(chance < 4){
        reverb.mix(Math.random2f(0.01, 0.4));
        env.keyOn();
        
        beat => now;
        env.keyOff();
        0.2::second => now;
        env.keyOn();
        0.01::second => now;
        env.keyOff();
        0.4::second => now;
        s2.freq(newFreq*Math.random2(1, 5) + Math.random2f(-0.1, 0.1));
        s2.gain(0.1);
    }
    if(chance == 3){
        Math.random2f(60, 220) => newFreq;
        s.freq(newFreq);
    }

    
    
    
    // some sort of rhythmic element
    env.keyOn();
    s.freq() * Math.random2f(0.99,1.01) => s.freq;
    beat/10 => now;
    env.keyOff();
    beat*3 => now;
    <<<beat>>>;
    
    
}



