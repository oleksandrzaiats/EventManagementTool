<%@include file="header.jsp" %>
<h2> Welcome, ${username}!</h2>
<hr>
<p>
<div class="row">
    <div class="col-md-6">



        <h3>Check the progress of your Events!</h3></p>
        Go to <a href="<spring:url value="/home/tasks.html"/>">tasks</a> and check tasks you are responsive to.
        <p>

        <h3>Manage your Events!</h3></p>
        Go to <a href="<spring:url value="/home/events.html"/>">your own events</a> to create event, invite users and
        manage
        it.
        <p>

        <h3>Check Invitations!</h3></p>
        Maybe somebody invite you to his event? <a href="<spring:url value="/home/invitations.html"/>">Check it!</a>
        <p/>
    </div>
    <div class="col-md-6">
        <div class="panel no-border panel-default">
            <div class="panel-heading panel-header">Next Events</div>
            <div id="dashboard" style="text-align: left !important;" class="panel-body" style="text-align: center; height: 168px;"></div>
        </div>
    </div>
</div>
<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/moment.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-datetimepicker.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-select.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script>
    jQuery(function ($) {
        $.ajax({
            type : 'GET',
            url : "/home/events/dashboard",
            dataType : 'json',
            async : true,
            success : function(result) {
                $("#dashboard").empty();
                if (result != null && result.length > 0) {
                    var message = "<table class='table table-hover table-striped'><thead><tr><th>Event</th><th>Days left</th><th>% of done</th></tr></thead><tbody>";
                    for (i = 0; i < result.length && i < 5; i++) {
                        message += "<tr onclick='location.href = \"/home/events/" + result[i]['id'] + "\"'>" +
                                        "<td>" + result[i]["name"] + "</td>" +
                                        "<td>" + moment(result[i]["date"]).utc().diff(moment(new Date()), "days") + "</td>" +
                                        "<td>" + result[i]["progress"] + "</td></tr>";
                    }
                    message += "</tbody></table>";
                    $("#dashboard").html(message);
                } else {
                    $("#dashboard").text("You don't take part in any event.");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                var html = "Unexpected error: "
                        + textStatus + " " + errorThrown
                        + " !";
                $('#taskChart').html(html);
            }
        });
    });
</script>
<%@include file="footer.jsp" %>