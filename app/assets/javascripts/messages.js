$(document).ready(function(){
  $(document).on('click', '.heading-compose', function() {
    $('.side-two').css({
      'left': '0'
    });
  });

  $(document).on('click', '.newMessage-back', function() {
    $('.side-two').css({
      'left': '-100%'
    });
  });
})
