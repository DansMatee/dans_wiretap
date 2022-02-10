var tableItems = {};

window.addEventListener('message', function(event){
	var mainElem = document.getElementById("background");
	var item = event.data;
	if (item.display === true) {
		mainElem.style.visibility = "visible";
	} else if (item.display === false) {
		mainElem.style.visibility = "hidden";
	} else if (item.type == 'add_item') {
		addCalls(item.player, item.freq)
	} else if (item.type == 'clear_items') {
		removeAll();
	}
});

window.addEventListener("keydown", function (event) {

	if (event.defaultPrevented) {
		return; // Do nothing if the event was already processed
	}

	switch (event.key) {
		case "Esc":
		case "Escape":
			removeAll();
			fetch(`https://${GetParentResourceName()}/NUIFocusOff`, {
    			method: 'POST'	
  			});
		  break;
		case "Backspace":
			removeAll();
			fetch(`https://${GetParentResourceName()}/NUIFocusOff`, {
    			method: 'POST'	
  			});
			break;
		default:
		  return;
	}
	event.preventDefault();
}, true);

function testFunct() {
	console.log('test');
}

var activeCalls = document.getElementById('activeCallsMenu');
var scanButton = document.getElementById('scanCallsButton');
var connectButton = document.getElementById('connectCallButton');
var disconnectButton = document.getElementById('disconnectCallButton');

if(connectButton) {
	connectButton.addEventListener('click', function() {
		//console.log(activeCalls.value);
		$.post(`https://${GetParentResourceName()}/SetCall`, JSON.stringify({
    		phoneFreq: activeCalls.value
  		}));
	});
}

if(disconnectButton) {
	disconnectButton.addEventListener('click', function() {
		$.post(`https://${GetParentResourceName()}/SetCall`, JSON.stringify({
    		phoneFreq: 0
  		}));
	});
}

if(scanButton) {
	scanButton.addEventListener('click', function() {
		removeAll();
		fetch(`https://${GetParentResourceName()}/WantCalls`, {
    		method: 'POST'	
  		});
	})
}

function addCalls(player, freq) {
	var option = document.createElement("option");
	option.value = freq;
	option.text = "Frequency: " + freq + "Mhz";
	activeCalls.appendChild(option);
}

function removeAll() {
	while (activeCalls.options.length > 0) {
		activeCalls.remove(0);
	}
}

