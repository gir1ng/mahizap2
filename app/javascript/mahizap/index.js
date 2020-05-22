$(document).on('turbolinks:load', function() {
        $('#zero').fadeIn(4000);

        
        if (this.location.href == 'https://mahizap2.herokuapp.com/' || this.location.href == 'http://localhost:3000/') {
                $('#main-menu ul li').hide();
                $('#header_title').hide();
                $('#header_title').delay(3000).fadeIn(700);

                $('#main-menu ul li').each(function(i) {
                        $(this).delay(3700 + (700 * i)).fadeIn(700);
                });
        }
});