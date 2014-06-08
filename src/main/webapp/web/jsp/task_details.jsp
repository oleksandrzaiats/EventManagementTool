<%@include file="header.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="has-error">
    <div class="help-block"
            <%
                String errorStyle = "";
                if (request.getAttribute("errors") == null)
                    errorStyle = "style='display: none;'";
                else
                    errorStyle = "style='display: block;'";
            %>
            <%=errorStyle%>>${errors}
    </div>
</div>
<h3>Task: ${task.name}</h3>

<form action="/home/tasks/edit">
    <input type="hidden" id="taskId" name="taskId" value="${task.id}"/>
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <b>Name</b>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    ${task.name}
                </div>
            </div>
            <p/>

            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <b>Create Date</b>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <fmt:formatDate value="${task.createDate}" pattern="dd/MM/yyyy"/>
                </div>
            </div>
            <p/>

            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <b>Due Date</b>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <fmt:formatDate value="${task.dueDate}" pattern="dd/MM/yyyy"/>
                </div>
            </div>
            <p/>
            <c:if test="${task.doneDate != null}">
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <b>Done Date</b>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <fmt:formatDate value="${task.doneDate}" pattern="dd/MM/yyyy"/>
                    </div>
                </div>
                <p/>
            </c:if>

            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <b>Event</b>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">${event.name}</div>
            </div>
            <p/>
        </div>
        <div class="col-md-6">

            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <b>Organizer</b>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">${event.owner.firstName} ${event.owner.lastName}</div>
            </div>
            <p/>

            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <b>Status</b>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <select onchange="infoChanged();" id="status" name="status" path="status"
                            class="selectpicker">
                        <option
                                <c:if test="${task.status == 'OPEN'}">selected="selected" </c:if> value="OPEN">Open
                        </option>
                        <option
                                <c:if test="${task.status == 'IN_PROGRESS'}">selected="selected" </c:if>
                                value="IN_PROGRESS">In progress
                        </option>
                        <option
                                <c:if test="${task.status == 'DONE'}">selected="selected" </c:if> value="DONE">Done
                        </option>
                    </select>
                </div>
            </div>
            <p/>

            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <b>Responsible</b>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <c:choose>
                        <c:when test="${userId == event.owner.userId}">
                            <select onchange="infoChanged();" id="responsible" name="responsible"
                                    path="responsible"
                                    class="selectpicker" data-live-search="true">
                                <c:forEach var="selectUser" items="${users}">
                                    <option
                                            <c:if test="${selectUser.userId == task.responsible.userId}">selected="selected"</c:if>
                                            value="${selectUser.userId}"
                                            id="${selectUser.userId}">${selectUser.username}</option>
                                </c:forEach>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" id="responsible" name="responsible"
                                   path="responsible" value="${task.responsible.userId}"/>
                            ${task.responsible.firstName} ${task.responsible.lastName}
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
            <p/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3">
            <b>Description</b>
        </div>
        <div class="col-md-9">
            ${task.description}
        </div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-md-4">
            <button type="button" onclick="window.history.back()" class="btn btn-default">Back</button>
            <button type="submit" id="changeTask" disabled="disabled" class="btn btn-primary">Save</button>
        </div>
    </div>
</form>
<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/moment.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-datetimepicker.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-select.js" />"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/events.js" />"></script>
<script src="<spring:url value="/web/js/invitationsManager.js" />"></script>
<script src="<spring:url value="/web/js/events.js" />"></script>
<script>
    function infoChanged() {
        $("#changeTask").removeAttr("disabled");
    };
</script>
<%@include file="footer.jsp" %>