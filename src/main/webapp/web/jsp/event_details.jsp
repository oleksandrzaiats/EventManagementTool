<%@include file="header.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<h3>${event.name}</h3>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-6">
                    Name
                </div>
                <div class="col-md-6">
                    ${event.name}
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Date
                </div>
                <div class="col-md-6">
                    <fmt:formatDate value="${event.date}" pattern="dd/MM/yyyy"/>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Time
                </div>
                <div class="col-md-6">
                    <fmt:formatDate value="${event.date}" pattern="HH:mm"/>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Address
                </div>
                <div class="col-md-6">
                    ${event.address}
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Description
                </div>
                <div class="col-md-6">
                    ${event.description}
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Owner
                </div>
                <div class="col-md-6">${event.owner.firstName} ${event.owner.lastName}</div>
            </div>
        </div>
        <div class="col-md-6">
        </div>
    </div>
</div>


<%@include file="footer.jsp" %>