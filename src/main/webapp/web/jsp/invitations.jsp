<%@include file="header.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<h3>Invitations</h3>
<div id="info"></div>
<div id="invitations" class="container"></div>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/invitationsManager.js" />"></script>
<script>
	$(document).ready(function() {
		new InvitationsManager().loadInvitations($("#username").text());
	});
</script>

<%@include file="footer.jsp"%>