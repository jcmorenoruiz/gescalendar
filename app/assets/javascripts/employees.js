
$(function() { 
    //Set default open/close settings
    var divs=$('.accordion>div').hide(); //Hide/close all containers

    var h2s=$('.accordion>h4').click(function () {
        h2s.not(this).removeClass('active')
        $(this).toggleClass('active')
        divs.not($(this).next()).slideUp()
        $(this).next().slideToggle()
        return false; //Prevent the browser jump to the link anchor

    });


});