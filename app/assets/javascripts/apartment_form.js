$(document).ready(function() {
    let $input_price = $("#input-price");
    let $input_ap_name = $("#input-aptmt-name");
    let $input_addr = $("#input-addr");

    let valid_price = !!$input_price.val().match(/^\d+$/);
    let valid_name = !!$input_ap_name.val().match(/^\w[\w ,.]*$/);
    let valid_addr = !!$input_addr.val().match(/^\w[\w ,.#$@*()\-+]*$/);

    function is_all_valid() {
        return valid_addr && valid_name && valid_price;
    }

    function check_button() {
        $("#btn-save").prop("disabled", !is_all_valid());
    }

    check_button();

    $input_price.on("input", function() {
        if (!$(this).val().match(/^\d+$/)) {
            $("#warning-price").removeClass("is-hidden");
            $input_price.addClass("is-danger");
            valid_price = false;
        } else {
            $input_price.removeClass("is-danger");
            $("#warning-price").addClass("is-hidden");
            valid_price = true;
        }
        check_button();
    });
    $input_ap_name.on("input", function() {
        if (!$(this).val().match(/^\w[\w ,.]*$/)) {
            $input_ap_name.addClass("is-danger");
            $("#warning-aptmt-name").removeClass("is-hidden");
            valid_name = false;
        } else {
            $input_ap_name.removeClass("is-danger");
            $("#warning-aptmt-name").addClass("is-hidden");
            valid_name = true;
        }
        check_button();
    });
    $input_addr.on("input", function () {
        if (!$(this).val().match(/^\w[\w ,.#$@*()\-+]*$/)) {
            $input_addr.addClass("is-danger");
            $("#warning-addr").removeClass("is-hidden");
            valid_addr = false;
        } else {
            $input_addr.removeClass("is-danger");
            $("#warning-addr").addClass("is-hidden");
            valid_addr = true;
        }
        check_button();
    });
});
