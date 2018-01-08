$(document).ready(function(){
	$('.delete-art').on('click', function(e){
		$target = $(e.target);
		const id = $target.attr('data-id');
		$.ajax({
			type:'DELETE',
			url: '/article/'+id,
			success : function(res)
			{
				alert('deleteing article');
				window.location.href = '/';
			},
			error : function(err)
			{
				console.log(err);
			}
		});
	});
});