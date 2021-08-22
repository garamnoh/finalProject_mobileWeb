///////////////////
// Google chart API
///////////////////

// 회원 정보 중 리워드 확인
// 변수 설정
var stars = $('#chartStars').val() * 1;
var membership = $('#chartMembership').val();

var color;
var maxValue;
if(membership == 'welcome') { maxValue=5; color='#000000'; }
else if(membership == 'green') { maxValue=25; stars=stars-5; color='#00704A'; }
else { maxValue = 12; stars=stars-30; color='#CCC050'; }

var remain = maxValue * 1 - stars;

// 콘솔 확인
console.log("stars :", stars);
console.log("membership :", membership);
console.log("maxValue :", maxValue);
console.log("remain :", remain);
console.log("color :", color);

// Load the Visualization API and the corechart package.
google.charts.load('current', {'packages':['corechart']});

// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawChart);

// Callback that creates and populates a data table,
// instantiates the pie chart, passes in the data and draws it.
function drawChart() {
	
	// Create the data table.
	// 테이블 column, row 생성 및 설정
	var data = new google.visualization.arrayToDataTable([
		['', 'stars', 'remain', {role: 'none'}],
		['', stars, remain, '']
	]);
	
	// chart 옵션 설정
	var options = {
		legend: 'none',
	    hAxis: {
	    	baseline: 0,
	    	baselineColor: 'white',
	        minValue: 0,
	        maxValue: maxValue,
	        viewWindow: {
	        	min: 0,
	        	max: maxValue,
	        },
	        ticks: [0],
	        textPosition: 'none',
        },
	    vAxis:{
	    	gridlines: {
	    		color: '#ffffff'
	    	},
	    },
	    chartArea:{left:0,top:0,width:'100%',height:'100%'},
	    colors: [color, '#dddcdc'],
	    fontSize: 0,
	    isStacked: true,
	    tooltip: {
	    	trigger: 'none'
	    },
	    enableInteractivity: false,
	    animation: {
	    	duration: 1000,
	    	easing: 'out',
	    	startup: true
	    }
	};
	
	// 테이블 생성 -> 화면
	var table = new google.visualization.BarChart(document.getElementById('chart'));
    table.draw(data, options);
}


/////////////////
// 새로운 메뉴 데이터
// 공지사항 데이터
/////////////////

// 실행
$(document).ready(function(){
	newProductList();
	getFavoriteList();
});


//////////////////////////////////////////////
////////////
// function
////////////

// function: 새로운 메뉴 리스트 요청
function newProductList() {
	$.ajax({
		url: path + '/home/newProductList.do',
		success: (data)=>{
			$('#scrollBox').html('');
			$('#scrollBox').append(data);
		}
	});
}

// function: favorite 메뉴 리스트 요청
function getFavoriteList() {
	$.ajax({
		url: path + '/favorite/getFavoriteList.do',
		success: (data)=>{
			$('#addDiv').html('');
			$('#addDiv').append(data);
		}
	});
}

// function: rewards 정보 요청
function getRewardsInfo() {
	$.ajax({
		url: path + 'member/getRewardsInfo',
	});
}

// function: 공지사항 리스트 요청
function noticeList(){}

///////////////////////////////////////////////