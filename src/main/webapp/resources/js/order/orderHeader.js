$(document).ready(function(){

	// 메뉴 버튼
	$('#orderHeader>#menuContainer>div.menuBox').on('click', (e)=>{
		var buttons = $('#orderHeader>#menuContainer>div.menuBox');
		var menuButton = $(e.target).attr('id');
		console.log(menuButton);
		
		$(buttons).attr('style', 'border: none;');
		$('#'+menuButton).attr('style', 'border-bottom: 1px solid #00704a;');
		
		$.ajax({
			url: path + '/order/orderMenu.do',
			type: 'POST',
			data: {'menuButton': menuButton},
			success: (data)=>{
				$('.menuListContainer').html('');
				$('.menuListContainer').append(data);			
			}
		});
		
		$('#menuOption').animate({scrollTop: 0}, 500);
	});
});
