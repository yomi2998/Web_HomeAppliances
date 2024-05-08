$(document).ready(function () {
  const form = $("#registrationForm");
  form.on("submit", function (event) {
    event.preventDefault();
    var formData = form.serializeArray();
    var password = "";
    var hasErr = false;
    formData.forEach(function (item) {
      switch (item.name) {
        case "name":
          if (item.value.length < 2) {
            $("#invalid-name")
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
            $("#invalid-name")
              .text("First character must be uppercase.")
              .removeClass("hidden");
            hasErr = true;
          }

          var numericRegex = /[0-9]/;
          var symbolRegex = /[!@#$%^&*(),.?":{}|<>]/;
          if (numericRegex.test(item.value)) {
            $("#invalid-name")
              .text("Name must not contain numbers.")
              .removeClass("hidden");
            hasErr = true;
          } else if (symbolRegex.test(item.value)) {
            $("#invalid-name")
              .text("Name must not contain symbols.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "username":
          var alphanumericRegex = /^[a-z0-9]+$/;
          if (!alphanumericRegex.test(item.value)) {
            $("#invalid-username")
              .text("Username must alphanumeric (lowercase).")
              .removeClass("hidden");
            hasErr = true;
          } else if (item.value.length < 3) {
            $("#invalid-username")
              .text("Username must be 3 or more characters.")
              .removeClass("hidden");
            hasErr = true;
          }
          $.ajax({
            url: "/Web_HomeAppliances/Validate",
            type: "POST",
            async: false,
            data: { username: item.value, type: "customer" },
            success: function (data) {
              const out = JSON.parse(data);
              if (!out.success) {
                $("#invalid-username")
                  .text("Username exist.")
                  .removeClass("hidden");
                hasErr = true;
              }
            },
          });
          break;
        case "email":
          var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          if (!emailRegex.test(item.value)) {
            $("#invalid-email")
              .text("Invalid email format.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "password":
          password = item.value;
          if (item.value.length < 8) {
            $("#invalid-password")
              .text("Password must be 8 or more characters.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "cpassword":
          if (item.value !== password) {
            $("#invalid-password-confirm")
              .text("Password mismatch.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "birthdate":
          var birthdate = new Date(item.value);
          var currentDate = new Date();
          if (birthdate >= currentDate) {
            $("#invalid-birth")
              .text("Invalid birthdate.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
      }
    });

    if (!$("#term").is(":checked")) {
      $("#invalid-term")
        .text("Please agree to information above.")
        .removeClass("hidden");
      hasErr = true;
    }

    if (hasErr) {
      return;
    }

    $.ajax({
      url: "/Web_HomeAppliances/Register",
      type: "POST",
      data: form.serialize(),
      success: function (data) {
        console.log(data);
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Registration Successful",
            "Please proceed to login page."
          );
          $("#customer-cancel").click();
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Registration Failed",
            "Please try again later."
          );
        }
      },
    });
  });
  const staff_form = $("#staffRegistrationForm");
  staff_form.on("submit", function (event) {
    event.preventDefault();
    var formData = staff_form.serializeArray();
    var hasErr = false;
    formData.forEach(function (item) {
      switch (item.name) {
        case "name":
          if (item.value.length < 2) {
            $("#staff-invalid-name")
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
            $("#staff-invalid-name")
              .text("First character must be uppercase.")
              .removeClass("hidden");
            hasErr = true;
          }

          var numericRegex = /[0-9]/;
          var symbolRegex = /[!@#$%^&*(),.?":{}|<>]/;
          if (numericRegex.test(item.value)) {
            $("#staff-invalid-name")
              .text("Name must not contain numbers.")
              .removeClass("hidden");
            hasErr = true;
          } else if (symbolRegex.test(item.value)) {
            $("#staff-invalid-name")
              .text("Name must not contain symbols.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "username":
          var alphanumericRegex = /^[a-z0-9]+$/;
          if (!alphanumericRegex.test(item.value)) {
            $("#staff-invalid-username")
              .text("Username must alphanumeric (lowercase).")
              .removeClass("hidden");
            hasErr = true;
          } else if (item.value.length < 3) {
            $("#staff-invalid-username")
              .text("Username must be 3 or more characters.")
              .removeClass("hidden");
            hasErr = true;
          }
          $.ajax({
            url: "/Web_HomeAppliances/Validate",
            type: "POST",
            async: false,
            data: { username: item.value, type: "staff" },
            success: function (data) {
              const out = JSON.parse(data);
              if (!out.success) {
                $("#staff-invalid-username")
                  .text("Username exist.")
                  .removeClass("hidden");
                hasErr = true;
              }
            },
          });
          break;
        case "email":
          var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          if (!emailRegex.test(item.value)) {
            $("#staff-invalid-email")
              .text("Invalid email format.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "birthdate":
          var birthdate = new Date(item.value);
          var currentDate = new Date();
          if (birthdate >= currentDate) {
            $("#staff-invalid-birth")
              .text("Invalid birthdate.")
              .removeClass("hidden");
            hasErr = true;
          }
          break;
        case "contact_number":
          var contactNumberRegex = /^[0-9]+$/;
          if (!contactNumberRegex.test(item.value)) {
            $("#staff-invalid-phone")
              .text("Contact number must be numeric.")
              .removeClass("hidden");
            hasErr = true;
          }
          if (item.value.length < 10) {
            $("#staff-invalid-phone")
              .text("Contact must at least 10 digits.")
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
      url: "/Web_HomeAppliances/RegisterStaff",
      type: "POST",
      data: staff_form.serialize(),
      success: function (data) {
        console.log(data);
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Registration Successful",
            `Password is ${formData[0].value}`
          );
          $("#staff-cancel").click();
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Registration Failed",
            "Please try again later."
          );
        }
      },
    });
  });
});

function register_toggle() {
  const topupExtension = $("#register-extension");
  if (topupExtension.css("display") === "none") {
    topupExtension.css("display", "flex");
    topupExtension.css("opacity", "0");
    setTimeout(function () {
      topupExtension.css("opacity", "1");
    }, 1);
  } else {
    topupExtension.css("opacity", "0");
    setTimeout(function () {
      topupExtension.css("display", "none");
    }, 1000);
  }
}

function remove_reg_error() {
  $("#invalid-name").addClass("hidden");
  $("#invalid-username").addClass("hidden");
  $("#invalid-email").addClass("hidden");
  $("#invalid-password").addClass("hidden");
  $("#invalid-password-confirm").addClass("hidden");
  $("#invalid-birth").addClass("hidden");
  $("#invalid-term").addClass("hidden");
}

function remove_staff_error() {
  $("#staff-invalid-name").addClass("hidden");
  $("#staff-invalid-username").addClass("hidden");
  $("#staff-invalid-email").addClass("hidden");
  $("#staff-invalid-password").addClass("hidden");
  $("#staff-invalid-password-confirm").addClass("hidden");
  $("#staff-invalid-birth").addClass("hidden");
}
