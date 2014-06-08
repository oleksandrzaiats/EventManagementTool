function ShopitemsManager () {
	this.url = "http://familyshoplist.herokuapp.com";	
}

ShopitemsManager.prototype.loadShopItems = function(shoplistId, name, familyId) {
	var shopitems = $("#shopitems");
	var deleteShoplist = "<span><p><b>Shoplist: " + name + "</b><button class='btn btn-sm btn-danger' onclick='new ShoplistsManager().deleteTask(" + shoplistId + ", " + familyId + ")'>Delete Shoplist</button></p></span>";
	var addShopitem = "<p><button class='btn btn-sm btn-success' onclick='new ShopitemsManager().addShopitem(" + shoplistId + ", \"" + name + "\")'>Add Shopitem</button></p>";
	var text = deleteShoplist + addShopitem;
	$.ajax({
		type : 'GET',
		url : url + "/home/shoplists/shopitems/"
				+ shoplistId,
		dataType : 'json',
		async : true,
		success : function(result) {
			var addShopitem = "";
			if(result.length == 0) {
				text += "There are no shopitems in this shoplist.";
			}
			else {
				text += "<table class='shopitems-table'>";
				text += "<tr><td><b>Name</b></td><td><b>Quantity</b></td><td><b>Bought</b></td><td><b>Action</b></td></tr>";
				for ( var i = 0; i < result.length; i++) {
					if(result[i].bought == 't') {
						bought = "<img src='/web/img/bought.png'/>";
					}
					else {
						bought = "<button class='btn btn-sm btn-success' onclick='new ShopitemsManager().buyShopitem(\"" + result[i].shopitemId + "\", " + shoplistId + ", \"" + name + "\")'>Buy</button>";
					}
						
					text += "<tr><td class='shopitems-name'>"
							+ result[i].name
							+ "</td><td class='shopitems-quantity'>"
							+ result[i].quantity
							+ "</td><td class='shopitems-action'>"
							+ bought
							+ "</td><td class='shopitems-action'><button class='btn btn-sm btn-danger' onclick='new ShopitemsManager().deleteShopitem(\"" + result[i].shopitemId + "\", " + shoplistId + ", \"" + name + "\")'>Delete</button></td></tr>";
				}
				text += "</table>";
			}
			shopitems.html(text);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var html = "Unexpected error: "
					+ textStatus + " " + errorThrown
					+ " !";
			shopitems.html(html);
		}
	});
};

ShopitemsManager.prototype.addShopitem = function(shoplistId, shoplistName) {
	$('#addShopitemModal').modal('toggle');
	$('#add-shopitem').click(function() {
		
		if((name = $('#name').val()).length < 2) {
			$('#name-error').html("Type a name of shopitem.").css('color', 'red');
			return;
		}
		else {
			$('#name-error').empty();
		}
		
		if((quantity = $('#quantity').val()).length == 0) {
			$('#quantity-error').html("Type quantity of shopitem.").css('color', 'red');
			return;
		}
		else {
			$('#name-error').empty();
		}
			
		$.ajax({
			type : 'GET',
			url : url + "/home/shoplists/addShopitem/"
					+ name + "/" + quantity + "/" + shoplistId,
			dataType : 'json',
			async : true,
			success : function(result) {
				if(result[0]) {
					$('#addShopitemModal').modal('hide');
					$('#name').val('');
					$('#quantity').val('');
					new ShopitemsManager().loadShopItems(shoplistId, name);
				}
				else {
					$('#name-error').html("Can't add shopitem. Please, try later.").css('color', 'red');
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				var html = "Unexpected error: "
						+ textStatus + " " + errorThrown
						+ " !";
				$('#name-error').html(html).css('color', 'red');
			}
		});
	});
};

ShopitemsManager.prototype.deleteShopitem = function(shopitemId, shoplistId, name) {
	if(confirm('Do you really want to delete this shopitem?')) {
		$.ajax({
			type : 'GET',
			url : url + "/home/shoplists/deleteShopitem/"
					+ shopitemId,
			dataType : 'json',
			async : true,
			success : function(result) {
				if(result[0]) {
					new ShopitemsManager().loadShopItems(shoplistId, name);
				}
				else {
					$("#shopitems").html("Can't delete shopitem. Try later.")
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				var html = "Unexpected error: "
						+ textStatus + " " + errorThrown
						+ " !";
				$("#shopitems").html(html);
			}
		});
	}
};

ShopitemsManager.prototype.buyShopitem = function(shopitemId, shoplistId, name) {
	$.ajax({
		type : 'GET',
		url : url + "/home/shoplists/buyShopitem/"
				+ shopitemId,
		dataType : 'json',
		async : true,
		success : function(result) {
			if(result[0]) {
				new ShopitemsManager().loadShopItems(shoplistId, name);
			}
			else {
				$("#shopitems").html("Can't buy shopitem. Try later.")
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var html = "Unexpected error: "
					+ textStatus + " " + errorThrown
					+ " !";
			$("#shopitems").html(html);
		}
	});
};