$(document).ready(function () {
  const amountButtons = $(".amount-buttons button");
  const selectedAmountDisplay = $("#displayedAmount");

  amountButtons.on("click", function () {
    const amount = $(this).val();
    selectedAmountDisplay.text(`RM ${amount}`);
    $("#topup-amount").val(amount);
  });

  $(".topup-card-refresh").click(function () {
    $.ajax({
      url: "/Web_HomeAppliances/CardRetrieve",
      type: "GET",
      success: function (data) {
        const cards = JSON.parse(data);
        const select = $(".topup-card-select");
        select.empty();
        select.append('<option value="0">Select card</option>');
        cards.forEach((card) => {
          select.append(
            `<option value="${card.id}">${
              card.name
            } ${card.card_number.substring(0, 4)}-XXXX-XXXX-XXXX</option>`
          );
        });
      },
    });
  });

  var form = $("#topup-form");

  form.on("submit", function (e) {
    clear_topup_error();
    e.preventDefault();
    console.log("submit");
    var formData = form.serializeArray();
    console.log(formData);
    var hasError = false;
    var sendData = {
      amount: "",
      card_id: "",
      password: "",
    };
    formData.forEach((data) => {
      switch (data.name) {
        case "amount":
          if (data.value === "0") {
            $("#topup-invalid-amount").show();
            $("#topup-invalid-amount").text("Please select top up amount.");
            hasError = true;
          }
          sendData.amount = data.value;
          break;
        case "card_id":
          if (data.value === "0") {
            $("#topup-invalid-card").show();
            $("#topup-invalid-card").text("Please select card.");
            hasError = true;
          }
          sendData.card_id = data.value;
          break;
      }
    });
    if (hasError) {
      return;
    }
    sendData.password = prompt(
      "To verify if it's you, please enter your password.",
      ""
    );
    const data = form.serialize();
    $.ajax({
      url: "/Web_HomeAppliances/Topup",
      type: "POST",
      data: sendData,
      success: function (data) {
        const response = JSON.parse(data);
        if (response.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Top up successful.",
            "Top up successful, reloading page to take effect."
          );
          setTimeout(() => {
            window.location.reload();
          }, 2000);
          extension_toggle("topup-extension");
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Invalid password.",
            "Invalid password entered, please try again."
          );
        }
      },
    });
  });
});

function clear_topup_error() {
  $("#topup-invalid-amount").hide();
  $("#topup-invalid-card").hide();
}
