function edit_profile() {
  var inputs = $(".toggle-input");
  for (var i = 0; i < inputs.length; i++) {
    if (inputs[i].name === "username") {
      continue;
    }
    inputs[i].toggleAttribute("disabled");

    if (inputs[i].hasAttribute("disabled")) {
      if (inputs[i].type !== "password") {
        inputs[i].value = inputs[i].getAttribute("placeholder");
      } else {
        inputs[i].value = "";
      }
    }
  }
  $(".profile-edit-hide").toggle();
  $(".profile-edit-show").toggle();
  $("#ext-profile-edit").toggle();
  $("#ext-profile-edit-pw").toggle();
  $("#ext-profile-done").toggle();
  $("#ext-profile-cancel").toggle();
  remove_profile_error();
}

function togglePasswordForm() {
  remove_profile_error();
  $("#profilePasswordForm").toggle();
  $("#profileForm").toggle();
  $("#ext-profile-edit").toggle();
  $("#ext-profile-edit-pw").toggle();
  $("#ext-profile-pw-done").toggle();
  $("#ext-profile-pw-cancel").toggle();
}

function remove_profile_error() {
  $("#profile-invalid-name").addClass("hidden");
  $("#profile-invalid-email").addClass("hidden");
  $("#invalid-password").addClass("hidden");
  $("#invalid-birth").addClass("hidden");
  $("#invalid-password-old").addClass("hidden");
  $("#invalid-password-new").addClass("hidden");
  $("#invalid-password-confirm").addClass("hidden");
  $("#invalid-password-confirm-ii").addClass("hidden");
}

function remove_card_alter_error() {
  $("#alter-card-invalid-number").addClass("hidden");
  $("#alter-card-invalid-name").addClass("hidden");
  $("#alter-card-invalid-expiry-date").addClass("hidden");
  $("#alter-card-invalid-cvv").addClass("hidden");
}

function remove_card_add_error() {
  $("#add-card-invalid-number").addClass("hidden");
  $("#add-card-invalid-name").addClass("hidden");
  $("#add-card-invalid-expiry-date").addClass("hidden");
  $("#add-card-invalid-cvv").addClass("hidden");
}

