// sound file
me.sourceDir() + "/Audio/kick.wav" => string filename;


// the patch 
SndBuf buf => dac;
// load the file
filename => buf.read;

// time loop
while( true )
{
    0 => buf.pos;
    Math.random2f(.2,.5) => buf.gain;
    Math.random2f(.5,1.5) => buf.rate;
    80::ms => now;
    0 => buf.rate;
    20::ms => now;
}