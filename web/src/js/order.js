$(document).ready(function() {
    $(".cart-q").click(function() {
        var id = $(this).attr("id");
        if (!id.startsWith("order-")) return;
        id = id.substring(6);
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/RetrieveOrder",
            data: {
                id: id
            },
            success: function(data) {
                const o = JSON.parse(data);
                var h = $("#js-insert-details");
                h.empty();
                const payment = o.payment_method;
                const address = o.cust_order_address;
                const price = o.price;
                const shipping = o.shipping_fee;
                const tax = o.tax;
                const discount = o.discount;
                const total = o.final_price;
                const date = o.create_date;
                const orders = o.order_product;
                const status = o.order_status;
                h.append("<hr><h3>Order Status</h3>");
                for (var i = 0; i < status.length; i++) {
                    const s = status[i];
                    h.append("<p>" + s.create_date + ": " + s.status +"</p>");
                }
                h.append("<hr><h3>Order Items</h3>");
                for (var i = 0; i < orders.length; i++) {
                    const order = orders[i];
                    h.append("<div class='cart-q'><div class='cart-item'><img class='cart-item-image' src='" + order.product.display_image + "'><div class='order-item-info'><h4>" + order.product.name + "</h4><p>Price: RM " + parseFloat(order.price).toFixed(2) + " each, RM " + parseFloat(order.price * order.quantity).toFixed(2) + " total</p><p>Quantity: " + order.quantity + "</p></div></div></div>");
                }
                h.append("<hr><h3>Price calculation</h3>");
                h.append("<p class='nomargintop nomarginbottom'>Order date: " + date + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Payment method: " + payment + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Price: RM " + parseFloat(price).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Shipping fee: RM " + parseFloat(shipping).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Tax: RM " + parseFloat(tax).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Discount: RM " + parseFloat(discount).toFixed(2) + "</p>");
                h.append("<p class='nomargintop'>Total: RM " + parseFloat(total).toFixed(2) + "</p>");

                h.append("<hr><h3>Shipping Address</h3>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.recipient_name + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.contact_number + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.address + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.address_2 + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.city + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.state + "</p>");
                h.append("<p class='nomargintop'>" + address.zip_code + "</p>");
            }
        });
    });
    $(".cart-q").click(function() {
        var id = $(this).attr("id");
        if (!id.startsWith("pending-")) return;
        id = id.substring(8);
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/RetrieveOrder",
            data: {
                id: id
            },
            success: function(data) {
                const o = JSON.parse(data);
                var h = $("#js-insert-details");
                h.empty();
                const payment = o.payment_method;
                const address = o.cust_order_address;
                const price = o.price;
                const shipping = o.shipping_fee;
                const tax = o.tax;
                const discount = o.discount;
                const total = o.final_price;
                const date = o.create_date;
                const orders = o.order_product;
                const status = o.order_status;
                h.append("<hr><h3>Order Status</h3>");
                for (var i = 0; i < status.length; i++) {
                    const s = status[i];
                    h.append("<p>" + s.create_date + ": " + s.status +"</p>");
                }
                h.append("<button class='nelson-button mark-as-shipped nomarginleft' id='mark-as-shipped-" + id + "'>Mark as shipped</button>");
                h.append("<hr><h3>Order Items</h3>");
                for (var i = 0; i < orders.length; i++) {
                    const order = orders[i];
                    h.append("<div class='cart-q'><div class='cart-item'><img class='cart-item-image' src='" + order.product.display_image + "'><div class='order-item-info'><h4>" + order.product.name + "</h4><p>Price: RM " + parseFloat(order.price).toFixed(2) + " each, RM " + parseFloat(order.price * order.quantity).toFixed(2) + " total</p><p>Quantity: " + order.quantity + "</p></div></div></div>");
                }
                h.append("<hr><h3>Shipping Address</h3>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.recipient_name + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.contact_number + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.address + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.address_2 + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.city + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.state + "</p>");
                h.append("<p class='nomargintop'>" + address.zip_code + "</p>");

                h.append("<hr><h3>Price calculation</h3>");
                h.append("<p class='nomargintop nomarginbottom'>Order date: " + date + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Payment method: " + payment + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Price: RM " + parseFloat(price).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Shipping fee: RM " + parseFloat(shipping).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Tax: RM " + parseFloat(tax).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Discount: RM " + parseFloat(discount).toFixed(2) + "</p>");
                h.append("<p class='nomargintop'>Total: RM " + parseFloat(total).toFixed(2) + "</p>");
            }
        });
    });
    $(".cart-q").click(function() {
        var id = $(this).attr("id");
        if (!id.startsWith("update-")) return;
        id = id.substring(7);
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/RetrieveOrder",
            data: {
                id: id
            },
            success: function(data) {
                const o = JSON.parse(data);
                var h = $("#js-insert-details");
                h.empty();
                const payment = o.payment_method;
                const address = o.cust_order_address;
                const price = o.price;
                const shipping = o.shipping_fee;
                const tax = o.tax;
                const discount = o.discount;
                const total = o.final_price;
                const date = o.create_date;
                const orders = o.order_product;
                const status = o.order_status;
                h.append("<hr><h3>Order Status</h3>");
                for (var i = 0; i < status.length; i++) {
                    const s = status[i];
                    h.append("<p>" + s.create_date + ": " + s.status +"</p>");
                }
                h.append("<input type='text' autocomplete='off' class='nelson-input' id='update-text' placeholder='Type your order status here...'>");
                h.append("<button class='nelson-button mark-as-update nomarginleft' id='mark-as-update-" + id + "'>Update</button>");
                h.append("<button class='nelson-button mark-as-delivered nomarginleft' id='mark-as-delivered-" + id + "'>Mark as delivered</button>");
                h.append("<hr><h3>Order Items</h3>");
                for (var i = 0; i < orders.length; i++) {
                    const order = orders[i];
                    h.append("<div class='cart-q'><div class='cart-item'><img class='cart-item-image' src='" + order.product.display_image + "'><div class='order-item-info'><h4>" + order.product.name + "</h4><p>Price: RM " + parseFloat(order.price).toFixed(2) + " each, RM " + parseFloat(order.price * order.quantity).toFixed(2) + " total</p><p>Quantity: " + order.quantity + "</p></div></div></div>");
                }
                h.append("<hr><h3>Shipping Address</h3>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.recipient_name + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.contact_number + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.address + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.address_2 + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.city + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>" + address.state + "</p>");
                h.append("<p class='nomargintop'>" + address.zip_code + "</p>");

                h.append("<hr><h3>Price calculation</h3>");
                h.append("<p class='nomargintop nomarginbottom'>Order date: " + date + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Payment method: " + payment + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Price: RM " + parseFloat(price).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Shipping fee: RM " + parseFloat(shipping).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Tax: RM " + parseFloat(tax).toFixed(2) + "</p>");
                h.append("<p class='nomargintop nomarginbottom'>Discount: RM " + parseFloat(discount).toFixed(2) + "</p>");
                h.append("<p class='nomargintop'>Total: RM " + parseFloat(total).toFixed(2) + "</p>");
            }
        });
    });
    $(document).on("click", ".mark-as-shipped", function() {
        console.log("clicked")
        var id = $(this).attr("id");
        if (!id.startsWith("mark-as-shipped-")) return;
        id = id.substring(16);
        var confirm = window.confirm("Are you sure you want to mark the order as shipped?");
        if (!confirm) return;
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/MarkAsShipped",
            data: {
                id: id
            },
            success: function(data) {
                const d = JSON.parse(data);
                if (d.success) {
                    showSnackbar(
                      "src/img/white/check-circle.svg",
                      "Order marked as shipped.",
                      "Reloading page to take effect."
                    );
                    setTimeout(function() {
                        location.reload();
                    }, 3000);
                } else {
                    showSnackbar(
                      "src/img/white/alert-circle.svg",
                        "Failed to mark order as shipped.",
                        "Please try again later."
                    );
                }
            }
        });
    });
    $(document).on("click", ".mark-as-update", function() {
        var id = $(this).attr("id");
        if (!id.startsWith("mark-as-update-")) return;
        id = id.substring(15);
        var text = $("#update-text").val();
        if (text.length < 10) {
            showSnackbar(
              "src/img/white/alert-circle.svg",
              "Order status update too short.",
                "Please type more than 10 characters."
            );
            return;
        }
        var confirm = window.confirm("Are you sure you want to update the order status?");
        if (!confirm) return;
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/MarkAsUpdate",
            data: {
                id: id,
                text: text
            },
            success: function(data) {
                const d = JSON.parse(data);
                if (d.success) {
                    showSnackbar(
                      "src/img/white/check-circle.svg",
                      "Order status updated.",
                      "Reloading page to take effect."
                    );
                    setTimeout(function() {
                        location.reload();
                    }, 3000);
                } else {
                    showSnackbar(
                      "src/img/white/alert-circle.svg",
                        "Failed to update order status.",
                        "Please try again later."
                    );
                }
            }
        });
    });
    $(document).on("click", ".mark-as-delivered", function() {
        var id = $(this).attr("id");
        if (!id.startsWith("mark-as-delivered-")) return;
        id = id.substring(18);
        var confirm = window.confirm("Are you sure you want to mark the order as delivered?");
        if (!confirm) return;
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/MarkAsDelivered",
            data: {
                id: id
            },
            success: function(data) {
                const d = JSON.parse(data);
                if (d.success) {
                    showSnackbar(
                      "src/img/white/check-circle.svg",
                      "Order marked as delivered.",
                      "Reloading page to take effect."
                    );
                    setTimeout(function() {
                        location.reload();
                    }, 3000);
                } else {
                    showSnackbar(
                      "src/img/white/alert-circle.svg",
                        "Failed to mark order as delivered.",
                        "Please try again later."
                    );
                }
            }
        });
    });
});