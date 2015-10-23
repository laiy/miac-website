$(function() {
  var length = $(".page-button").length,
        tag = url('?tag'),
        page = url('?page');
    if (tag == null) tag = '';
    if (page == null) page = "1";
    page = parseInt(page);
    if (page > 1) {
        $('#prev-page').find('a').attr("href", "/Album?page=" + (page - 1) + "&tag=" + tag);
    } else {
        $('#prev-page').find('a').attr("href", "#");
    }
    if (page < length) {
        $('#next-page').find('a').attr("href", "/Album?page=" + (page + 1) + "&tag=" + tag);
    } else {
        $('#next-page').find('a').attr("href", "#");
    }
    $(".page-button").each(function() {
        var num = $(this).find('a').text();
        $(this).find('a').attr("href", "/Album?page=" + num + "&tag=" + tag);
        if (parseInt(num) == page) {
            $(this).addClass('chosen-page');
        } else {
            $(this).removeClass('chosen-page');
        }
    });
});

