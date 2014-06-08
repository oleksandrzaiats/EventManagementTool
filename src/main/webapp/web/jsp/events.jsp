<%@include file="header.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Show events -->
<%
    String eventsStyle = "";
    String message = "";
    if (request.getAttribute("eventsList") == null) {
        eventsStyle = "style='display: none;'";
        message = "You don't have your own events. You can create this one.";
    } else
        eventsStyle = "style='display: table;'";
%>
<%=message%>

<h3>Your Events</h3>

<div class="row">
    <div id="eventsError"></div>
    <div class="col-md-12">
        <table id="events" class="table table-hover table-striped" <%=eventsStyle%>>
            <thead>
            <tr>
                <th>Event</th>
                <th>Date</th>
                <th>Time</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="event" items="${eventsList}">
                <tr data-event="${event.id}" data-url="events/${event.id}">
                    <td>${event.name}</td>
                    <td><fmt:formatDate value="${event.date}" pattern="dd/MM/yyyy"/></td>
                    <td><fmt:formatDate value="${event.date}" pattern="HH:mm"/></td>
                    <td>
                        <button class="btn btn-sm btn-danger"
                                onclick="confirmDeleteEvent(event, this, ${event.id})">Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>


<!-- From to add new family -->
<div class="alert alert-error"
        <%
            String errorStyle = "";
            if (request.getAttribute("errors") == null)
                errorStyle = "style='display: none;'";
            else
                errorStyle = "style='display: block;'";
        %>
        <%=errorStyle%>><%=request.getAttribute("errors")%>
</div>
<div class="row">
    <div class="col-md-12">
        <a class="btn btn-primary next" data-toggle="modal" href="#createEvent">Create Event</a>
        <p/>
    </div>
</div>

<div class="modal fade" id="createEvent">
    <form id="create_event" class="form-horizontal" action="events/add">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Create Event</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group row">
                        <label for="name" class="col-sm-5 control-label">Name</label>

                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name" path="name"
                                   placeholder="Event Name">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="date" class="col-sm-5 control-label">Date</label>

                        <div class="col-sm-6">
                            <div class='input-group date' role="datetimepicker">
                                <input type="text" id='date' name='date' path='date' class="form-control"
                                       placeholder="Date"/>
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="address" class="col-sm-5 control-label">Address</label>

                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="address" name="address" path="address"
                                   placeholder="Address">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="description" class="col-sm-5 control-label">Description</label>

                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="description" name="description"
                                   path="description" placeholder="Description">
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
</div>
<!-- /.modal -->

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
<script type="text/javascript">
    $(document).ready(function () {
        $("#create_family").validate({
            rules: {
                name: {
                    required: true
                },
                date: {
                    required: true,
                    date: true
                },
                address: {
                    required: true
                }
            },
            highlight: function (element) {
                $(element).closest('.form-group').addClass('has-error');
            },
            unhighlight: function (element) {
                $(element).closest('.form-group').removeClass('has-error');
            },
            errorElement: 'span',
            errorClass: 'help-block',
            errorPlacement: function (error, element) {
                if (element.parent('.input-group').length) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
    });
</script>


<%@include file="footer.jsp" %>