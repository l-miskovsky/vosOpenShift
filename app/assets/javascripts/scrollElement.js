//credits to http://jqueryfordesigners.com/index.html%3Fp=214.html

$(document).ready(function () {
    var top = $('#menu').offset().top - parseFloat($('#menu').css('marginTop').replace(/auto/, 0));
    $(window).scroll(function (event) {
        // what the y position of the scroll is
        var y = $(this).scrollTop();

        if (y >= top)
            $('#menu').addClass('fixed');
        else
            $('#menu').removeClass('fixed');
    });
});