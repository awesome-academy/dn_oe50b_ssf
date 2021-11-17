var countClick = 0;
$(document).ready(function() {
  $('.reply').click(function() {
    countClick++;
    if(countClick % 2 === 1) {
      $('.comment-child').show()
    }else {
      $('.comment-child').hide()
    }
  })
}
