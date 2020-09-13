//////////////////////////////////////////////////////////////////
// IMPORTANT MAKE SURE YOUR CHUCK FILE IS SAVED IN WEEK2 FOLDER //
//////////////////////////////////////////////////////////////////

//SYNTH
SawOsc saw1 => LPF lpf => Pan2 synthPanner => JCRev r => dac;
SawOsc saw2 => lpf;

r.mix(0.1);

//SAMPLES
// root directory
me.sourceDir() + "../DrumSamples/" => string folder;

SndBuf kick[3];
for(0 => int i; i < 3; i++){
    kick[i] => dac;
}
folder + "Kick01.wav" => kick[0].read;
folder + "Kick02.wav" => kick[1].read;
folder + "Kick03.wav" => kick[2].read;

SndBuf snare[3];
for(0 => int i; i < 3; i++){
    snare[i] => dac;
}

folder + "Snare01.wav" => snare[0].read;
folder + "Snare02.wav" => snare[1].read;
folder + "Snare03.wav" => snare[2].read;

SndBuf hh[2];
Pan2 hhPanner => dac;
for(0 => int i; i < 2; i++){
    hh[i] => hhPanner;
}

folder + "ClosedHat01.wav" => hh[0].read;
folder + "ClosedHat02.wav" => hh[1].read;


0 => int step;
0.2::second => dur beat;

[1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0] @=> int kickPattern[];
[0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1] @=> int snarePattern[];
[1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1] @=> int hhPattern[];
[1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1] @=> int synthPattern[];
[60, 63, 48, 51, 57] @=> int notes[];


while(true){
    if(synthPattern[step%16] == 1){
        //inputs: float note1, float note2, float volume
        synth(notes[Math.random2(0, notes.cap()-1)], 0.5);
    }else{
        0 => synthPanner.gain;
    }
    
    if(kickPattern[step%16] == 1){
        0 => kick[Math.random2(0,2)].pos;
    }
    if(snarePattern[step%16] == 1){
        Math.random2(0,2) => int snareHit;
        0 => snare[snareHit].pos;
        Math.random2f(0.5, 2) => snare[snareHit].rate;
    }
    if(hhPattern[step%16] == 1){
        Math.random2(0,1) => int hhHit;
        0 => hh[hhHit].pos;
        Math.random2f(-0.2, 0.2) => hhPanner.pan;
    }
    
    
    beat => now;
    
    if(Math.random2(0, 1) == 0){
        step + 5 => step;
    }
    step++;
}




fun void synth(float note, float volume){
    Std.mtof(note) => float freq;
    lpf.freq(freq*4);
    freq => saw1.freq;
    freq*1.5 => saw2.freq;
    volume => synthPanner.gain;
}


// HANDY TIP
// control + f, b, p, n, e, a = forwards, back, previous, next, end, start