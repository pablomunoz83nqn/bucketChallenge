
var queue=[];
var seen={};
var final;

var firstBucket;
var secondBucket;
var expected;



function getstate(){
	if(queue==undefined)
	return;	
	state=queue[0];
	queue=queue.slice(1);
	return state;
}



function addstate(parentstate,newstate){
	if (String(newstate) in seen)
	return; 
	seen[String(newstate)] = String(parentstate);
	queue.push(newstate);
}

function getsolution(){
	var solution=[];
	state=(queue.slice(-1));
	while(state){
		solution.push(String(state));
		state=getparent(state);
}
	solution.reverse();
	return solution;

}

function getparent(childstate){
	try {
		return seen[String(childstate)];
}
	catch(e){
		return undefined;
}
}
function test (oldstate, newstate){
   	var newA = newstate[0];
    	var newB = newstate[1];
    
	won = (newA == final || newB ==final);
	addstate(oldstate,newstate);
	return won;

}

function playGame (aMax,bMax,goal){
	final=goal;
	addstate("", [0,0])
	
	while(true){
		oldstate=getstate();
		var aHas = oldstate[0];
        	var bHas = oldstate[1];
        	
		if(test (oldstate, [aMax,bHas]))
		break;
		if(test (oldstate, [0,bHas]))
		break;
                if(test (oldstate, [aHas,bMax]))
		break;
		if(test (oldstate, [aHas,0])) 
		break;
		howmuch = Math.min(aHas, bMax-bHas);
		if(test (oldstate, [aHas-howmuch,bHas+howmuch]))
		break;
		howmuch = Math.min(bHas, aMax-aHas);
		if(test (oldstate, [aHas+howmuch,bHas-howmuch]))
            	break;
}	
	console.log("solution is ");
	console.log(getsolution());
return getsolution();
}
playGame(firstBucket,secondBucket,expected);