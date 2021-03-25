function word_count(str) {
    return str.split(' ').filter(function(el) {return el.length !== 0}).length;
}

$(document).ready(function() {
    let $input_rating = $("#input-rating");
    let $warning_rating = $("#warning-rating");
    let $input_comment = $("#input-comment");
    let $warning_comment = $("#warning-comment");

    let valid_rating = $input_rating.val().match(/^0*(?:[1-9][0-9]?|100)$/);
    let comment_word_count = word_count($input_comment.val());

    function check_button() {
        $("#btn-submit").prop("disabled", !(valid_rating && comment_word_count > 50));
    }

    function check_comment() {
        comment_word_count = word_count($input_comment.val());
        if (comment_word_count > 50) {
            $warning_comment.addClass("is-hidden");
        } else {
            $warning_comment.removeClass("is-hidden");
            $warning_comment.text(`You need ${50 - comment_word_count} more words to comment.`);
        }
    }

    check_comment();
    check_button();

    $input_rating.on("input", function() {
        if ($(this).val().match(/^0*(?:[1-9][0-9]?|100)$/)) {
            $warning_rating.addClass("is-hidden");
            $(this).removeClass("is-danger");
            valid_rating = true;
        } else {
            $warning_rating.removeClass("is-hidden");
            $(this).addClass("is-danger");
            valid_rating = false;
        }
        check_button();
    });
    $input_comment.on("input", check_comment);
});
