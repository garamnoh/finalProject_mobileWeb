/* js_other화면 결제내역 */
// 오늘 날짜부터 3개월 기본 설정
$(document).ready(function(){
	new Promise(function(resolve, reject){
		var defaultStartDate = new Date();
		defaultStartDate.setMonth(defaultStartDate.getMonth()-3);
		var defaultEndDate = new Date();
		$('#startDate').val(defaultStartDate.toISOString().substring(0, 10));
		$('#endDate').val(defaultEndDate.toISOString().substring(0, 10));
		
		resolve();
	}).then(function(param){ searchOrderList(); });
});

// 날짜 조회
$('#historySearchContainer>input').on('change', (e)=>{ searchOrderList(); });

////////////////////////
// function
////////////////////////
// 이용 내역 조회	
function searchOrderList(){
	var startDate = $('#startDate').val();
	var endDate = new Date($('#endDate').val());
	endDate.setDate(endDate.getDate()+1);
	endDate = endDate.toISOString().substring(0,10);

	$.ajax({
		url: path + '/other/getOrderList.do',	
		type: 'post',
		data: {
			'startDate': startDate,
			'endDate': endDate
		},
		success: (data)=>{
			$('#historyResultContainer').html(data);
		}
	});
}