/* js_주문화면 매장정보 메뉴 */
///////////////////
// 페이지 처리 관련 변수
var page = 1;
var type;
var keyword;
var btnOrScroll;
///////////////////


// 페이지 로딩 후 store list 불러오기
$(document).ready(function(){
	keyword = $('#searchStoreInput').val();
	$.ajax({
		url: path + '/store/orderLocationMenu.do',
		data: {
			'page': 1, 
			'keyword': keyword
		},
		success: (data)=>{
			$('#searchResultContainer').html('');
			$('#searchResultContainer').append(data);
		}
	});
	// 기본 검색 설정
	$('#selectButtons>div#all').addClass('selected');
});


// 추가로 가게 정보 10개씩 더 가져오기
function getStoreList(page, btnOrScroll){
	keyword = $('#searchStoreInput').val();
			
	$.ajax({
		url: path + '/store/orderLocationMenu.do',
		data: {
			'page': page,
			'type': type,
			'keyword': keyword
		},
		success: (data)=>{
			if(btnOrScroll == 'scroll') $('#searchResultContainer').append(data);
			else {
				$('#searchResultContainer').html('');
				$('#searchResultContainer').append(data);
			}
		}
	});
}

// 스크롤 이벤트 -> 페이징처리
$('#searchResultContainer').scroll(function(){
	btnOrScroll = "scroll";
	
	var scrollT = $(this).scrollTop();
	var scrollH = $(this).height();
	var contentH = document.getElementById('searchResultContainer').scrollHeight;
	
//	console.log(scrollT);
//	console.log(scrollH);
//	console.log(contentH);
		
	if(scrollT + scrollH == contentH){
		page++;
		getStoreList(page, btnOrScroll);
		console.log("///////", page);
	}
});


// 가게 타입 선택 (all, dt, reserve)
$('#selectButtons>div.button').on('click', (e)=>{
	var mapOrMenu = $('#mapOrMenu').val();
	
	// page초기화 & scroll 최상단
	page = 1;
	$('#searchResultContainer').animate({scrollTop: 0}, 500);

	var btnOrScroll = "btn";
	var storeButton = $(e.target).attr('id');
	switch(storeButton){
		case 'all': 
			type='all';
			$('#selectButtons>div').removeClass('selected');
			$('#selectButtons>div#all').addClass('selected');
			if(mapOrMenu == 'menu')	getStoreList(page, btnOrScroll);
			break;
		case 'dt':
			type='dt';
			$('#selectButtons>div').removeClass('selected');
			$('#selectButtons>div#dt').addClass('selected');
			if(mapOrMenu == 'menu') getStoreList(page, btnOrScroll);
			break;
		case 'reserve':
			type='reserve';
			$('#selectButtons>div').removeClass('selected');
			$('#selectButtons>div#reserve').addClass('selected');
			if(mapOrMenu == 'menu') getStoreList(page, btnOrScroll);
			break;
	}
});


// 검색 버튼
$('#searchStoreInputButton').on('click', ()=>{
	var mapOrMenu = $('#mapOrMenu').val();

	// page초기화 & scroll 최상단
	page = 1;
	$('#searchResultContainer').animate({scrollTop: 0}, 500);
	
	type = $('#selectButtons>div.selected').attr('id');
	
	var btnOrScroll = "btn";
	
	if(mapOrMenu == 'menu') getStoreList(page, btnOrScroll);
});


// enter키 (검색시 엔터키 사용)
$('#searchStoreInput').on('keyup', (e)=>{
	if(e.keyCode == 13) $('#searchStoreInputButton').trigger('click');
});


// 메뉴버튼 클릭 -> 메뉴 화면으로 전환
$('#searchStoreMenuImg').on('click', ()=>{
	$('#mapOrMenu').val('menu');

	page = 1;
	btnOrScroll = "btn";
	
	getStoreList(page, btnOrScroll);

	// 아이콘 변경 : 메뉴 -> 지도
	$('#searchStoreMapImg').show();
	$('#searchStoreMenuImg').hide();
});


// 지도버튼 클릭 -> 지도 화면으로 전환
$('#searchStoreMapImg').on('click', ()=>{
	$('#mapOrMenu').val('map');
	$.ajax({
		url: path + '/store/orderLocationMapPage.do',
		success: (data)=>{
			$('#searchStoreMapImg').hide();
			$('#searchStoreMenuImg').show();
			
			$('#searchResultContainer').html('');
			$('#searchResultContainer').append(data);
		}
	});
});