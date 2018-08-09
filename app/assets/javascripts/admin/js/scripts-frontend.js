$(document).ready(function() {
	/* ScrollTo */
	$('a.scrollto').on('click', function(e){
		var targetID = $(this).attr('href');

		var firstCharacter = targetID.slice(0,1);

		if(firstCharacter == '#'){
			$("html, body").animate({
				scrollTop: $(targetID).offset().top
			}, 2000, "easeOutCubic");

			e.preventDefault();
		}
	});
});
