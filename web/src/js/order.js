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
                console.log(o);
                h.append("<hr><h3>Order Status</h3>");
                for (var i = 0; i < status.length; i++) {
                    const s = status[i];
                    h.append("<p>" + s.status + " at " + s.create_date + "</p>");
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
});