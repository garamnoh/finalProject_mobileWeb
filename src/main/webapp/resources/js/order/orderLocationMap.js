/* js_주문화면 매장정보 지도 */
///////////////////
// 페이지 처리 관련 변수
var page = 1;
var type;
var keyword;
var btnOrScroll;

// 지도에 표시할 스토어 리스트
var storeList;
var generalPosition = [];
var generalName = [];
var dtPosition = [];
var dtName = [];
var reservePosition = [];
var reserveName = [];
var infoWindows = [];

var homeLatitude = $('#homeLatitude').val();
var homeLongitude = $('#homeLongitude').val();
var myPosition = [new kakao.maps.LatLng(homeLatitude, homeLongitude)];
///////////////////

$(document).ready(function(){
	page = 1;
	type = 'all',
	btnOrScroll = "btn";
	keyword = $('#searchStoreInput').val();

	$.ajax({
		url: path + '/store/orderLocationMap.do',
		data: {
			'page': page,
			'type': type,
			'keyword': keyword
		},
		success: (data)=>{
			storeList = data;
			
			// 스토어 정보 타입별로 리스트 정리 (general, dt, reserve)
			$.each(storeList, function(i, e){
				var location = new kakao.maps.LatLng(e.locationLat, e.locationLng);
				if(e.type == 'general') {generalPosition.push(location); generalName.push(e.storeName);}
				else if(e.type == 'dt') {dtPosition.push(location); dtName.push(e.storeName);}
				else {reservePosition.push(location); reserveName.push(e.storeName);}
			});
			console.log("storeList :", storeList);
			getCenterCoordinate(storeList);
		}
	});
	if(keyword == '' && type == 'all') map.setLevel(6);
	else map.setLevel(8);
		
	setTimeout(function(){
		createMarkers();
		setMarkers(map);
	}, 500);
	
	// 페이지 리로드
	setTimeout(function(){
		map.relayout();
	}, 100);
});

// 지도 정보
var container = document.getElementById('map');
var option = {
	center: new kakao.maps.LatLng(homeLatitude, homeLongitude),
	level: 5,
};

// 첫 화면 위치
var map = new kakao.maps.Map(container, option);

// 종류별 마커 배열
var generalMarkers = [];
var dtMarkers = [];
var reserveMarkers = [];
var myMarkers = [];

// 마커 이미지 경로
var markerGeneralImageSrc = path + '/resources/image/etc/map_marker_general.png';
var markerDtImageSrc = path + '/resources/image/etc/map_marker_dt.png';
var markerReserveImageSrc = path + '/resources/image/etc/map_marker_reserve.png';
var markerMyImageSrc = path + '/resources/image/etc/map_marker_my.png';

// 마커 이미지 사이즈
var markerImageSize = new kakao.maps.Size(50, 50);
var markerMyImageSize = new kakao.maps.Size(25, 25);



// 가게 타입 선택 (all, dt, reserve)
$('#selectButtons>div.button').on('click', (e)=>{
	setMarkers(null);
	keyword = $('#searchStoreInput').val();

	// 배열 초기화 ///////////
	generalPosition = [];
	dtPosition = [];
	reservePosition = [];
	generalMarkers = [];
	dtMarkers = [];
	reserveMarkers = [];
	myMarkers = [];
	
	generalName = [];
	dtName = [];
	reserveName = [];
	infoWindows = [];
	///////////////////////
	
	var mapOrMenu = $('#mapOrMenu').val();
	
	var btnOrScroll = "btn";
	var storeButton = $(e.target).attr('id');
	switch(storeButton){
		case 'all': 
			type='all';
			$('#selectButtons>div').removeClass('selected');
			$('#selectButtons>div#all').addClass('selected');
			if(mapOrMenu == 'map') {
				if(keyword=='') getStoreListForMapCenter(page, btnOrScroll);
				else getStoreListForMap(page, btnOrScroll);
				setTimeout(function(){
					createMarkers();
					setMarkers(map);
					map.relayout();
				}, 500);
			}
			break;
		case 'dt':
			type='dt';
			$('#selectButtons>div').removeClass('selected');
			$('#selectButtons>div#dt').addClass('selected');
			if(mapOrMenu == 'map') {
				if(keyword=='') getStoreListForMapCenter(page, btnOrScroll);
				else getStoreListForMap(page, btnOrScroll);
				setTimeout(function(){
					createMarkers();
					setMarkers(map);
					map.relayout();
				}, 500);
			}
			break;
		case 'reserve':
			type='reserve';
			$('#selectButtons>div').removeClass('selected');
			$('#selectButtons>div#reserve').addClass('selected');
			if(mapOrMenu == 'map') {
				if(keyword=='') getStoreListForMapCenter(page, btnOrScroll);
				else getStoreListForMap(page, btnOrScroll);
				setTimeout(function(){
					createMarkers();
					setMarkers(map);
					map.relayout();
				}, 500);
			}
			break;
	}
});


