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

$(document).ready(function () {
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
        $("#edit-panel").show();
        $("#ext-profile").show();
        $("#ext-order").hide();
        $("#ext-payment").hide();
        $("#ext-shipping").hide();
        break;
      case "profile-orders":
        $("#edit-panel").hide();
        $("#ext-profile").hide();
        $("#ext-order").show();
        $("#ext-payment").hide();
        $("#ext-shipping").hide();
        break;
      case "profile-payment":
        $("#edit-panel").hide();
        $("#ext-profile").hide();
        $("#ext-order").hide();
        $("#ext-payment").show();
        $("#ext-shipping").hide();
        break;
      case "profile-shipping":
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
