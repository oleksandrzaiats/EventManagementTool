<%@include file="header.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<h3>Your Shoplists</h3>
<table class="shoplists">
	<tr>
		<td class="sidebar">
			<%
				String message = "";
				if (request.getAttribute("familyList") == null) {
					message = "You aren't participant of any family.";
				}
			%> <%=message%> <c:forEach var="family" items="${familyList}">
				<h4>
					<span downloaded="false" familyId="${family.familyId}">${family.name}<img src="<spring:url value="/web/img/dropdown.png" />">
					</span>
				</h4>
				<ul>
				</ul>
			</c:forEach>
		</td>
		<td class="shopitems-td">
			<div id="shopitems">
				Select family you want to see shoplists. Select shoplist to see shopitems.
			</div>
		</td>
	</tr>
</table>

<!-- Modal window to add shopitem -->
<div class="modal hide fade" id='addShopitemModal'>
	<div class='modal-header'>
		<a class='close' data-dismiss='modal'>x</a>
		<h3>Add Shopitem</h3>
	</div>

	<div class='modal-body'>
			<label for="name">Shopitem Name</label>
			<input type="text" id="name" placeholder="Name" />
			<div id="name-error"></div>
			<label for="quantity">Shopitem Quantity</label>
			<input type="text" id="quantity" placeholder="Quantity" />
			<div id="quantity-error"></div> 
	</div>

	<div class='modal-footer'>
		<a class="btn" data-dismiss="modal">Cancel</a> 
		<a id="add-shopitem" class="btn btn-primary">Add</a>
	</div>
</div>

<!-- Modal window to add shoplist -->
<div class="modal hide fade" id='addShoplistModal'>
	<div class='modal-header'>
		<a class='close' data-dismiss='modal'>x</a>
		<h3>Add Shoplist</h3>
	</div>

	<div class='modal-body'>
			<label for="shoplist-name">Shoplist Name</label>
			<input type="text" id="shoplist-name" placeholder="Name" />
			<div id="shoplist-name-error"></div>
	</div>

	<div class='modal-footer'>
		<a class="btn" data-dismiss="modal">Cancel</a> 
		<a id="add-shoplist" class="btn btn-primary">Add</a>
	</div>
</div>


<script src="<spring:url value="/web/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/web/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/web/js/bootstrap.js" />"></script>
<script src="<spring:url value="/web/js/script.js" />"></script>
<script src="<spring:url value="/web/js/shoplistsManager.js" />"></script>
<script src="<spring:url value="/web/js/shopitemsManager.js" />"></script>
<script type="text/javascript">
	$(document).ready(function() {
		sidebar();
	});
</script>
<%@include file="footer.jsp"%>