// 검색 버튼
$('#searchStoreInputButton').on('click', ()=>{
	setMarkers(null);

	// 배열 초기화 ///////////
	generalPosition = [];
	dtPosition = [];
	reservePosition = [];
	generalMarkers = [];
	dtMarkers = [];
	reserveMarkers = [];
	myMarkers = [];
	
	generalName = [];
	dtName = [];
	reserveName = [];
	infoWindows = [];
	///////////////////////
	var mapOrMenu = $('#mapOrMenu').val();

	type = $('#selectButtons>div.selected').attr('id');
	var btnOrScroll = "btn";
	
	if(mapOrMenu == 'map') {
		getStoreListForMap(page, btnOrScroll);
		setTimeout(function(){
			createMarkers();
			setMarkers(map);
			map.relayout();
		}, 500);
	}
});


// 중심좌표 변경시 지도 정보 받아오기
kakao.maps.event.addListener(map, 'center_changed', function(){var latlng = map.getCenter(); $('#latitude').val(latlng.getLat()); $('#longitude').val(latlng.getLng());});


// 현재 위치에서 가까운 매장 검색
$('#searchCurrentLocation').on('click', ()=>{
	setMarkers(null);
	$('#searchStoreInput').val('');

	// 배열 초기화 ///////////
	generalPosition = [];
	dtPosition = [];
	reservePosition = [];
	generalMarkers = [];
	dtMarkers = [];
	reserveMarkers = [];
	myMarkers = [];
	
	generalName = [];
	dtName = [];
	reserveName = [];
	infoWindows = [];
	///////////////////////
	
	getStoreListForMapCenter(page, btnOrScroll);
	setTimeout(function(){
		createMarkers();
		setMarkers(map);
		map.relayout();
	}, 500);
});




/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// functions ////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// 지도에 표시할 스토어 정보 가져오기
function getStoreListForMap(page, btnOrScroll){
	keyword = $('#searchStoreInput').val();

	map.setLevel(6);
	$.ajax({
		url: path + '/store/orderLocationMap.do',
		data: {
			'page': page,
			'type': type,
			'keyword': keyword
		},
		success: (data)=>{
			storeList = data;
			if(storeList.length == 0) alert("현재 위치 반경 3km 내에 검색결과가 없습니다");
			else{
				// 스토어 정보 타입별로 리스트 정리 (general, dt, reserve)
				$.each(storeList, function(i, e){
					var location = new kakao.maps.LatLng(e.locationLat, e.locationLng);
					if(e.type == 'general') {generalPosition.push(location); generalName.push(e.storeName);}
					else if(e.type == 'dt') {dtPosition.push(location); dtName.push(e.storeName);}
					else {reservePosition.push(location); reserveName.push(e.storeName);}
				});
				console.log("storeList :", storeList);
				getCenterCoordinate(storeList);
			}
		}
	});
	if(keyword == '' && type == 'all') map.setLevel(6);
	else map.setLevel(8);
}

// 지도에 표시할 스토어 정보 가져오기 (수정된 로케이션)
function getStoreListForMapCenter(page, btnOrScroll){
	keyword = $('#searchStoreInput').val();
	
	var latitude = $('#latitude').val();
	var longitude = $('#longitude').val();
	
	$.ajax({
		url: path + '/store/orderLocationMapCenter.do',
		data: {
			'page': page,
			'type': type,
			'latitude': latitude,
			'longitude': longitude,
			'keyword': keyword
		},
		success: (data)=>{
			storeList = data;
			if(storeList.length == 0) alert("현재 위치 반경 3km 내에 검색결과가 없습니다");
			else{
				// 스토어 정보 타입별로 리스트 정리 (general, dt, reserve)
				$.each(storeList, function(i, e){
					var location = new kakao.maps.LatLng(e.locationLat, e.locationLng);
					if(e.type == 'general') {generalPosition.push(location); generalName.push(e.storeName);}
					else if(e.type == 'dt') {dtPosition.push(location); dtName.push(e.storeName);}
					else {reservePosition.push(location); reserveName.push(e.storeName);}
				});
				console.log("storeList :", storeList);
				getCenterCoordinate(storeList);
			}
		}
	});
	if(keyword == '' && type == 'all') map.setLevel(6);
	else map.setLevel(8);
}


