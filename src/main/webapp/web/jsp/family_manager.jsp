<%@include file="header.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="alert alert-error"
	<%String errorStyle = "";
			if (request.getAttribute("errors") == null)
				errorStyle = "style='display: none;'";
			else
				errorStyle = "style='display: block;'";%>
	<%=errorStyle%>>${errors}</div>
<!-- Show families -->
<%
	String familiesStyle = "";
	if (request.getAttribute("users") == null) {
		familiesStyle = "style='display: none;'";
	} else
		familiesStyle = "style='display: block;'";
%>
<h3>Family Participants</h3>
<div class="family-div">
	<table class="users-table" <%=familiesStyle%>>
		<tr>
			<td><b>Username</b></td>
			<td><b>First Name</b></td>
			<td><b>Last Name</b></td>
			<td><b>Action</b></td>
		</tr>
		<c:forEach var="user" items="${users}">
			<tr>
				<td>${user.username}</td>
				<td>${user.firstName}</td>
				<td>${user.lastName}</td>
				<td><c:if test="${user.username == username}">
						<div class="label label-success">Owner</div>
					</c:if> <c:if test="${user.username != username}">

						<button class="btn btn-sm btn-danger"
							onclick="confirmDelete('http://familyshoplist.herokuapp.com/home/users/delete/${user.username}/${familyId}')">
							Delete </button>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>
</div>


<!-- From to add new family -->
<div id="errors" class="hide-element alert alert-error"></div>
<div id="form">
	<form>
		<h4>Invite user</h4>
		<input id="user-string" type="text" class="input-medium search-query">
		<button id="search-button" type="submit" class="btn">Search</button>
	</form>
</div>
<div id="info" username="${username}" familyId="${familyId}"></div>
<div id="users" class="container"></div>

<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/invitationsManager.js" />"></script>

<%@include file="footer.jsp"%>