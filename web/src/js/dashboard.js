remove_edit_cust_reg_error = function () {
  $("#customer-edit-invalid-name").hide();
  $("#customer-edit-invalid-email").hide();
  $("#customer-edit-invalid-username").hide();
  $("#customer-edit-invalid-birth").hide();
};

remove_edit_staff_reg_error = function () {
  $("#staff-edit-invalid-name").hide();
  $("#staff-edit-invalid-email").hide();
  $("#staff-edit-invalid-username").hide();
  $("#staff-edit-invalid-birth").hide();
  $("#staff-edit-invalid-contact-number").hide();
};

toggleEditCustomer = function (id) {
  $.ajax({
    url: "/Web_HomeAppliances/CustomerRetrieve",
    type: "POST",
    data: {
      id: id,
    },
    success: function (data) {
      const out = JSON.parse(data);
      if (out.success) {
        var customer = out.customer;
        var form = $("#editCustomer");
        form.find("input[name='id']").val(customer.id);
        form.find("input[name='id']").attr("placeholder", customer.id);
        form.find("input[name='name']").val(customer.name);
        form.find("input[name='name']").attr("placeholder", customer.name);
        form.find("input[name='username']").val(customer.username);
        form
          .find("input[name='username']")
          .attr("placeholder", customer.username);
        form.find("input[name='email']").val(customer.email);
        form.find("input[name='email']").attr("placeholder", customer.email);
        var birth = new Date(customer.birthDate);
        birth = birth.toISOString().substring(0, 10);
        form.find("input[name='birthdate']").val(birth);
        form.find("input[name='birthdate']").attr("placeholder", birth);
        setTimeout(extension_toggle("editCustomer"), 100);
      } else {
        showSnackbar(
          "src/img/white/alert-circle.svg",
          "Get customer.",
          "Failed to retrieve customer information."
        );
      }
    },
  });
};

toggleDeleteCustomer = function (id) {
  var confirmDelete = confirm("Are you sure you want to delete this customer?");
  if (!confirmDelete) {
    return;
  }
  var id = id.split("-")[2];
  $.ajax({
    url: "/Web_HomeAppliances/ForceDelete",
    type: "POST",
    data: {
      id: id,
      type: "customer",
    },
    success: function (data) {
      const out = JSON.parse(data);
      if (out.success) {
        showSnackbar(
          "src/img/white/check-circle.svg",
          "Delete successful",
          "Reloading page to take effect."
        );
        setTimeout(function () {
          location.reload();
        }, 2000);
      } else {
        showSnackbar(
          "src/img/white/alert-circle.svg",
          "Delete failed",
          "Failed to delete customer."
        );
      }
    },
  });
};

toggleEditStaff = function (id) {
  $.ajax({
    url: "/Web_HomeAppliances/StaffRetrieve",
    type: "POST",
    data: {
      id: id,
    },
    success: function (data) {
      const out = JSON.parse(data);
      if (out.success) {
        var staff = out.staff;
        var form = $("#editStaff");
        form.find("input[name='id']").val(staff.id);
        form.find("input[name='id']").attr("placeholder", staff.id);
        form.find("input[name='name']").val(staff.name);
        form.find("input[name='name']").attr("placeholder", staff.name);
        form.find("input[name='username']").val(staff.username);
        form.find("input[name='username']").attr("placeholder", staff.username);
        form.find("input[name='email']").val(staff.email);
        form.find("input[name='email']").attr("placeholder", staff.email);
        var birth = new Date(staff.birth_date);
        birth = birth.toISOString().substring(0, 10);
        form.find("input[name='birthdate']").val(birth);
        form.find("input[name='birthdate']").attr("placeholder", birth);
        form.find("input[name='contact_number']").val(staff.contact_number);
        form
          .find("input[name='contact_number']")
          .attr("placeholder", staff.contact_number);
        setTimeout(extension_toggle("editStaff"), 100);
      } else {
        showSnackbar(
          "src/img/white/alert-circle.svg",
          "Get staff.",
          "Failed to retrieve staff information."
        );
      }
    },
  });
};

toggleDeleteStaff = function (id) {
  var confirmDelete = confirm("Are you sure you want to delete this staff?");
  if (!confirmDelete) {
    return;
  }
  var id = id.split("-")[2];
  $.ajax({
    url: "/Web_HomeAppliances/ForceDelete",
    type: "POST",
    data: {
      id: id,
      type: "staff",
    },
    success: function (data) {
      const out = JSON.parse(data);
      if (out.success) {
        showSnackbar(
          "src/img/white/check-circle.svg",
          "Delete successful",
          "Reloading page to take effect."
        );
        setTimeout(function () {
          location.reload();
        }, 2000);
      } else {
        showSnackbar(
          "src/img/white/alert-circle.svg",
          "Delete failed",
          "Failed to delete staff."
        );
      }
    },
  });
};

