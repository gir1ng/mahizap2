$(document).on('turbolinks:load', function() {

    $(".checklist").change(function() {
        if ($('input:checkbox:checked').length != 0) {
            $("#point_btn").removeClass("disabled");
        } else {
            $("#point_btn").addClass("disabled");
        }
    })  

});