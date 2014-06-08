<%@include file="header.jsp" %>


<h2> Welcome, ${username}!</h2>
<hr>
<p><h3>Check the progress of your Events!</h3></p>
Go to <a href="<spring:url value="/home/tasks.html"/>">tasks</a> and check tasks you are responsive to.
<p><h3>Manage your Events!</h3></p>
Go to <a href="<spring:url value="/home/events.html"/>">your own events</a> to create event, invite users and manage it.
<p><h3>Check Invitations!</h3></p> 
Maybe somebody invite you to his event? <a href="<spring:url value="/home/invitations.html"/>">Check it!</a>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<%@include file="footer.jsp" %>