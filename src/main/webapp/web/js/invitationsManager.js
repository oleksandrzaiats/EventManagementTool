function InvitationsManager () {
	this.url = "http://familyshoplist.herokuapp.com";	
}

InvitationsManager.prototype.inviteUser = function(userId) {
	var infoDiv = $("#info");
	var user = infoDiv.attr('username');
	var familyId = infoDiv.attr('familyId');
	
	$.ajax({
		type : 'GET',
		url : this.url + "/home/invitations/invite/"
				+ familyId + "/" + user + "/" + userId,
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

InvitationsManager.prototype.loadInvitations = function (username) {
	var invitations = $("#invitations");
	invitations.html("Loading...");	
	$.ajax({
		type : 'GET',
		url : this.url + "/home/invitations/"
				+ username,
		dataType : 'json',
		async : true,
		success : function(result) {
			if(result.length == 0) {
				message = "You don't have any invitations.";
			}
			else {
				message = "<table class='invitations-table'>";
				message += "<tr><td><b>Username</b></td><td><b>First Name</b></td><td><b>Last Name</b></td><td><b>Family Name</b></td><td><b>Action</b></td></tr>";
				for ( var i = 0; i < result.length; i++) {
					message += "<tr><td>"
						+ result[i]['fromUsername']
						+ "</td><td>"
						+ result[i]['firstName']
						+ "</td><td>"
						+ result[i]['lastName']
						+ "</td><td>"
						+ result[i]['name']
						+ "</td><td>" +
								"<button class='btn btn-mini btn-info' onclick='new InvitationsManager().acceptInvitation(\"" + result[i]['familyId'] + "\", \"" + result[i]['invitationId'] + "\")'>Accept</button>  " +
								"<button class='btn btn-mini btn-danger' onclick='new InvitationsManager().decineInvitation(\"" + result[i]['invitationId'] + "\")'>Decine</button>" +
							"</td></tr>";
				}
			}
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
	var username = $("#username").text();
	
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
				message = "Invitation has been successfuly accepted.";
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

InvitationsManager.prototype.decineInvitation = function (invitationId) {
	var infoDiv = $("#info");
	infoDiv.html("Loading...");	
	var username = $("#username").text();
	
	$.ajax({
		type : 'GET',
		url : this.url + "/home/invitations/decine/" + invitationId,
		dataType : 'json',
		async : true,
		success : function(result) {
			if(result[0]) {
				infoDiv.removeClass("alert alert-error");
				infoDiv.addClass("alert alert-success");
				message = "Invitation has been successfuly decined.";
			}
			else {
				infoDiv.removeClass("alert alert-success");
				infoDiv.addClass("alert alert-error");
				message = "Can't decine invitation.";
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