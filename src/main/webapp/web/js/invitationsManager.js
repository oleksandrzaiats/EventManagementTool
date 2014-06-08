function InvitationsManager () {
	this.url = "http://emtclient.herokuapp.com";
//	this.url = "http://localhost:8080";
}

InvitationsManager.prototype.inviteUser = function(userId) {
	var infoDiv = $("#info");
	var familyId = infoDiv.attr('eventId');
	
	$.ajax({
		type : 'GET',
		url : this.url + "/home/invitations/invite/"
				+ familyId + "/" + userId,
		dataType : 'json',
		async : true,
		success : function(result) {
			if(result[0]) {
				infoDiv.removeClass("alert alert-error");
				infoDiv.addClass("alert alert-success");
				message = "Invitation has been successfuly sent.";
			}
			else {
				infoDiv.removeClass("alert alert-success");
				infoDiv.addClass("alert alert-error");
				message = "User has been invited already.";
			}
			infoDiv.html(message);		
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var html = "Unexpected error: "
					+ textStatus + " " + errorThrown
					+ " !";
			infoDiv.html(html);
		}
	});
};

InvitationsManager.prototype.loadInvitations = function () {
	var invitations = $("#invitations");
	invitations.html("Loading...");	
	$.ajax({
		type : 'GET',
		url : this.url + "/home/invitations/get",
		dataType : 'json',
		async : true,
		success : function(result) {
			if(result.length == 0) {
				message = "You don't have any invitations.";
			}
			else {
				message = "<table id='invitations' class='table table-hover table-striped'>";
				message += "<thead><tr><th>Username</th><th>First Name</th><th>Last Name</th><th>Event</th><th>Action</th><th></th></tr></thead><tbody>";
				for ( var i = 0; i < result.length; i++) {
					message += "<tr data-invite='" + result[i]['invitationId'] + "'><td>"
						+ result[i]['fromUsername']
						+ "</td><td>"
						+ result[i]['firstName']
						+ "</td><td>"
						+ result[i]['lastName']
						+ "</td><td>"
						+ result[i]['name']
						+ "</td><td>" +
								"<button class='btn btn-sm btn-info' onclick='new InvitationsManager().acceptInvitation(\"" + result[i]['eventId'] + "\", \"" + result[i]['invitationId'] + "\")'>Accept</button></td>" +
								"<td><button class='btn btn-sm btn-danger' onclick='new InvitationsManager().rejectInvitation(\"" + result[i]['invitationId'] + "\")'>Decine</button>" +
							"</td></tr>";
				}
			}
            message += "</tbody>";
			invitations.html(message);		
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var html = "Unexpected error: "
					+ textStatus + " " + errorThrown
					+ " !";
			invitations.html(html);
		}
	});
};

InvitationsManager.prototype.acceptInvitation = function(familyId, invitationId) {
	var infoDiv = $("#info");
	infoDiv.html("Loading...");	

	$.ajax({
		type : 'GET',
		url : this.url + "/home/invitations/accept/"
				+ familyId + "/" + invitationId,
		dataType : 'json',
		async : true,
		success : function(result) {
			if(result[0]) {
				infoDiv.removeClass("alert alert-error");
				infoDiv.addClass("alert alert-success");
				message = "Invitation has been successfully accepted.";
			}
			else {
				infoDiv.removeClass("alert alert-success");
				infoDiv.addClass("alert alert-error");
				message = "Can't assign you to family.";
			}
			infoDiv.html(message);
			new InvitationsManager().loadInvitations(username);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var html = "Unexpected error: "
					+ textStatus + " " + errorThrown
					+ " !";
			infoDiv.html(html);
		}
	});
};

InvitationsManager.prototype.rejectInvitation = function (invitationId) {
	var infoDiv = $("#info");
	infoDiv.html("Loading...");	
	var username = $("#username").text();
	
	$.ajax({
		type : 'GET',
		url : this.url + "/home/invitations/reject/" + invitationId,
		dataType : 'json',
		async : true,
		success : function(result) {
			if(result[0]) {
				infoDiv.removeClass("alert alert-error");
				infoDiv.addClass("alert alert-success");
                message = "Invitation has been successfully rejected.";
			}
			else {
				infoDiv.removeClass("alert alert-success");
				infoDiv.addClass("alert alert-error");
				message = "Can't reject invitation.";
			}
			infoDiv.html(message);
			new InvitationsManager().loadInvitations(username);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var html = "Unexpected error: "
					+ textStatus + " " + errorThrown
					+ " !";
			infoDiv.html(html);
		}
	});
};