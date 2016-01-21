var SlackApiExplorer = {};

$(document).ready(function() {

  SlackApiExplorer.message = function(text) {
    $('#messages').fadeOut('slow', function() {
      $('#messages').fadeIn('slow').html(text)
    });
  };

  SlackApiExplorer.error = function(xhr) {
    try {
      var message;
      if (xhr.responseText) {
        var rc = JSON.parse(xhr.responseText);
        if (rc && rc.message) {
          message = rc.message;
          if (message == 'invalid_code') {
            message = 'The code returned from the OAuth workflow was invalid.'
          } else if (message == 'code_already_used') {
            message = 'The code returned from the OAuth workflow has already been used.'
          }
        }
      }

      SlackApiExplorer.message(message || xhr.statusText || xhr.responseText || 'Unexpected Error');

    } catch(err) {
      SlackApiExplorer.message(err.message);
    }
  };

  // Slack OAuth
  var code = $.url('?code')
  if (code) {
    SlackApiExplorer.message('Working, please wait ...');
    $('#register').hide();
    $.ajax({
      type: "POST",
      url: "/api/teams",
      data: {
        code: code
      },
      success: function(data) {
        SlackApiExplorer.message('Team successfully registered!<br><br>DM <b>@api</b> or create a <b>#channel</b> and invite <b>@api</b> to it.');
      },
      error: SlackApiExplorer.error
    });
  }
});
