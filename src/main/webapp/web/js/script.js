jQuery(function ($) {
    $('[role="datetimepicker"]').datetimepicker({
        pickSeconds: false,
        pick12HourFormat: false
    });
    $('[role="datepicker"]').datetimepicker({
        pickTime: false
    });
    $('.selectpicker').selectpicker();
    $('table tr[data-url]').on('click', function () {
        location.href = $(this).data('url');
    });
});

var url = "http://emtclient.herokuapp.com";
//var url = "http://localhost:8080";

// Getting users in family manager page
$("#search-button").click(function () {
    $("#search-button").attr('type', 'button');
    $("#users").html("Loading...");
    var username = $("#userId").text();
    var eventId = $("#info").attr('eventId');
    var userString = $("#user-string").val();
    if (userString.length == 0) {
        $("#users").html("Enter username or name of user you want to invite.");
        return;
    }
    $.ajax({
        type: 'GET',
        url: url + "/home/users/"
            + userString + "/" + eventId,
        dataType: 'json',
        async: true,
        success: function (result) {

            var html = "";
            console.log(result);
            if (result.length == 0)
                html = "No users find with such username or name.";
            else {
                html = "<table class='table table-hover table-striped'>";
                html += "<thead><tr><th>Username</th><th>First Name</th><th>Last Name</th><th>Action</th></tr></thead><tbody>";
                for (var i = 0; i < result.length; i++) {
                    if (result[i].username == username)
                        continue;
                    html += "<tr><td>"
                        + result[i].username
                        + "</td><td>"
                        + result[i].firstName
                        + "</td><td>"
                        + result[i].lastName
                        + "</td><td><button class='btn btn-sm btn-info' onclick='new InvitationsManager().inviteUser(\"" + result[i].username + "\")'>Invite</button></td></tr>";
                }
                html += "</tbody></table>";
            }

            $("#users").html(html);
            $("#search-button").attr('type', 'submit');
        },
        error: function (jqXHR, textStatus, errorThrown) {
            var html = "Unexpected error: "
                + textStatus + " " + errorThrown
                + " !";
            $("#users").html(html);
        }

    });
});

// Side bar in shoplists page.
function sidebar() {
    $(".sidebar ul").hide();
    $(".sidebar h4 span").click(function () {
        var list = $(this).parent().next();
        if ($(this).attr('downloaded') == 'false') {
            list.html('Loading...');
            var familyId = $(this).attr('familyId');
            $.ajax({
                type: 'GET',
                url: url + "/home/shoplists/get/" + familyId,
                dataType: 'json',
                async: false,
                success: function (result) {
                    var addShoplist = "<button class='btn btn-sm btn-primary' onclick='new ShoplistsManager().addShoplist(\"" + familyId + "\", this)'>Add Shoplist</button>";
                    if (result.length == 0) {
                        list.html("<p>No shoplists in family.</p>" + addShoplist);
                    }
                    var text = "";
                    for (var i = 0; i < result.length; i++) {
                        text += "<li onclick='new ShopitemsManager().loadShopItems(\"" + result[i].shoplistId + "\", \"" + result[i].name + "\", \"" + familyId + "\")'>" + result[i].name + "</li>"
                    }
                    list.html(text + addShoplist);

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    list.html("Unexpected error: "
                        + textStatus + " " + errorThrown
                        + " !");
                }
            });

            $(this).attr('downloaded', 'true');
        }

        list.slideToggle();
    });
}