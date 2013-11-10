function getPreloader() {
    return "<img src='/images/preloader.gif'>";
}

$(document).ready(function() {
    $("#wrapper").on("click", ".js-login", function(e) {
        e.preventDefault();

        var login = $(".js-user-login").val(),
            password = $(".js-user-password").val();

        if(!login || !password) {
            $(".js-login-errors").html("Input required fields");
            return false;
        }

        $.ajax({
            type: 'POST',
            url: '/login.json',
            dataType: 'json',
            data: {go_login: "true", login: login, password: password},
            beforeSend: function() {
                $(".js-login-errors").html(getPreloader());
            }
        }).done(function(json) {
                if(json.redirect) {
                    document.location = json.redirect;
                } else {
                    $(".js-login-errors").html(json.error);
                }
        }).fail(function(json) {
            document.location = "/login";
        });

        return false;
    }).on("click", ".js-signup", function(e) {
        e.preventDefault();

        var login = $(".js-user-login-signup").val(),
            password = $(".js-user-password-signup").val(),
            password_again = $(".js-user-password-again-signup").val(),
            birthday = $(".js-user-birthday-signup").val();

        if(!login || !password || !password_again || !birthday) {
            $(".js-signup-errors").html("Input all required fields!");

            return false;
        }

        if(password != password_again) {
            $(".js-signup-errors").html("Password are not equal");

            return false;
        }

        if(!birthday.match(/([\d]{4})[^\d]([\d]{2})[^\d]([\d]{2})/)) {
            $(".js-signup-errors").html("Wrong birthday");

            return false;
        }

        $.ajax({
            type: 'POST',
            url: '/signup.json',
            dataType: 'json',
            data: {go_signup: "true", login: login, password: password, password_again: password_again, birthday: birthday},
            beforeSend: function() {
                $(".js-signup-errors").html(getPreloader());
            }
        }).done(function(json) {
                if(json.redirect) {
                    document.location = json.redirect;
                } else {
                    $(".js-signup-errors").html(json.error);
                }
            }).fail(function(json) {
                document.location = "/login";
            });

        return false;
    });
});