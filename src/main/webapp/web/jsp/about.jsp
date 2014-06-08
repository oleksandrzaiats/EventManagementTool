<%@include file="header.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

${message}

<!-- Jumbotron -->
      <div class="jumbotron">
        <h2>Event Management Tool</h2>
        <p class="lead">You will be organizer for some event? Need some help? Create an event add invite there users, give them tasks. Make your work</p>
        <a class="btn btn-success" href="<spring:url value="/login.html"/>">Login</a>
        <h3 class="lead">Don't have an account?</h3>
        <a class="btn btn-primary" href="<spring:url value="/home/register.html"/>">Register</a>
      </div>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<%@include file="footer.jsp"%>
