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
    String familiesStyle = "";
    if (request.getAttribute("users") == null) {
        familiesStyle = "style='display: none;'";
    } else
        familiesStyle = "style='display: table;'";
%>

<div class="row">
    <div class="col-md-12">
        <a class="btn btn-primary next" data-toggle="modal" href="#inviteUsers">Invite Users</a>
        <p/>
    </div>
    <div class="col-md-12">
        <div id="participantsError"/>
        <table id="participants" class="table table-hover table-striped" <%=familiesStyle%>>
            <thead>
            <tr>
                <th>Username</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}">
                <tr data-user="${user.userId}">
                    <td>${user.username}</td>
                    <td>${user.firstName}</td>
                    <td>${user.lastName}</td>
                    <td><c:if test="${user.username == username}">
                        <div class="label label-success">Owner</div>
                    </c:if> <c:if test="${user.username != username}">

                        <button class="btn btn-sm btn-danger"
                                onclick="confirmDeleteUser(event, this, ${user.userId}, ${event.id})">
                            Delete
                        </button>
                    </c:if></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="inviteUsers">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Invite Users</h4>
            </div>
            <div class="modal-body">
                <div id="info" userId="${user.userId}" eventId="${event.id}"></div>
                <div id="errors" class="hide-element alert alert-error"></div>
                <div id="form">
                    <form>
                        <div class="col-md-12">
                            <div class="input-group col-md-5">
                                <input id="user-string" type="text" class="form-control" placeholder="Search">

                                <div class="input-group-btn">
                                    <button id="search-button" class="btn btn-default"><i
                                            class="glyphicon glyphicon-search"></i></button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-12" id="users">
                </div>
                <button class="btn" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/moment.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-datetimepicker.min.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap-select.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/invitationsManager.js" />"></script>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="<spring:url value="/web/js/events.js" />"></script>
<%@include file="footer.jsp" %>