// SAMPLING

//////////////////////////////////////////////////////////////////
// IMPORTANT MAKE SURE YOUR CHUCK FILE IS SAVED IN WEEK2 FOLDER //
//////////////////////////////////////////////////////////////////

SinOsc sine => LPF lpf => Gain g => ADSR env => dac;
SawOsc saw => lpf;
SqrOsc sqr => lpf;
lpf => Delay delay => Pan2 bassPan => HPF delayHPF => JCRev bassRev => g;
Noise n => JCRev r => HPF hpf => g;

delay.delay(200::ms);
delay.max(300::ms);
bassPan.gain(1);
bassRev.mix(0.8);
delayHPF.freq(1000);

SawOsc pad1 => Pan2 pad1Pan => LPF lpfPad => Gain padG => ADSR padEnv => dac;
pad1 => JCRev padRev => padG;
SawOsc pad2 => Pan2 pad2Pan => lpfPad;
pad2 => padRev;

padRev.mix(0.5);
pad1Pan.pan(-0.5);
pad1Pan.pan(0.5);

padEnv.set(6.4::second, 1.6::second, 1, 6.4::second);


padG.gain(0.05);
lpfPad.freq(800);


r.mix(0.5);
env.set(25::ms, 1::ms, 1, 200::ms );
g.gain(0.25);
n.gain(0.05);
3000 => hpf.freq;
400 => lpf.freq;

int note;

[1, 0 , 0, 1, 1 , 0 , 1 , 0, 1 , 0 , 0, 1 , 1 , 0 , 0, 1] @=> int bassline[];
[34, 27, 24, 25] @=> int bassNotes[];
[36, 37, 22, 25] @=> int bassNotes2[];
me.sourceDir() + "../DrumSamples/" => string folder;


//IMPORT SAMPLES INTO SOUNDBUF OBJECTS
SndBuf kick => dac;
folder + "Kick01.wav" => kick.read;

SndBuf snare => Pan2 snarePan => dac;
folder + "Snare01.wav" => snare.read;

SndBuf hh => Pan2 hhPan => dac;
folder + "ClosedHat01.wav" => hh.read;

[1, 0 , 0, 1, 0 , 1 , 0 , 1, 0 , 1 , 0, 1 , 0 , 0 , 0, 1] @=> int kickPattern[];
[1, 1 , 0, 1, 0 , 0 , 0 , 1, 0 , 0 , 0, 1 , 0 , 1 , 0, 0] @=> int snarePattern[];
[1, 0 , 0, 1, 0 , 1 , 0 , 1, 0 , 0 , 0, 1 , 0 , 0 , 0, 0] @=> int hhPattern[];

0 => kick.rate;
0 => snare.rate;
0 => hh.rate;

0 => int step;
0 => int bar;
0 => int offset;

while(true){
    bassPan.pan(Math.random2f(-0.5, 0.5));
    if(Math.random2(0, 10) == 0){
        Math.random2(0, 3) => offset;
    }
    if(bassline[(step + offset) % 16] == 1){
        if(bar % 4 == 0){
            bassNotes[Math.random2(0, bassNotes.cap() - 1)] => note;
        }
        else{
            bassNotes2[Math.random2(0, bassNotes2.cap() - 1)] => note;
        }
        synth(note);
        env.releaseTime(Math.random2f(200, 300)::ms);
        env.keyOn();
        
        
    }
    if(bar % 8 == 0){
        bass();
        padEnv.keyOn();
    }
    if(bar % 8 == 5){
        padEnv.keyOff();
    }
    
    if(kickPattern[step % 16] == 1){
        Math.random2f(1, 1.5) => kick.rate;
        0 => kick.pos;
    }
    if(snarePattern[step % 16] == 1){
        Math.random2f(0.5, 0.8) * Math.random2(1, 2) => snare.rate;
        0 => snare.pos;
        Math.random2f(-0.5, 0.5) => snarePan.pan;
        snare.gain(Math.random2f(0.5, 0.7));
    }
    if(hhPattern[step % 16] == 1){
        Math.random2f(-0.5, 0.5) => hhPan.pan;
        Math.random2f(1, 2) => hh.rate;
        Math.random2f(0.7, 0.9) => hh.gain;
        0 => hh.pos;
    }
    
    100::ms => now;  
    env.keyOff(); 
    
    //if(Math.random2(0,30) == 0){
    //    step + 5 => step;
    //}
    
    if(step % 16 == 15) bar++;
    step++; 
}

fun void synth(int midiNote){
    Std.mtof(midiNote) => float freq;
    sine.freq(freq);
    saw.freq(detune(freq * 6));
    sqr.freq(detune(freq * 2));
}

fun void bass(){
    bassNotes[Math.random2(0, bassNotes.cap() - 1)]+36 => float note1;
    bassNotes[Math.random2(0, bassNotes.cap() - 1)]+36 => float note2;
    pad1.freq(detune(Std.mtof(note1)));
    pad2.freq(detune(Std.mtof(note2)));
}

fun float detune(float freq){
    return freq*Math.random2f(0.99, 1.01);
}