## Create a 15-30 second piece of music using some or all of the following tools we went over last week:

1. Print your name and the name of your piece.

```ChucK
   <<<"print something here">>>;
```

2. variables, for/while loops

```ChucK
//use variables to store values & help make your program more readable
10 => int myInt
15.1 => float myFloat
"hello world" => string myString


// for loop
for(0 => int i; i < 10; i++){
//code here will run 10 times
}

// while loop
while(true){
//code here will run infinitely
}

0 => int i;
0 => int float;
"hello" => string greeting;
```

3. Oscillators: SinOsc TriOsc SawOsc SqrOsc

```ChucK
// Creates a Sine Wave Oscillator called s and 'chucks' it to the dac
// (digital analogue converter i.e. your computer's soundcard)
SinOsc s => dac;
```

4. Change frequency & gain of your sounds

```ChucK
0.5 => s.gain;
440 => s.freq; 5. Use some functions from the Std & Math libraries

// returns a random float between 5.0 & 10.0
Math.random2f(5.0, 10.0) = float myRandomFloat

// returns a random Int between 2 & 8
Math.random2(2, 8) => int myRandomInt;

// converts midi note value 60 (middle C) to frequency (Hz)
Std.mtof(60) => float middleC
```

6. Don't forget to pass time to allow sounds to play!

```ChucK
1::second => now;
50::ms => now;
```