// function : 이미지 생성 및 리턴
function createMarkerImage(src, size){
	var markerImage = new kakao.maps.MarkerImage(src, size);
	return markerImage;
}

// function : 마커 생성 및 리턴
function createMarker(position, image){
	var marker = new kakao.maps.Marker({
		position: position,
		image: image,
		clickable: true
	});
	return marker;
}

// function : 인포윈도우
function createInfoWindow(iwContent, iwPosition){
	infoWindow = new kakao.maps.InfoWindow({
		position: iwPosition,
		content: "<a href=path + '/store/storeInfo.do' style='color:black;font-size:12px;'>" + iwContent + "</a>"
	});
}

// function : 마커 생성
function createMarkers(){
	for(var i = 0; i < myPosition.length; i++){
		var markerImage = createMarkerImage(markerMyImageSrc, markerImageSize);
		var marker = createMarker(myPosition[i], markerImage);
		
		myMarkers.push(marker);
	}
	for(var i = 0; i < generalPosition.length; i++){
		var markerImage = createMarkerImage(markerGeneralImageSrc, markerImageSize);
		var marker = createMarker(generalPosition[i], markerImage);
		
		//createInfoWindow(generalName[i], generalPosition[i]);
		kakao.maps.event.addListener(marker, 'click', clickEventListener(generalName[i]));
	
		generalMarkers.push(marker);
	}
	for(var i = 0; i < dtPosition.length; i++){
		var markerImage = createMarkerImage(markerDtImageSrc, markerImageSize);
		var marker = createMarker(dtPosition[i], markerImage);
		
		//createInfoWindow(dtName[i], dtPosition[i]);
		kakao.maps.event.addListener(marker, 'click', clickEventListener(dtName[i]));
		
		dtMarkers.push(marker);
	}
	for(var i = 0; i < reservePosition.length; i++){
		var markerImage = createMarkerImage(markerReserveImageSrc, markerImageSize);
		var marker = createMarker(reservePosition[i], markerImage);
		
		//createInfoWindow(reserveName[i], reservePosition[i]);
		kakao.maps.event.addListener(marker, 'click', clickEventListener(reserveName[i]));
	
		reserveMarkers.push(marker);
	}
}

// function : 마커 클릭 이벤트
function clickEventListener(store){
	return function(){
		$.ajax({
			url: path + '/store/storeInfo.do',
			data: {'store': store},
			success: (data)=>{
				$('#locationText').html(data['storeName']);
			}
		});
	}
}

// function : 마커 지도에 표시
function setMarkers(map){
	for(var i = 0; i < myMarkers.length; i++) myMarkers[i].setMap(map);
	for(var i = 0; i < generalMarkers.length; i++) generalMarkers[i].setMap(map);
	for(var i = 0; i < dtMarkers.length; i++) dtMarkers[i].setMap(map);
	for(var i = 0; i < reserveMarkers.length; i++) reserveMarkers[i].setMap(map);
}


// 마커들의 중심 좌표로 이동
function getCenterCoordinate(list){
	console.log("getCenterCoordinate");
	// 위도, 경도의 최대값 및 최소값
	var maxLatitude = 0;
	var minLatitude = 0;
	var maxLongitude = 0;
	var minLongitude = 0;

	var tempLatitude = 0;
	var tempLongitude = 0;
	$.each(list, function(i, e){
		tempLatitude = e.locationLat;
		if(i == 0) minLatitude = e.locationLat;
		if(maxLatitude <= tempLatitude) maxLatitude = tempLatitude;
		if(minLatitude >= tempLatitude) minLatitude = tempLatitude;
		
		tempLongitude = e.locationLng;
		if(i == 0) minLongitude = e.locationLng;
		if(maxLongitude <= tempLongitude) maxLongitude = tempLongitude;
		if(minLongitude >= tempLongitude) minLongitude = tempLongitude;
	});
	
	console.log("maxLat :", maxLatitude);
	console.log("minLat :", minLatitude);
	console.log("maxLng :", maxLongitude);
	console.log("minLng :", minLongitude);
	
	// 중심 좌표 계산
	var centerLatitude = (maxLatitude*1 + minLatitude*1) / 2;
	var centerLongitude = (maxLongitude*1 + minLongitude*1) / 2;
	console.log("centerLat :", centerLatitude);
	console.log("centerLng :", centerLongitude);
	
	// 이동
	map.panTo(new kakao.maps.LatLng(centerLatitude, centerLongitude));
}