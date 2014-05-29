<%@include file="header.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

${message}

<!-- Jumbotron -->
      <div class="jumbotron">
        <h1>Family Shoplist</h1>
        <p class="lead">Want to do shopping with family or friends? Can't do it together? Create a "family" and invite there your relatives and friends and make shopping lists for all members of "family". Add shopping lists, shopping items and buy everything together!</p>
        <a class="btn btn-success" href="http://familyshoplist.herokuapp.com/login.html">Login</a>
        <h3 class="lead">Don't have an account?</h3>
        <a class="btn btn-primary" href="http://familyshoplist.herokuapp.com/register.html">Register</a>
      </div>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<%@include file="footer.jsp"%>
