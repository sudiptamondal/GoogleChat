$(document).on('click', "#submit_message", function() {
  
  $.ajax({
    url: '/static/chat',
    type: 'post',
    beforeSend: function() {
      $("#spinningSquaresG").show();
    },
    data: {
      user: {
        email: $("input[name='user[email]']").val(),
        password: $("input[name='user[password]']").val()
      },
      receiver: {
        email: $("input[name='receiver[email]']").val(),
        message: $("textarea[name='receiver[message]']").val()
      }
    },
    complete: function() {
      $("#spinningSquaresG").hide();
    }
  })
})

var interval = setInterval(function() {
  $.ajax({
    url: '/static/reply'
  })
}, 4000)