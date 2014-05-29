function ShoplistsManager () {
	this.url = "http://familyshoplist.herokuapp.com";	
}

ShoplistsManager.prototype.addShoplist = function(familyId, clicked) {
	var family = $(clicked).parent().prev().children();
	$('#addShoplistModal').modal('toggle');
	$('#add-shoplist').click(function() {
		
		if((shoplist = $('#shoplist-name').val()).length < 2) {
			$('#shoplist-name-error').html("Type a name of shopitem.").css('color', 'red');
			return;
		}
		else {
			$('#shoplist-name-error').empty();
		}
		$.ajax({
			type : 'GET',
			url : url + "/home/shoplists/create/"
					+ shoplist + "/" + familyId,
			dataType : 'json',
			async : true,
			success : function(result) {
				if(result[0]) {
					$('#addShoplistModal').modal('hide');
					$('#shoplist-name').val('');
					family.attr('downloaded', 'false');
					family.parent().next().hide();
					/*$(".sidebar ul").hide();*/
					family.click();
				}
				else {
					$('#shoplist-name-error').html('Error catched in creating shoplist. Family maybe doesn\'t exists. Refresh page or try later.').css('color', 'red');
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				var html = "Unexpected error: "
						+ textStatus + " " + errorThrown
						+ " !";
				$('#shoplist-name-error').html(html);
			}
		});
	});
};

ShoplistsManager.prototype.deleteShoplist = function(shoplistId, familyId) {
	if(confirm('Do you really want to delete this shoplist?')) {
		$.ajax({
			type : 'GET',
			url : url + "/home/shoplists/delete/"
					+ shoplistId,
			dataType : 'json',
			async : true,
			success : function(result) {
				if(result[0]) {
					$('span[familyId="' + familyId + '"]').attr('downloaded', 'false');
					$('span[familyId="' + familyId + '"]').parent().next().hide();
					$('span[familyId="' + familyId + '"]').click();				
					$("#shopitems").html("<div class='alert alert-success'>Shoplist has been deleted successfuly.</div>");
				}
				else {
					$("#shopitems").children().before("Can't delete shoplist.");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				var html = "Unexpected error: "
						+ textStatus + " " + errorThrown
						+ " !";
				$("#shopitems").children().before(html);
			}
		});
	}
};