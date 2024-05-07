$(document).ready(function () {
  $("#quantityForm").submit(function (e) {
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: "/Web_HomeAppliances/AddToCart",
      data: $("#quantityForm").serialize(),
      success: function (data) {
        const response = JSON.parse(data);
        if (response.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Cart added successfully",
            "Refresh to see changes on your cart."
          );
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Add to cart",
            response.cause
          );
        }
      },
    });
  });
  $(".cart-minus-button").click(function () {
    var id = $(this).attr("id");
    const quantity = parseInt($(`#cart-item-${id} input.kw3`).val());
    if (quantity <= 1) return;
    // <p class="cart-item-text-price-total"><%= String.format("RM %.2f total", cartProd.getPrice() * quantity) %></p>
    $(`#cart-q-${id} div div .cart-item-text-price-total`).text(
      `RM ${(
        parseFloat(
          $(`#cart-q-${id} div div .cart-item-text-price`).text().split(" ")[1]
        ) *
        (quantity - 1)
      ).toFixed(2)} total`
    );
    if (quantity > 1) {
      $(`#cart-item-${id} input.kw3`).val(quantity - 1);
    }
  });
  $(".cart-plus-button").click(function () {
    var id = $(this).attr("id");
    // <p class="cart-item-text-price-total"><%= String.format("RM %.2f total", cartProd.getPrice() * quantity) %></p>
    var max = $(`#cart-item-${id} input`).attr("max");
    const quantity = parseInt($(`#cart-item-${id} input.kw3`).val());
    if (quantity >= max) return;
    $(`#cart-q-${id} div div .cart-item-text-price-total`).text(
      `RM ${(
        parseFloat(
          $(`#cart-q-${id} div div .cart-item-text-price`).text().split(" ")[1]
        ) *
        (quantity + 1)
      ).toFixed(2)} total`
    );
    $(`#cart-item-${id} input.kw3`).val(
      quantity + 1 > max ? max : quantity + 1
    );
  });
  $(".cart-rem-button").click(function () {
    var confirm = window.confirm(
      "Are you sure you want to remove this item from your cart?"
    );
    if (!confirm) return;
    var id = $(this).attr("id");
    $.ajax({
      type: "POST",
      url: "/Web_HomeAppliances/RemoveFromCart",
      data: { product_id: id },
      success: function (data) {
        const response = JSON.parse(data);
        if (response.success) {
          // remove <div class="cart-q" id="cart-q-<%= cart.getProduct_id() %>">
          $(`#cart-q-${id}`).remove();
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Cart remove",
            "Cart removed successfully."
          );
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Remove from cart",
            response.cause
          );
        }
      },
    });
  });
  $(".cart-quantity").change(function () {
    var id = $(this).attr("id");
    id = id.split("-")[2];
    var max = $(this).attr("max");
    var quantity = parseInt($(this).val());
    if (quantity > max) {
      $(this).val(max);
      quantity = max;
    } else if (quantity < 1) {
      $(this).val(1);
      quantity = 1;
    }
    $(`#cart-q-${id} div div .cart-item-text-price-total`).text(
      `RM ${(
        parseFloat(
          $(`#cart-q-${id} div div .cart-item-text-price`).text().split(" ")[1]
        ) * quantity
      ).toFixed(2)} total`
    );
  });
  $(".noaction").click(function (e) {
    e.preventDefault();
  });

  $("#cart-checkout").click(function () {
    $("#checkout-submit").click();
  });

  $("#paymentForm").submit(function (e) {
    e.preventDefault();
    var sendData = {
      payment_method: "",
      card_id: "",
      product_id: [],
      product_quantity: [],
      shipping_id: "",
      estimated_price: "",
    };
    sendData.payment_method = $("input[name='payment']:checked").val();
    if (sendData.payment_method == "card") {
      sendData.card_id = $(".topup-card-select").val();
      if (sendData.card_id == 0 || sendData.card_id == null) {
        showSnackbar(
          "src/img/white/alert-circle.svg",
          "Payment method",
          "Please select a card."
        );
        return;
      }
    }
    sendData.shipping_id = $("#ship-select").val();
    if (sendData.shipping_id == 0 || sendData.shipping_id == null) {
      showSnackbar(
        "src/img/white/alert-circle.svg",
        "Shipping address",
        "Please select a shipping address."
      );
      return;
    }
    //checkout.jsp?id=1,2,3&qty=1,2,3
    var id = window.location.search.split("id=")[1].split("&")[0];
    var qty = window.location.search.split("qty=")[1];
    sendData.product_id = id;
    sendData.product_quantity = qty;
    sendData.estimated_price = $("#hidden-price-total").val();
    console.log(sendData);
    $.ajax({
      type: "POST",
      url: "/Web_HomeAppliances/Checkout",
      data: sendData,
      success: function (data) {
        const response = JSON.parse(data);
        if (response.success) {
          setTimeout(() => {
            window.location.href = "/Web_HomeAppliances/checkoutSuccess.jsp";
          });
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Checkout",
            response.cause
          );
        }
      },
    });
  });

  $("#checkoutForm").submit(function (e) {
    e.preventDefault();
    const prod_id = $(".cart-q div div div input.kw1");
    const prod_checked = $(".cart-q div div div input.kw2");
    const prod_quantity = $(".cart-q div div div input.kw3");

    var data = {
      prod_id: [],
      prod_quantity: [],
    };

    for (var i = 0; i < prod_id.length; i++) {
      if (prod_checked[i].checked) {
        data.prod_id.push(prod_id[i].value);
        data.prod_quantity.push(prod_quantity[i].value);
      }
    }
    window.location.href = `/Web_HomeAppliances/checkout.jsp?id=${data.prod_id.join(
      ","
    )}&qty=${data.prod_quantity.join(",")}`;
  });
  $("#buynow").click(function () {
    var id = $("#quantityForm input[name='product_id']").val();
    var quantity = $("#quantityForm input[name='quantity']").val();
    window.location.href = `/Web_HomeAppliances/checkout.jsp?id=${id}&qty=${quantity}`;
  });
  $(".payment-method-radio").click(function () {
    var id = $(this).attr("id");
    $(id == "nelson-wallet" ? ".nelson-wallet-info" : ".card-select").show();
    $(id == "nelson-wallet" ? ".card-select" : ".nelson-wallet-info").hide();
  });
  $("#ship-select").change(function () {
    var id = $(this).val();
    if (id == 0 ) {
        $(".address-section").hide();
        return;
    }
    console.log(id);
    $("#address-id").val($("#ship-id-" + id).val());
    $("#address-name").text($(`#ship-name-${id}`).val());
    $("#address-contact").text($(`#ship-cont-${id}`).val());
    $("#address-addr").text($(`#ship-addr-${id}`).val());
    $("#address-addrii").text($(`#ship-addrii-${id}`).val());
    $("#address-city").text($(`#ship-city-${id}`).val());
    $("#address-state").text($(`#ship-state-${id}`).val());
    $("#address-zip").text($(`#ship-zip-${id}`).val());
    $(".address-section").show();
  });
  $("#shipping-refresh").click(function () {
    $.ajax({
      type: "GET",
      url: "/Web_HomeAppliances/AddressRetrieve",
      success: function (data) {
        const response = JSON.parse(data);
        var select = $("#ship-select");
        var hidden_addr = $(".hidden-address-field");
        select.empty();
        hidden_addr.empty();
        $(".address-section").hide();
        select.append(`<option value="0">Select address</option>`);
        for (var i = 0; i < response.length; i++) {
          var c = response[i];
          hidden_addr.append(
            `<input type="text" id="ship-id-${c.id}" value="${c.id}" hidden>`
          );
          hidden_addr.append(
            `<input type="text" id="ship-name-${c.id}" value="${c.recipient_name}" hidden>`
          );
          hidden_addr.append(
            `<input type="text" id="ship-cont-${c.id}" value="${c.contact_number}" hidden>`
          );
          hidden_addr.append(
            `<input type="text" id="ship-addr-${c.id}" value="${c.address}" hidden>`
          );
          hidden_addr.append(
            `<input type="text" id="ship-addrii-${c.id}" value="${
              c.address_2 == null ? "" : c.address_2
            }" hidden>`
          );
          hidden_addr.append(
            `<input type="text" id="ship-city-${c.id}" value="${c.city}" hidden>`
          );
          hidden_addr.append(
            `<input type="text" id="ship-state-${c.id}" value="${c.state}" hidden>`
          );
          hidden_addr.append(
            `<input type="text" id="ship-zip-${c.id}" value="${c.zip_code}" hidden>`
          );
          select.append(
            `<option value="${c.id}">${c.recipient_name} ${c.contact_number} ${
              c.address
            } ${c.address_2 == null ? "" : c.address_2} ${c.city} ${c.state} ${
              c.zip_code
            }</option>`
          );
        }
      },
    });
  });
});
