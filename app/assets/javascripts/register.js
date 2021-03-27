$(document).ready(function() {
    let $input_pw = $("#input-pw");
    let $input_pw_confirm = $("#input-pw-confirm");
    let $warning_confirm = $("#warning-confirm");

    let is_pw_same = false;

    function check_pw() {
        return $input_pw_confirm.val() !== "" && $input_pw.val() === $input_pw_confirm.val();
    }

    function check_button() {
        $("#btn-submit").prop("disabled", !is_pw_same);
    }

    function on_input() {
        is_pw_same = check_pw();
        if (!is_pw_same) {
            $warning_confirm.removeClass("is-hidden");
            $input_pw_confirm.addClass("is-danger");
        } else {
            $warning_confirm.addClass("is-hidden");
            $input_pw_confirm.removeClass("is-danger");
        }
        check_button();
    }

    check_button();

    $input_pw_confirm.on("input", on_input);
    $input_pw.on("input", on_input);
})
