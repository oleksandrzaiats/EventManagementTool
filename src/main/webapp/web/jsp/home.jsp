<%@include file="header.jsp" %>


<h2> Welcome, ${username}!</h2>
<hr>
<p><h3>Check shoplists of your family!</h3></p>
Go to <a href="<spring:url value="/home/shoplists.html"/>">shoplists</a> and check what shopitems are bought or manage shoplists or shopitems.
<p><h3>Manage your families!</h3></p>
Go to <a href="<spring:url value="/home/families.html"/>">your own famillies</a> and create and invite users to family or manage it.
<p><h3>Check Invitations!</h3></p> 
Maybe somebody invite you to his family? <a href="<spring:url value="/home/invitations.html"/>">Check it!</a>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<%@include file="footer.jsp" %>