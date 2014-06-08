<%@include file="header.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<h3>Your Tasks</h3>

<div class="tabbable tabs-left">
    <ul class="nav nav-tabs">
        <%
            String message = "";
            if (request.getAttribute("eventList") == null) {
                message = "You aren't participant of any event.";
            }
        %> <%=message%>
        <c:forEach var="event" items="${eventList}">
            <li><a data-id="${event.id}" href="#${event.id}" onclick='new TasksManager().loadTasks(${event.id})'
                   data-toggle="tab">${event.name}</a></li>
            <%--<span downloaded="false" familyId="${family.familyId}">${family.name}<img src="<spring:url value="/web/img/dropdown.png" />">
            </span>--%>
        </c:forEach>
        <%--<li><a href="#a" data-toggle="tab">One</a></li>
        <li class="active"><a href="#b" data-toggle="tab">Two</a></li>
        <li><a href="#c" data-toggle="tab">Twee</a></li>--%>
    </ul>
    <div class="tab-content">
        <c:forEach var="event" items="${eventList}">
            <div class="tab-pane" id="${event.id}"></div>
        </c:forEach>
        <%-- <div class="tab-pane active" id="a">Lorem ipsum dolor sit amet, charetra varius quam sit amet vulputate.
             Quisque mauris augue, molestie tincidunt condimentum vitae, gravida a libero.</div>
         <div class="tab-pane" id="b">Secondo sed ac orci quis tortor imperdiet venenatis. Duis elementum auctor accumsan.
             Aliquam in felis sit amet augue.</div>
         <div class="tab-pane" id="c">Thirdamuno, ipsum dolor sit amet, consectetur adipiscing elit. Duis pharetra varius quam sit amet vulputate.
             Quisque mauris augue, molestie tincidunt condimentum vitae. </div>--%>
    </div>
</div>
<%--<table class="shoplists">
	<tr>
		<td class="sidebar">
			<%
				String message = "";
				if (request.getAttribute("eventList") == null) {
					message = "You aren't participant of any event.";
				}
			%> <%=message%> <c:forEach var="family" items="${eventList}">
				<h4>
					<span downloaded="false" familyId="${family.familyId}">${family.name}<img src="<spring:url value="/web/img/dropdown.png" />">
					</span>
				</h4>
				<ul>
				</ul>
			</c:forEach>
		</td>
		<td class="shopitems-td">
			<div id="shopitems">
				Select family you want to see shoplists. Select shoplist to see shopitems.
			</div>
		</td>
	</tr>
</table>--%>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/moment.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-datetimepicker.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-select.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/tasksManager.js" />"></script>
<script type="text/javascript">
    $(document).ready(function () {
        if ($(".tabbable ul").length > 0) {
            $(".tabbable .nav-tabs li a").first().click();
        }
    });
</script>
<%@include file="footer.jsp" %>