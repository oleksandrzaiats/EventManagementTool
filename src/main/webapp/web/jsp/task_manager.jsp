<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.LinkedHashMap" %>
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
<h3>Event: ${event.name}</h3>

<%
    String taskStyle = "";
    if (request.getAttribute("tasks") == null) {
        taskStyle = "style='display: none;'";
    } else
        taskStyle = "style='display: table;'";
%>

<div class="row">
    <div class="col-md-12"><h3>Tasks</h3></div>
    <div class="col-md-12">
        <a class="btn btn-primary next" data-toggle="modal" href="#createTask">Create Task</a>

        <p/>
    </div>
    <div class="col-md-12">
        <div id="tasksError"/>
        <table id="tasksList" class="table table-hover table-striped" <%=taskStyle%>>
            <thead>
            <tr>
                <th>Name</th>
                <th>Status</th>
                <th>Due Date</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="task" items="${tasks}">
                <tr data-task="${task.id}" data-url="/home/tasks/detail/${task.id}">
                    <td>${task.name}</td>
                    <td>
                        <c:choose>
                            <c:when test="${task.status == 'OPEN'}">
                                Open
                            </c:when>
                            <c:when test="${task.status == 'IN_PROGRESS'}">
                                In Progress
                            </c:when>
                            <c:when test="${task.status == 'DONE'}">
                                Done
                            </c:when>
                        </c:choose>
                    </td>
                    <%
                        LinkedHashMap task = (LinkedHashMap) pageContext.getAttribute("task");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        String date = new SimpleDateFormat("dd/MM/yyyy").format(dateFormat.parse((String)task.get("dueDate")));
                    %>
                    <td><%=date%></td>
                    <td>
                        <button class="btn btn-sm btn-danger"
                                onclick="new TasksManager().confirmDeleteTask(event, this, ${task.id})">
                            Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="createTask">
    <form id="create_task" class="form-horizontal" action="/home/tasks/add">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Create Task</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="eventId" name="eventId" path="eventId" value="${event.id}"/>
                    <div class="form-group row">
                        <label for="name" class="col-sm-5 control-label">Name</label>

                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name" path="name"
                                   placeholder="Task Name">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="dueDate" class="col-sm-5 control-label">Due Date</label>

                        <div class="col-sm-6">
                            <div class='input-group date' role="datepicker">
                                <input type="text" id='dueDate' name='dueDate' path='dueDate' class="form-control"
                                       placeholder="Due Date"/>
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="responsible" class="col-sm-5 control-label">Responsible</label>

                        <div class="col-sm-6">
                            <select onselect="fillSelectedUserId()" id="responsible" name="responsible" path="responsible"
                                    class="form-control selectpicker" data-live-search="true">
                                <c:forEach var="selectUser" items="${users}">
                                    <option value="${selectUser.userId}" id="${selectUser.userId}">${selectUser.username}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="description" class="col-sm-5 control-label">Description</label>

                        <div class="col-sm-6">
                            <textarea class="form-control" id="description" name="description"
                                   path="description" placeholder="Description"></textarea>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary" type="submit">Create</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </form>
    <!-- /.modal-dialog -->
</div>
<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/moment.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-datetimepicker.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-select.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/tasksManager.js" />"></script>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="<spring:url value="/web/js/events.js" />"></script>
<%@include file="footer.jsp" %>