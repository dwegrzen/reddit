
$(document).ready(function(){
  $('#new_comment').on('submit', function(ev){
    ev.preventDefault()
    alert(alert)
    $.post({
      url: $(ev.target).attr('action'),
      data: new FormData(ev.target),
      processData: false,
      contentType: false,
      success: function(data) {
        $('#maincomment').prepend('<div class="row comment"><div class="col-sm-12" id="comment-' + data.id + '"><blockquote>' + data.body + '<footer> by ' + data.username + ' on ' + data.created_at + '</footer></blockquote></div></div>')
        document.getElementById('new_comment').reset()
        $('#new_addendum input[type="submit"]').prop('disabled', false);
      }
    })
  })


})
