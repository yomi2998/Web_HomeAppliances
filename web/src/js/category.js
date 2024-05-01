$(document).ready(function () {
  $("#categoryRenameForm").submit(function (event) {
    event.preventDefault();
    var id = $("#alter-category-id").val();
    $.ajax({
      type: "POST",
      url: "/Web_HomeAppliances/CategoryAlter",
      data: $("#categoryRenameForm").serialize(),
      success: function (data) {
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Rename successful",
            "Category renamed successfully."
          );
          $("#" + id + ".category-info").text($("#alter-category-name").val());
          $(".rename-category").hide();
          $(".category-list").show();
        }
      },
    });
  });

  $("#categoryAddForm").submit(function (event) {
    event.preventDefault();
    $.ajax({
      type: "POST",
      url: "/Web_HomeAppliances/CategoryAdd",
      data: $("#categoryAddForm").serialize(),
      success: function (data) {
        const out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Add successful",
            "Category added successfully."
          );
          $(".category-list").append(
            `<div class="category-item" id="${out.id}">
                    <p class="category-info" id="${out.id}">${$(
              "#add-category-name"
            ).val()}</p>
                    <div class="category-dropdown" id="${out.id}">
                        <img src="src/img/white/more-horizontal.svg" alt="more" class="right category-extend-img" style="height: 30px;">
                        <div class="category-dropdown-content" id="${out.id}">
                            <a href="#" class="category-edit-button" id="${
                              out.id
                            }">Rename</a>
                            <a href="#" class="category-delete-button" id="${
                              out.id
                            }">Delete</a>
                        </div>
                    </div>
                </div>
                <hr style="margin:0" id="${out.id}">`
          );
          $(".category-add-cancel-button").click();
          $(".add-category").hide();
          $(".category-list-tab").show();
        }
      },
    });
  });
});

$(document).on("click", ".category-dropdown", function () {
  var id = $(this).attr("id");
  //<div class="category-dropdown-content" id="<%= category.getId() %>">
  $("#" + id + ".category-dropdown-content").show();
});

$(document).on("click", function (event) {
  if (window.getSelection().toString().length > 0) {
    return;
  }
  var target = $(event.target);
  var categoryDropdown = $(".category-dropdown");
  for (var i = 0; i < categoryDropdown.length; i++) {
    if (!target.closest(categoryDropdown[i]).length) {
      $("#" + categoryDropdown[i].id + ".category-dropdown-content").hide();
    }
  }
});

$(document).on("click", ".category-edit-button", function () {
  var id = $(this).attr("id");
  $("#alter-category-id").val(id);
  $("#alter-category-name").val($("#" + id + ".category-info").text());

  $(".category-list-tab").hide();
  $(".rename-category").show();
});

$(document).on("click", ".category-delete-button", function () {
  var id = $(this).attr("id");
  var confirm = window.confirm(
    "Are you sure you want to delete this category?"
  );
  if (!confirm) {
    return;
  }
  $.ajax({
    type: "POST",
    url: "/Web_HomeAppliances/CategoryDelete",
    data: { id: id },
    success: function (data) {
      const out = JSON.parse(data);
      if (out.success) {
        showSnackbar(
          "src/img/white/check-circle.svg",
          "Delete successful",
          "Category deleted successfully."
        );
        $("#" + id + ".category-item").remove();
        setTimeout(function () {
            $("hr#" + id).remove();
        }, 1);
      }
    },
  });
});

$(document).on("click", "#category-add-button", function () {
  $(".category-list-tab").hide();
  $(".add-category").show();
});

$(document).on("click", ".category-edit-cancel-button", function () {
  $(".rename-category").hide();
  $(".category-list-tab").show();
});

$(document).on("click", ".category-add-cancel-button", function () {
  $("#add-category-name").val("");
  $(".add-category").hide();
  $(".category-list-tab").show();
});
