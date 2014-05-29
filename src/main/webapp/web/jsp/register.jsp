<%@include file="header.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form:form id="register_form" action="registeruser.html"
           commandName="user" class="form-horizontal">
    <h2 class="form-signin-heading">Register</h2>
    <hr>
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
    <div class="form-group">
        <label class="col-sm-3 control-label" for="username">Username</label>

        <div class="col-sm-4">
            <form:input cssClass="form-control" id="username" name="username" path="username" type="text"
                        placeholder="Username"/>
        </div>
        <div class="col-sm-4">
            <form:errors path="username" cssClass="help-block"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="email">Email</label>

        <div class="col-sm-4">
            <form:input cssClass="form-control" id="email" name="email" path="email" type="text"
                        placeholder="Email address"/>
        </div>
        <div class="col-sm-4">
            <form:errors path="email" cssClass="help-block"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="firstName">First Name</label>

        <div class="col-sm-4">
            <form:input cssClass="form-control" id="firstName" name="firstName" path="firstName"
                        type="text" placeholder="First Name"/>
        </div>
        <div class="col-sm-4">
            <form:errors path="firstName" cssClass="help-block"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="lastName">Last Name</label>

        <div class="col-sm-4">
            <form:input cssClass="form-control" id="lastName" name="lastName" path="lastName" type="text"
                        placeholder="Last Name"/>
        </div>
        <div class="col-sm-4">
            <form:errors cssStyle="display: inline" path="lastName" cssClass="help-block"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="password">Password</label>

        <div class="col-sm-4">
            <form:input cssClass="form-control" id="password" name="password" path="password"
                        type="password" placeholder="Password"/>
        </div>
        <div class="col-sm-4">
            <form:errors path="password" cssClass="help-block"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="repeat_password">Confirm
            Password</label>

        <div class="col-sm-4">
            <input class="form-control" id="repeat_password" name="repeat_password" type="password"
                   placeholder="Repeat Password"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-3 control-label"></label>

        <div class="col-sm-4">
            <button id="registerButton" class="btn btn-large btn-primary" type="submit">
                Register
            </button>
        </div>
    </div>


</form:form>
<script src="<spring:url value="web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="web/js/bootstrap.js" />"></script>
<script type="text/javascript">
    $('document')
            .ready(
            function () {
                $('#register_form')
                        .validate(
                        {
                            rules: {
                                username: {
                                    required: true,
                                    minlength: 4,
                                    maxlength: 50
                                },
                                email: {
                                    required: true,
                                    email: true
                                },
                                firstName: {
                                    required: true,
                                    maxlength: 50
                                },
                                lastName: {
                                    required: true,
                                    maxlength: 50
                                },
                                password: {
                                    required: true,
                                    minlength: 6
                                },
                                repeat_password: {
                                    required: true,
                                    equalTo: "#password"
                                }
                            },
                            messages: {
                                username: {
                                    required: "Please enter your login",
                                    minlength: "Login must have at least 4 sybmols"
                                },
                                email: {
                                    required: "Please enter your email",
                                    email: "Your email address must be in the format of name@domain.com"
                                },
                                firstName: "Please specify your first name",
                                lastName: "Please specify your last name",
                                password: {
                                    required: "Please enter your password",
                                    minlength: "Password must be at least 6 symbols"
                                },
                                repeat_password: {
                                    required: "Please repeat your password",
                                    equalTo: "Please enter password you entered in \"Password\" field"
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
                                    console.log(error);
                                    element.parent().next(".col-sm-4").append(error);
                                } else {
                                    console.log(error);
                                    element.parent().next(".col-sm-4").append(error);
                                }
                            }
                        });
            });
</script>


<%@include file="footer.jsp" %>