$(document).ready(function () {
  $("#customerEditForm").submit(function (event) {
    event.preventDefault();
    remove_edit_cust_reg_error();
    var formData = $(this).serializeArray();
    var hasErr = false;
    formData.forEach(function (item) {
      switch (item.name) {
        case "username":
          var alphanumericRegex = /^[a-z0-9]+$/;
          if (!alphanumericRegex.test(item.value)) {
            $("#customer-edit-invalid-username")
              .text("Username must alphanumeric (lowercase).")
              .show();
            hasErr = true;
          } else if (item.value.length < 3) {
            $("#customer-edit-invalid-username")
              .text("Username must be 3 or more characters.")
              .show();
            hasErr = true;
          }
          $.ajax({
            url: "/Web_HomeAppliances/Validate",
            type: "POST",
            async: false,
            data: { username: item.value, id: formData[0].value, type: "customer" },
            success: function (data) {
              const out = JSON.parse(data);
              if (!out.success) {
                $("#customer-edit-invalid-username")
                  .text("Username exist.")
                  .show();
                hasErr = true;
              }
            },
          });
          break;
        case "name":
          if (item.value.length < 2) {
            $("#customer-edit-invalid-name")
              .text("Name must be 2 or more characters.")
              .show();
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
            $("#customer-edit-invalid-name")
              .text("First character must be uppercase.")
              .show();
            hasErr = true;
          }

          var numericRegex = /[0-9]/;
          var symbolRegex = /[!@#$%^&*(),.?":{}|<>]/;
          if (numericRegex.test(item.value)) {
            $("#customer-edit-invalid-name")
              .text("Name must not contain numbers.")
              .show();
            hasErr = true;
          } else if (symbolRegex.test(item.value)) {
            $("#customer-edit-invalid-name")
              .text("Name must not contain symbols.")
              .show();
            hasErr = true;
          }
          break;
        case "email":
          var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          if (!emailRegex.test(item.value)) {
            $("#customer-edit-invalid-email")
              .text("Invalid email format.")
              .show();
            hasErr = true;
          }
          break;
        case "birthdate":
          var birthdate = new Date(item.value);
          var currentDate = new Date();
          if (birthdate >= currentDate) {
            $("#customer-edit-invalid-birth").text("Invalid birthdate.").show();
            hasErr = true;
          }
          break;
      }
    });
    if (hasErr) {
      return;
    }
    $.ajax({
      url: "/Web_HomeAppliances/ForceAlter",
      type: "POST",
      data: formData,
      success: function (data) {
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Edit successful",
            "Reloading page to take effect."
          );
          setTimeout(function () {
            location.reload();
          }, 2000);
          extension_toggle("editCustomer");
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Edit failed",
            "Failed to edit customer information."
          );
        }
      },
    });
  });
  $("#staffEditForm").submit(function (event) {
    event.preventDefault();
    remove_edit_staff_reg_error();
    var formData = $(this).serializeArray();
    var hasErr = false;
    formData.forEach(function (item) {
      switch (item.name) {
        case "username":
          var alphanumericRegex = /^[a-z0-9]+$/;
          if (!alphanumericRegex.test(item.value)) {
            $("#staff-edit-invalid-username")
              .text("Username must alphanumeric (lowercase).")
              .show();
            hasErr = true;
          } else if (item.value.length < 3) {
            $("#staff-edit-invalid-username")
              .text("Username must be 3 or more characters.")
              .show();
            hasErr = true;
          }
          $.ajax({
            url: "/Web_HomeAppliances/Validate",
            type: "POST",
            async: false,
            data: { username: item.value, id: formData[0].value, type: "staff" },
            success: function (data) {
              const out = JSON.parse(data);
              if (!out.success) {
                $("#staff-edit-invalid-username")
                  .text("Username exist.")
                  .show();
                hasErr = true;
              }
            },
          });
          break;
        case "name":
          if (item.value.length < 2) {
            $("#staff-edit-invalid-name")
              .text("Name must be 2 or more characters.")
              .show();
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
            $("#staff-edit-invalid-name")
              .text("First character must be uppercase.")
              .show();
            hasErr = true;
          }

          var numericRegex = /[0-9]/;
          var symbolRegex = /[!@#$%^&*(),.?":{}|<>]/;
          if (numericRegex.test(item.value)) {
            $("#staff-edit-invalid-name")
              .text("Name must not contain numbers.")
              .show();
            hasErr = true;
          } else if (symbolRegex.test(item.value)) {
            $("#staff-edit-invalid-name")
              .text("Name must not contain symbols.")
              .show();
            hasErr = true;
          }
          break;
        case "email":
          var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          if (!emailRegex.test(item.value)) {
            $("#staff-edit-invalid-email").text("Invalid email format.").show();
            hasErr = true;
          }
          break;
        case "birthdate":
          var birthdate = new Date(item.value);
          var currentDate = new Date();
          if (birthdate >= currentDate) {
            $("#staff-edit-invalid-birth").text("Invalid birthdate.").show();
            hasErr = true;
          }
          break;
        case "contact_number":
          var contactNumberRegex = /^\d{9,12}$/;
          if (!contactNumberRegex.test(item.value)) {
            $("#staff-edit-invalid-contact-number")
              .text("Contact number must be between 9 and 12 digits.")
              .show();
            hasErr = true;
          }
          break;
      }
    });
    if (hasErr) {
      return;
    }
    $.ajax({
      url: "/Web_HomeAppliances/ForceAlterStaff",
      type: "POST",
      data: formData,
      success: function (data) {
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Edit successful",
            "Reloading page to take effect."
          );
          setTimeout(function () {
            location.reload();
          }, 2000);
          extension_toggle("editStaff");
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Edit failed",
            "Failed to edit staff information."
          );
        }
      },
    });
  });
  $(".cust-manage").click(function () {
    var id = $(this).attr("id");
    if (id.includes("delete")) {
      toggleDeleteCustomer(id);
    } else if (id.includes("edit")) {
      id = id.split("-")[2];
      toggleEditCustomer(id);
    }
  });
  $(".staff-manage").click(function () {
    var id = $(this).attr("id");
    if (id.includes("delete")) {
      toggleDeleteStaff(id);
    } else if (id.includes("edit")) {
      id = id.split("-")[2];
      toggleEditStaff(id);
    }
  });
});
