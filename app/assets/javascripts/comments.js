
$(document).ready(function(){
  $('#new_comment').on('submit', function(ev){
    ev.preventDefault()
    $.post({
      url: $(ev.target).attr('action'),
      data: new FormData(ev.target),
      processData: false,
      contentType: false,
      success: function(data) {
        $('#maincomment').prepend('<div class="row comment"><div class="col-sm-12" id="comment-' + data.id + '"><blockquote>' + data.body + '<footer> by ' + data.username + ' on ' + moment(data.created_at).format("MMM D, h:mm A") + '</footer></blockquote></div></div>')
        document.getElementById('new_comment').reset()
        $('#new_addendum input[type="submit"]').prop('disabled', false);
      }
    })
  })


})