$(document).ready(function () {
  var cardAddForm = $("#cardAddForm");
  cardAddForm.on("submit", function (event) {
    remove_card_add_error();
    event.preventDefault();
    var formData = cardAddForm.serializeArray();
    var hasErr = false;
    var sendData = {
      card_number: "",
      name: "",
      expiry_date: "",
      cvv: "",
      password: "",
    };
    formData.forEach(function (item) {
      switch (item.name) {
        case "card_number":
          var cardNumberRegex = /^[0-9]{16}$/;
          if (!cardNumberRegex.test(item.value)) {
            $("#add-card-invalid-number")
              .text("Card number must be 16 digits.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.card_number = item.value;
          break;
        case "name":
          if (item.value.length < 2) {
            $("#add-card-invalid-name")
              .text("Name must be 2 or more characters.")
              .removeClass("hidden");
            hasErr = true;
          }

          var nameWords = item.value.split(" ");
          var isCapitalized = true;
          nameWords.forEach(function (word) {
            if (
              word.length > 0 &&
              !word[0].match(
                /[A-Z\u4E00-\u9FFF\u3040-\u309F\u30A0-\u30FF\uAC00-\uD7AF]/
              )
            ) {
              // The regex now includes the Unicode ranges for CJK characters:
              // Chinese: \u4E00-\u9FFF
              // Japanese Hiragana and Katakana: \u3040-\u309F, \u30A0-\u30FF
              // Korean Hangul: \uAC00-\uD7AF
              isCapitalized = false;
            }
          });

          if (!isCapitalized) {
            $("#add-card-invalid-name")
              .text("First character must be uppercase.")
              .removeClass("hidden");
            hasErr = true;
          }

          var numericRegex = /[0-9]/;
          var symbolRegex = /[!@#$%^&*(),.?":{}|<>]/;
          if (numericRegex.test(item.value)) {
            $("#add-card-invalid-name")
              .text("Name must not contain numbers.")
              .removeClass("hidden");
            hasErr = true;
          } else if (symbolRegex.test(item.value)) {
            $("#add-card-invalid-name")
              .text("Name must not contain symbols.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.name = item.value;
          break;
        case "expiry_date":
          // eg: 03/29
          var expiryDateRegex = /^(0[1-9]|1[0-2])\/[0-9]{2}$/;
          if (!expiryDateRegex.test(item.value)) {
            $("#add-card-invalid-expiry")
              .text("Expiry date must be in MM/YY format.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.expiry_date = item.value;
          break;
        case "cvv":
          var cvvRegex = /^[0-9]{3}$/;
          if (!cvvRegex.test(item.value)) {
            $("#add-card-invalid-cvv")
              .text("CVV must be numeric, 3 digits.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.cvv = item.value;
          break;
      }
    });
    if (hasErr) {
      return;
    }
    var password = prompt(
      "To verify it's you, please enter your password.",
      ""
    );
    if (password === null) {
      return;
    }
    sendData.password = password;
    $.ajax({
      url: "/Web_HomeAppliances/CardAdd",
      type: "POST",
      data: sendData,
      success: function (data) {
        console.log(data);
        const out = JSON.parse(data);
          if (out.success) {
            showSnackbar(
              "src/img/white/check-circle.svg",
              "Card added successfully",
              "Please reload your page to take effect."
            );
            $("#card-add-panel").hide();
            $(".card-add").hide();
            $(".list-div").show();
            var card = out.card;
            var cardn = card.card_number;
            var cardInfo = `<div class="payment-method" id="${card.id}">
            <img src="src/img/white/credit-card.svg" alt="card" class="left card-logo" style="height: 30px;">
            <p class="card-info" id="${card.id}">${card.name} ${cardn.substring(0, 4)}-XXXX-XXXX-XXXX</p>
            <div class="card-dropdown" id="${card.id}">
                <img src="src/img/white/more-horizontal.svg" alt="more" class="right pay-extend-img" style="height: 30px;">
                <div class="card-dropdown-content" id="${card.id}">
                    <a href="#" class="card-edit-button" id="${card.id}">Edit</a>
                    <a href="#" class="card-delete-button" id="${card.id}">Delete</a>
                </div>
            </div>
        </div>
        <hr style="margin:0" id="${card.id}">`;
            $(".payment-method-list").prepend(cardInfo);
            $("#card-insert-reset").click();
          } else {
            switch (out.cause) {
              case "password":
                showSnackbar(
                  "src/img/white/alert-circle.svg",
                  "Password incorrect",
                  "Please try again."
                );
                break;
              case "card":
                showSnackbar(
                  "src/img/white/alert-circle.svg",
                  "Card already exists",
                  "Please try again."
                );
                break;
            }
          }
      },
    });
  });

  $("#add-card").click(function () {
    $("#card-add-panel").show();
    $("#card-edit-panel").hide();
    $(".card-edit").hide();
    $(".list-div").hide();
    $(".card-add").show();
  });
  // $(".card-delete-button").click(function () {
  $(document).on("click", ".card-delete-button", function () {
    var id = $(this).attr("id");
    var pw = prompt("To verify it's you, please enter your password.", "");
    if (pw === null) {
      return;
    }
    $.ajax({
      url: "/Web_HomeAppliances/CardDelete",
      type: "POST",
      data: { password: pw, card_id: id },
      success: function (data) {
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Card deleted successfully",
            "Please reload your page to take effect."
          );
          $(".payment-method" + `#${id}`).remove();
          $(`hr#${id}`).remove();
        } else {
          switch (out.cause) {
            case "password":
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Password incorrect",
                "Please try again."
              );
              break;
            case "card":
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Card not found",
                "Please try again."
              );
              break;
          }
        }
      },
    });
  });

  var cardEditForm = $("#cardEditForm");
  cardEditForm.on("submit", function (event) {
    remove_card_alter_error();
    event.preventDefault();
    var formData = cardEditForm.serializeArray();
    var id = $("#alter-card-id").val();
    var hasErr = false;
    var sendData = {
      card_id: "",
      card_number: "",
      name: "",
      expiry_date: "",
      cvv: "",
      password: "",
    };
    formData.forEach(function (item) {
      switch (item.name) {
        case "card_number":
          var cardNumberRegex = /^[0-9]{16}$/;
          if (!cardNumberRegex.test(item.value)) {
            $("#alter-card-invalid-number")
              .text("Card number must be 16 digits.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.card_number = item.value;
          break;
        case "name":
          if (item.value.length < 2) {
            $("#alter-card-invalid-name")
              .text("Name must be 2 or more characters.")
              .removeClass("hidden");
            hasErr = true;
          }

          var nameWords = item.value.split(" ");
          var isCapitalized = true;
          nameWords.forEach(function (word) {
            if (
              word.length > 0 &&
              !word[0].match(
                /[A-Z\u4E00-\u9FFF\u3040-\u309F\u30A0-\u30FF\uAC00-\uD7AF]/
              )
            ) {
              // The regex now includes the Unicode ranges for CJK characters:
              // Chinese: \u4E00-\u9FFF
              // Japanese Hiragana and Katakana: \u3040-\u309F, \u30A0-\u30FF
              // Korean Hangul: \uAC00-\uD7AF
              isCapitalized = false;
            }
          });

          if (!isCapitalized) {
            $("#alter-card-invalid-name")
              .text("First character must be uppercase.")
              .removeClass("hidden");
            hasErr = true;
          }

          var numericRegex = /[0-9]/;
          var symbolRegex = /[!@#$%^&*(),.?":{}|<>]/;
          if (numericRegex.test(item.value)) {
            $("#alter-card-invalid-name")
              .text("Name must not contain numbers.")
              .removeClass("hidden");
            hasErr = true;
          } else if (symbolRegex.test(item.value)) {
            $("#alter-card-invalid-name")
              .text("Name must not contain symbols.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.name = item.value;
          break;
        case "expiry_date":
          // eg: 03/29
          var expiryDateRegex = /^(0[1-9]|1[0-2])\/[0-9]{2}$/;
          if (!expiryDateRegex.test(item.value)) {
            $("#alter-card-invalid-expiry")
              .text("Expiry date must be in MM/YY format.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.expiry_date = item.value;
          break;
        case "cvv":
          var cvvRegex = /^[0-9]{3}$/;
          if (!cvvRegex.test(item.value)) {
            $("#alter-card-invalid-cvv")
              .text("CVV must be numeric, 3 digits.")
              .removeClass("hidden");
            hasErr = true;
          }
          sendData.cvv = item.value;
          break;
      }
    });
    if (hasErr) {
      return;
    }
    var password = prompt(
      "To verify it's you, please enter your password.",
      ""
    );
    if (password === null) {
      return;
    }
    sendData.card_id = id;
    sendData.password = password;
    $.ajax({
      url: "/Web_HomeAppliances/CardAlter",
      type: "POST",
      data: sendData,
      success: function (data) {
        console.log(data);
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Card updated successfully",
            "Please reload your page to take effect."
          );
          // note that out variable does not contain the updated card information
          // so we use the form data to update the card info
          $("#card-edit-panel").hide();
          $(".card-edit").hide();
          $(".list-div").show();
          $(".card-info" + `#${id}`).text(
            `${sendData.name} ${sendData.card_number}-XXXX-XXXX-XXXX`
          );
        } else {
          switch (out.cause) {
            case "password":
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Password incorrect",
                "Please try again."
              );
              break;
            case "card":
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Card not found",
                "Please try again later."
              );
              break;
          }
        }
      },
    });
  });
  $("#ext-card-add-cancel").click(function () {
    $("#card-add-panel").hide();
    $(".card-add").hide();
    $(".list-div").show();
  });
  $("#ext-card-edit-cancel").click(function () {
    $("#card-edit-panel").hide();
    $(".card-edit").hide();
    $(".list-div").show();
  });
  //$(".card-edit-button").click(function () {
  $(document).on("click", ".card-edit-button", function () {
    var id = $(this).attr("id");
    var pw = prompt("To verify it's you, please enter your password.", "");
    if (pw === null) {
      return;
    }
    $.ajax({
      url: "/Web_HomeAppliances/CardRetrieveSpecific",
      type: "POST",
      data: { password: pw, card_id: id },
      success: function (data) {
        const out = JSON.parse(data);
        if (out.success) {
          $("#card-edit-panel").show();
          $("#card-add-panel").hide();
          $(".card-edit").show();
          $(".list-div").hide();
          const card = out.card;
          $("#alter-card-id").val(card.id);
          $("#alter-card-number").val(card.card_number);
          $("#alter-card-name").val(card.name);
          $("#alter-card-expiry-date").val(card.expiry_date);
        } else {
          switch (out.cause) {
            case "password":
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Password incorrect",
                "Please try again."
              );
              break;
            case "card":
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Card not found",
                "Please try again."
              );
              break;
          }
        }
      },
    });
  });
  //$(".card-dropdown").click(function () {
  $(document).on("click", ".card-dropdown", function () {
    var id = $(this).attr("id");
    // card-dropdown-content is the class of the dropdown content
    $("#" + id + ".card-dropdown-content").show();
    $(".card-dropdown-content")
      .not($("#" + id + ".card-dropdown-content"))
      .hide();
  });
  $(document).click(function (event) {
    var target = $(event.target);
    if (!target.closest(".card-dropdown").length) {
      $(".card-dropdown-content").hide();
    }
  });
  $(".ext-profile-select").click(function () {
    var id = $(this).attr("id");
    var selectList = [
      "profile-info",
      "profile-orders",
      "profile-payment",
      "profile-shipping",
    ];

    selectList.forEach(function (item) {
      if (item === id) {
        $("#" + item).addClass("ext-profile-selected");
      } else {
        $("#" + item).removeClass("ext-profile-selected");
      }
    });
    switch (id) {
      case "profile-info":
        $("#card-panel").hide();
        $("#edit-panel").show();
        $("#ext-profile").show();
        $("#ext-order").hide();
        $("#ext-payment").hide();
        $("#ext-shipping").hide();
        break;
      case "profile-orders":
        $("#card-panel").hide();
        $("#edit-panel").hide();
        $("#ext-profile").hide();
        $("#ext-order").show();
        $("#ext-payment").hide();
        $("#ext-shipping").hide();
        break;
      case "profile-payment":
        $("#card-panel").show();
        $("#edit-panel").hide();
        $("#ext-profile").hide();
        $("#ext-order").hide();
        $("#ext-payment").show();
        $("#ext-shipping").hide();
        break;
      case "profile-shipping":
        $("#card-panel").hide();
        $("#edit-panel").hide();
        $("#ext-profile").hide();
        $("#ext-order").hide();
        $("#ext-payment").hide();
        $("#ext-shipping").show();
        break;
    }
  });
  const form = $("#profileForm");
  form.on("submit", function (event) {
    event.preventDefault();
    remove_profile_error();
    var formData = form.serializeArray();
    var password = "";
    var hasErr = false;
    formData.forEach(function (item) {
      switch (item.name) {
        case "name":
          if (item.value.length < 2) {
            $("#profile-invalid-name")
              .text("Name must be 2 or more characters.")
              .removeClass("hidden");
            hasErr = true;
          }

          var nameWords = item.value.split(" ");
          var isCapitalized = true;
          nameWords.forEach(function (word) {
            if (
              word.length > 0 &&
              !word[0].match(
                /[A-Z\u4E00-\u9FFF\u3040-\u309F\u30A0-\u30FF\uAC00-\uD7AF]/
              )
            ) {
              // The regex now includes the Unicode ranges for CJK characters:
              // Chinese: \u4E00-\u9FFF
              // Japanese Hiragana and Katakana: \u3040-\u309F, \u30A0-\u30FF
              // Korean Hangul: \uAC00-\uD7AF
              isCapitalized = false;
            }
          });

          if (!isCapitalized) {
            $("#profile-invalid-name")
              .text("First character must be uppercase.")
              .removeClass("hidden");
            hasErr = true;
          }

          var numericRegex = /[0-9]/;
          var symbolRegex = /[!@#$%^&*(),.?":{}|<>]/;
          if (numericRegex.test(item.value)) {
            $("#profile-invalid-name")
              .text("Name must not contain numbers.")
              .removeClass("hidden");
            hasErr = true;
          } else if (symbolRegex.test(item.value)) {
            $("#profile-invalid-name")
              .text("Name must not contain symbols.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "email":
          var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          if (!emailRegex.test(item.value)) {
            $("#profile-invalid-email")
              .text("Invalid email format.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "birthdate":
          var birthdate = new Date(item.value);
          var currentDate = new Date();
          if (birthdate >= currentDate) {
            $("#profile-invalid-birth")
              .text("Invalid birthdate.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
      }
    });
    if (hasErr) {
      return;
    }

    $.ajax({
      url: "/Web_HomeAppliances/Alter",
      type: "POST",
      data: form.serialize(),
      success: function (data) {
        console.log(data);
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Profile updated successfully",
            "Please reload your page to take effect."
          );
          edit_profile();
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Profile update failed",
            "Please check your password and try again."
          );
        }
      },
    });
  });
  const form2 = $("#profilePasswordForm");
  form2.on("submit", function (event) {
    event.preventDefault();
    console.log("get");
    remove_profile_error();
    var formData = form2.serializeArray();
    var hasErr = false;
    var password = "";
    formData.forEach(function (item) {
      switch (item.name) {
        case "password":
          if (item.value.length < 8) {
            $("#invalid-password-new")
              .text("Password must be 8 or more characters.")
              .removeClass("hidden");
            hasErr = true;
          }
          password = item.value;
          break;
        case "cpassword":
          if (item.value !== password) {
            $("#invalid-password-confirm-ii")
              .text("Passwords mismatch.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
      }
    });
    if (hasErr) {
      console.log("error");
      return;
    }

    $.ajax({
      url: "/Web_HomeAppliances/AlterPass",
      type: "POST",
      data: form2.serialize(),
      success: function (data) {
        console.log(data);
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Password updated successfully",
            "Password has been updated successfully."
          );
          togglePasswordForm();
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Password update failed",
            "Please check your password and try again."
          );
        }
      },
    });
  });
});
