<%@include file="header.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<form id="singinForm" commandName="login" class="form-horizontal" role="form"
      action="<spring:url value="j_spring_security_check" />" method="post">
    <h2 class="form-signin-heading">Log In</h2>
    <hr>
    <div class="has-error">
        <div class="help-block"
                <%
                    String errorStyle = "";
                    if (request.getParameter("error") == null)
                        errorStyle = "style='display: none;'";
                    else
                        errorStyle = "style='display: block;'";
                    String errors = "Username or password is incorrect. Check it and try again.";
                %>
                <%=errorStyle%>><%=errors%>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="j_username">Username</label>

        <div class="col-sm-4">
            <input class="form-control" type="text" path="login" id="j_username" name="j_username" class="required"
                   placeholder="Username"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="j_password">Password</label>

        <div class="col-sm-4">
            <input class="form-control" type="password" path="password" id="j_password" name="j_password"
                   class="required" placeholder="Password"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="j_remember">Remember me</label>

        <div class="col-sm-4">
            <div class="checkbox">
                <input type="checkbox" name="j_remember" value="1" id="j_remember"> <br>
            </div>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <div class="col-sm-4">
            <button class="btn btn-large btn-primary" type="submit">Sign in</button>
        </div>
    </div>

</form>
<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#singinForm").validate();
    });
</script>
<%@include file="footer.jsp" %>
