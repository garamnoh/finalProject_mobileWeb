const path1 = $('#path').val();

let sock = new SockJS('http://rclass.iptime.org:9999/21PM_STARBUCKS_final/webSocket');

$(document).ready(function(){
	sock.onopen = (e)=>{
		console.log(e);
	}
});

sock.onmessage = (e)=>{

}

sock.onclose = (e)=>{
	
}