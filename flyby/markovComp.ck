// group markov composition



"david" => string state;
while(true){
    david();
    1::samp => now;
}


fun void david(){
    //write if your state
    if(state == "david"){
        //print your name
        <<<"david">>>;
        //write your music here!   
        1000::ms => now;
        
        
        //move to next state
        Math.random2(0, 100) => int chance;
        if(chance < 10){
            "david" => state;
        }else if(chance < 20){
            "ami" => state;
        }else{
            "rebecca" => state;
        }
    }
}

