// home 접속시 homeBtn focusing
$(document).ready(function(){
	var navButton = $('#navButton').val();
	var navContainer = '#navBarcontainer>#';
	
	$(navContainer + navButton).addClass('focused');
});

// 페이지 이동 및 버튼 focusing
$('#navBarContainer>.iconBox').on('click', (e)=>{
	var button = $(e.target).attr('id');
	
	// 페이지 이동
/*	$.ajax({
		url: path + '/navigation/' + button + '.do',
		success: (data)=>{
			$('#container').html('');
			$('#container').append(data);
		}
	}); */
	
	location.assign(path + "/navigation/" + button + ".do");

	// 버튼 focusing
/*	$('#navBarContainer>.iconBox').removeClass('focused');
	$('#navBarContainer>#'+button).addClass('focused'); */
});