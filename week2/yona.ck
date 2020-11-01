// SAMPLING

//////////////////////////////////////////////////////////////////
// IMPORTANT MAKE SURE YOUR CHUCK FILE IS SAVED IN WEEK2 FOLDER //
//////////////////////////////////////////////////////////////////

me.sourceDir() + "../DrumSamples/" => string folder;

SndBuf kick => dac;
folder + "Kick01.wav" => kick.read;

SndBuf snare => dac;
folder + "Snare01.wav" => snare.read;

SndBuf hh => dac;
folder + "ClosedHat01.wav" => hh.read;

[1, 0 , 0, 1, 0 , 1 , 0 , 1, 0 , 1 , 0, 1 , 0 , 0 , 0, 0] @=> int kickPattern[];
[1, 1 , 0, 1, 0 , 0 , 0 , 1, 0 , 0 , 0, 1 , 0 , 1 , 0, 1] @=> int snarePattern[];
[1, 0 , 0, 1, 0 , 1 , 0 , 1, 0 , 0 , 0, 1 , 0 , 0 , 0, 1] @=> int hhPattern[];

0 => kick.rate;
0 => snare.rate;
0 => hh.rate;

0 => int step;

// %
//  5 % 4

while(true){
    
    if(kickPattern[step % 16] == 1){
        1 => kick.rate;
        0 => kick.pos;
    }
    if(snarePattern[step % 16] == 1){
        1 => snare.rate;
        0 => snare.pos;
    }
    if(hhPattern[step % 16] == 1){
        1 => hh.rate;
        0 => hh.pos;
    }
    
    
    100::ms => now;   
    step++; 
    if(Math.random2(0,8) == 0){
        step + 5 => step;
    }
}