<%@include file="header.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<h3>Calendar</h3>

<div class="row">
    <div class="col-md-12">
        <div id="eventCalendar"/>
    </div>
</div>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/moment.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-datetimepicker.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-select.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/tasksManager.js" />"></script>
<script src="<spring:url value="/web/js/jquery.eventCalendar.js" />"></script>
<script type="text/javascript">
    $(document).ready(function () {
//var url = "http://emtclient.herokuapp.com";
        var url = "http://emtapi-zayats.rhcloud.com";
        var eventsInline = [
            <c:forEach var="event" items="${events}">
                { "date": "${event.date}", "type": "meeting", "title": "${event.name}", "description": "${event.description != null ? event.description : "No description"}", "url": url + "/home/events/" + ${event.id} },
            </c:forEach>
        ];
        $("#eventCalendar").eventCalendar({
            jsonData: eventsInline,
            cacheJson: false,
            showDescription: true
//            jsonDateFormat: 'human'  // 'YYYY-MM-DD HH:MM:SS'
        });
    });
</script>
<%@include file="footer.jsp" %>