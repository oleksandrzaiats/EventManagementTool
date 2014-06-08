function TasksManager() {
    this.url = "http://emtclient.herokuapp.com";
//    this.url = "http://localhost:8080";
}

TasksManager.prototype.addTask = function (familyId, clicked) {
    var family = $(clicked).parent().prev().children();
    $('#addTaskModal').modal('toggle');
    $('#add-task').click(function () {

        if ((task = $('#task-name').val()).length < 2) {
            $('#task-name-error').html("Type a name of shopitem.").css('color', 'red');
            return;
        }
        else {
            $('#task-name-error').empty();
        }
        $.ajax({
            type: 'GET',
            url: url + "/home/tasks/create/"
                + task + "/" + familyId,
            dataType: 'json',
            async: true,
            success: function (result) {
                if (result[0]) {
                    $('#addTaskModal').modal('hide');
                    $('#task-name').val('');
                    family.attr('downloaded', 'false');
                    family.parent().next().hide();
                    /*$(".sidebar ul").hide();*/
                    family.click();
                }
                else {
                    $('#task-name-error').html('Error catched in creating task. Family maybe doesn\'t exists. Refresh page or try later.').css('color', 'red');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                var html = "Unexpected error: "
                    + textStatus + " " + errorThrown
                    + " !";
                $('#task-name-error').html(html);
            }
        });
    });
};

TasksManager.prototype.deleteTask = function (taskId, familyId) {
    if (confirm('Do you really want to delete this task?')) {
        $.ajax({
            type: 'GET',
            url: url + "/home/tasks/delete/"
                + taskId,
            dataType: 'json',
            async: true,
            success: function (result) {
                if (result[0]) {
                    $('span[familyId="' + familyId + '"]').attr('downloaded', 'false');
                    $('span[familyId="' + familyId + '"]').parent().next().hide();
                    $('span[familyId="' + familyId + '"]').click();
                    $("#shopitems").html("<div class='alert alert-success'>Task has been deleted successfuly.</div>");
                }
                else {
                    $("#shopitems").children().before("Can't delete task.");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                var html = "Unexpected error: "
                    + textStatus + " " + errorThrown
                    + " !";
                $("#shopitems").children().before(html);
            }
        });
    }
};

TasksManager.prototype.loadTasks = function (eventId) {
    var taskManager = this;
    $("#" + eventId).text("Loading...");
    $.ajax({
        type: 'GET',
        url: url + "/home/tasks/getForUser/"
            + eventId,
        dataType: 'json',
        async: true,
        success: function (result) {
            if(result.length == 0) {
                message = "You don't have any tasks in this event.";
            }
            else {
                message = "<table id='taskTable' class='table table-hover table-striped'>";
                message += "<thead><tr><th>Name</th><th>Status</th><th>Create Date</th><th>Due Date</th></tr></thead><tbody>";
                for ( var i = 0; i < result.length; i++) {
                    message += "<tr onclick='location.href = \"/home/tasks/detail/" + result[i]['id'] + "\"'><td>"
                        + result[i]['name']
                        + "</td><td>"
                        + taskManager.getStatus(result[i]['status'])
                        + "</td><td>"
                        + moment(result[i]['createDate'], "YYYY-MM-DD").format("DD/MM/YYYY")
                        + "</td><td>"
                        + moment(result[i]['dueDate'], "YYYY-MM-DD").format("DD/MM/YYYY")
                        + "</td></tr></tbody>";
                }
            }
            $("#" + eventId).html(message);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            var html = "Unexpected error: "
                + textStatus + " " + errorThrown
                + " !";
            $("#" + eventId).html(html);
        }
    });
};

TasksManager.prototype.getStatus = function(status) {
    if(status == "OPEN") {
        return "Open";
    }
    if(status == "IN_PROGRESS") {
        return "In progress";
    }
    if(status == "DONE") {
        return "Done";
    }
};

TasksManager.prototype.confirmDeleteTask = function(event, button, taskId) {
    event.stopPropagation();
    if (confirm('Do you really want to delete this item?')) {
        $(button).text("Loading...");
        $.ajax({
            type : 'GET',
            url : this.url + "/home/tasks/delete/" + taskId,
            dataType : 'json',
            async : true,
            success : function(result) {
                if(result) {
                    $("#tasksList tr[data-task='" + taskId + "']").remove();
                }
                else {
                    $(button).text("Error");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                var html = "Unexpected error: "
                    + textStatus + " " + errorThrown
                    + " !";
                $('#tasksError').html(html);
            }
        });
    }
}