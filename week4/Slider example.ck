MAUI_Slider slider;
"volume" => slider.name;
slider.display();
slider.range( 0, 1 );

Blit s => dac;
4 => s.harmonics;
0.5 => s.gain;

while( true )
{
    slider.value() => s.gain;
    10::ms => now;
}