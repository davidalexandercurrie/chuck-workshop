// SAMPLING

me.sourceDir() + "../DrumSamples/" => string folder;

SndBuf kick => dac;
folder + "Kick01.wav" => kick.read;

SndBuf snare => dac;
folder + "Snare01.wav" => snare.read;



0 => kick.pos;
1::second => now;
0 => kick.pos;
1::second => now;
0 => kick.pos;
5::second => now;
0 => kick.pos;
1::second => now;
0 => kick.pos;
1::second => now;