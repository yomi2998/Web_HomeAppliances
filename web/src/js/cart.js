$(document).ready(function(){
    $("#quantityForm").submit(function(e){
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/AddToCart",
            data: $("#quantityForm").serialize(),
            success: function(data){
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
            }
        });
    });
    $(".cart-minus-button").click(function(){
        var id = $(this).attr("id");
        const quantity = parseInt($(`#cart-item-${id} input`).val());
        if (quantity <= 1) return;
        // <p class="cart-item-text-price-total"><%= String.format("RM %.2f total", cartProd.getPrice() * quantity) %></p>
        $(`#cart-q-${id} div div .cart-item-text-price-total`).text(`RM ${(parseFloat($(`#cart-q-${id} div div .cart-item-text-price`).text().split(" ")[1]) * (quantity - 1)).toFixed(2)} total`);
        if (quantity > 1) {
            $(`#cart-item-${id} input`).val(quantity - 1);
        }
    });
    $(".cart-plus-button").click(function(){
        var id = $(this).attr("id");
        // <p class="cart-item-text-price-total"><%= String.format("RM %.2f total", cartProd.getPrice() * quantity) %></p>
        var max = $(`#cart-item-${id} input`).attr("max");
        const quantity = parseInt($(`#cart-item-${id} input`).val());
        if (quantity >= max) return;
        $(`#cart-q-${id} div div .cart-item-text-price-total`).text(`RM ${(parseFloat($(`#cart-q-${id} div div .cart-item-text-price`).text().split(" ")[1]) * (quantity + 1)).toFixed(2)} total`);
        $(`#cart-item-${id} input`).val(quantity + 1 > max ? max : quantity + 1);
    });
    $(".cart-rem-button").click(function(){
        var confirm = window.confirm("Are you sure you want to remove this item from your cart?");
        if (!confirm) return;
        var id = $(this).attr("id");
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/RemoveFromCart",
            data: {product_id: id},
            success: function(data){
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
            }
        });
    });
    $(".cart-quantity").change(function(){
        var id = $(this).attr("id");
        var max = $(this).attr("max");
        var quantity = parseInt($(this).val());
        if (quantity > max) {
            $(this).val(max);
            quantity = max;
        } else if (quantity < 1) {
            $(this).val(1);
            quantity = 1;
        }
        $(`#cart-q-${id} div div .cart-item-text-price-total`).text(`RM ${(parseFloat($(`#cart-q-${id} div div .cart-item-text-price`).text().split(" ")[1]) * quantity).toFixed(2)} total`);
    });
});