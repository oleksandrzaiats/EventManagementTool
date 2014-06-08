function redrawTaskChart(eventId) {
    $.ajax({
        type : 'GET',
        url : this.url + "/home/tasks/chart/"
            + eventId,
        dataType : 'json',
        async : true,
        success : function(result) {
            if(result != null && ((result["DONE"] + result["OPEN"] + result["IN_PROGRESS"]) != 0)) {
                var data = google.visualization.arrayToDataTable([
                    ['Tasks', '%'],
                    ['Done', result["DONE"]],
                    ['Open', result["OPEN"]],
                    ['In Progress', result["IN_PROGRESS"]]
                ]);
                var options = {
                    pieSliceTextStyle: { color: 'black' },
                    slices: {
                        0: { color: '#9dcd09' },
                        1: { color: '#FF9000' },
                        2: { color: '#6dbee8' }
                    }
                };

                var chart = new google.visualization.PieChart(document.getElementById('taskChart'));
                chart.draw(data, options);
            }
            else {
                $('#taskChart').text("No tasks in Event.");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            var html = "Unexpected error: "
                + textStatus + " " + errorThrown
                + " !";
            $('#taskChart').html(html);
        }
    });
}


function confirmDeleteUser(event, button, userId, eventId) {
    event.stopPropagation();
    if (confirm('Do you really want to delete this item?')) {
        $(button).text("Loading...");
        $.ajax({
            type : 'GET',
            url : this.url + "/home/users/delete/" + userId + "/"
                + eventId,
            dataType : 'json',
            async : true,
            success : function(result) {
                if(result) {
                    $("#participants tr[data-user='" + userId + "']").remove();
                }
                else {
                    $(button).text("Error");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                var html = "Unexpected error: "
                    + textStatus + " " + errorThrown
                    + " !";
                $('#participantsError').html(html);
            }
        });
    }

//    http://familyshoplist.herokuapp.com/home/users/delete/${user.username}/${event.id}
}

function confirmDeleteEvent(event, button, eventId) {
    event.stopPropagation();
    if (confirm('Do you really want to delete this item?')) {
        $(button).text("Loading...");
        $.ajax({
            type: 'GET',
            url: this.url + "/home/events/delete/" + eventId,
            dataType: 'json',
            async: true,
            success: function (result) {
                if (result) {
                    $("#events tr[data-event='" + eventId + "']").remove();
                }
                else {
                    $(button).text("Error");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                var html = "Unexpected error: "
                    + textStatus + " " + errorThrown
                    + " !";
                $('#eventsError').html(html);
            }
        });
    }
}