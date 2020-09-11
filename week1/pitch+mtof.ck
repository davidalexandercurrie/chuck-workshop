SinOsc s => dac;
[60, 64, 67, 69] @=> int pitcharray[];
0.2 => s.gain;

while(true){
    pitcharray[Math.random2(0,3)] => int note;
    Std.mtof(note) => float middleC;
    s.freq(middleC); 
    0.1::second => now;   
}


while(true){
1::samp => now;    
}