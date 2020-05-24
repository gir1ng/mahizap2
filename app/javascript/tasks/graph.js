$(document).on('turbolinks:load', function() {
    $("#top_secret_btn").click(function(){
        var password = prompt('閲覧するにはパスワードが必要です');
        if (password) {
            window.location.href = '/secrets?password=' + password;
        } else {
            return   
        }
      });

});