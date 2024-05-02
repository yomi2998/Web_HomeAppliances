var dpData = "";
var subDpData = [];
$(document).ready(function () {
  $("#add-tab").click(function () {
    $("#view-tab").removeClass("focus");
    $("#add-tab").addClass("focus");
    $("#product-tab").hide();
    $("#edit-product-tab").hide();
    $("#add-product-tab").show();
  });

  $("#view-tab").click(function () {
    $("#add-tab").removeClass("focus");
    $("#view-tab").addClass("focus");
    $("#edit-product-tab").hide();
    $("#add-product-tab").hide();
    $("#product-tab").show();
  });

  $("#view-tab").click(function () {
    $("#add-tab").removeClass("focus");
    $("#view-tab").addClass("focus");
    $("#edit-product-tab").hide();
    $("#add-product-tab").hide();
    $("#product-tab").show();
  });
  
  $("#edit-product-cancel").click(function () {
    $("#edit-product-reset").click();
    $("#edit-product-tab").hide();
    $("#product-tab").show();
  })

  $("#prod-category-refresh").click(function () {
    $.ajax({
      type: "POST",
      url: "/Web_HomeAppliances/CategoryRetrieve",
      success: function (data) {
        var out = JSON.parse(data);
        var category = out.category;
        $("#option-category").empty();
        $("#option-category").append(
          `<option value="" disabled selected>Select Category</option>`
        );
        for (var i = 0; i < category.length; i++) {
          $("#option-category").append(
            `<option value="${category[i].id}">${category[i].name}</option>`
          );
        }
      },
    });
  });

  $(".delete-prod").click(function () {
    var id = $(this).attr("id");
    id = id.substring(12);
    var confirm = window.confirm(
      "Are you sure you want to delete this product?"
    );
    if (!confirm) {
      return;
    }

    $.ajax({
      type: "POST",
      url: "/Web_HomeAppliances/ProductDelete",
      data: { id: id },
      success: function (data) {
        var out = JSON.parse(data);
        if (out.success) {
          showSnackbar(
            "src/img/white/check-circle.svg",
            "Product deleted successfully",
            "Please refresh the page to see the changes."
          );
        } else {
          showSnackbar(
            "src/img/white/alert-circle.svg",
            "Delete product.",
            "Product delete failed."
          );
        }
      },
    });
  });

  $(".edit-prod").click(function () {
    var id = $(this).attr("id");
    id = id.substring(10);
    var tr = $(`#prod-${id}`);
    $("#product-tab").hide();
    $("#edit-product-tab").show();
    $("#alter-product-id").val(id);
    $("#alter-product-id").attr("placeholder", id);
    $("#edit-product-name").val(tr.find("#prodName").text());
    $("#edit-product-name").attr("placeholder", tr.find("#prodName").text());
    $("#edit-product-price").val(tr.find("#prodPrice").text().substring(3));
    $("#edit-product-price").attr("placeholder", tr.find("#prodPrice").text().substring(3));
    $("#edit-product-stock").val(tr.find("#prodStock").text());
    $("#edit-product-stock").attr("placeholder", tr.find("#prodStock").text());
    $("#edit-product-description").val(tr.find("#prodDesc").text());
    $("#edit-product-description").attr(
      "placeholder",
      tr.find("#prodDesc").text()
    );
    var subImages = tr.find("#prodSubImg").find("img");
    var subImagesPreview = $("#edit-images-preview");
    subImagesPreview.empty();
    for (var i = 0; i < subImages.length; i++) {
      subDpData.push(subImages[i].src);
      var img = document.createElement("img");
      img.src = subImages[i].src;
      img.style.width = "100px";
      img.style.height = "100px";
      subImagesPreview.append(img);
    }
    $("#edit-display-image-preview").empty();
    dpData = tr.find("#prodDisp").find("img").attr("src");
    var img = document.createElement("img");
    img.src = tr.find("#prodDisp").find("img").attr("src");
    img.style.width = "100px";
    img.style.height = "100px";
    $("#edit-display-image-preview").append(img);
  });

  $("#add-product-images").change(function () {
    // multiple images preview in browser
    var images = document.getElementById("add-product-images").files;
    if (images.length > 10) {
      alert("Please select a maximum of 10 images");
      return;
    }
    var imagesPreview = $("#images-preview");
    imagesPreview.empty();
    for (var i = 0; i < images.length; i++) {
      var img = document.createElement("img");
      img.src = URL.createObjectURL(images[i]);
      img.style.width = "100px";
      img.style.height = "100px";
      imagesPreview.append(img);
    }
  });

  $("#add-display-image").change(function () {
    // multiple images preview in browser
    var images = document.getElementById("add-display-image").files[0];

    var imagesPreview = $("#display-image-preview");
    imagesPreview.empty();
    var img = document.createElement("img");
    img.src = URL.createObjectURL(images);
    img.style.width = "100px";
    img.style.height = "100px";
    imagesPreview.append(img);
  });

  $("#edit-product-images").change(function () {
    // multiple images preview in browser
    var images = document.getElementById("edit-product-images").files;
    if (images.length > 10) {
      alert("Please select a maximum of 10 images");
      return;
    }
    var imagesPreview = $("#edit-images-preview");
    imagesPreview.empty();
    for (var i = 0; i < images.length; i++) {
      var img = document.createElement("img");
      img.src = URL.createObjectURL(images[i]);
      img.style.width = "100px";
      img.style.height = "100px";
      imagesPreview.append(img);
    }
  });

  $("#edit-display-image").change(function () {
    // multiple images preview in browser
    var images = document.getElementById("edit-display-image").files[0];

    var imagesPreview = $("#edit-display-image-preview");
    imagesPreview.empty();
    var img = document.createElement("img");
    img.src = URL.createObjectURL(images);
    img.style.width = "100px";
    img.style.height = "100px";
    imagesPreview.append(img);
  });

  $("#addProductForm").submit(function (e) {
    e.preventDefault();
    var formData = new FormData(this);
    var hasErr = false;
    //validate form
    if (formData.get("name") == "") {
      $("#product-invalid-name")
        .text("Please enter a name")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("price") < 0) {
      $("#product-invalid-price")
        .text("Please enter a valid price")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("stock") < 0) {
      $("#product-invalid-stock")
        .text("Please enter a valid stock")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("description") == "") {
      $("#product-invalid-description")
        .text("Please enter a description")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("category_id") == "") {
      $("#product-invalid-category")
        .text("Please select a category")
        .removeClass("hidden");
      hasErr = true;
    }

    if ($("#add-product-images")[0].files.length == 0) {
      $("#product-invalid-images")
        .text("Please select images")
        .removeClass("hidden");
      hasErr = true;
    }

    if ($("#add-display-image")[0].files.length == 0) {
      $("#product-invalid-display-image")
        .text("Please select a display image")
        .removeClass("hidden");
      hasErr = true;
    }

    if (hasErr) {
      return;
    }

    // Promisified FileReader function
    function readFileAsync(file) {
      return new Promise((resolve, reject) => {
        var reader = new FileReader();
        reader.onload = function (e) {
          resolve(e.target.result);
        };
        reader.onerror = reject;
        reader.readAsDataURL(file);
      });
    }

    var images = $("#add-product-images")[0].files;
    if (images.length > 10) {
      alert("Please select a maximum of 10 images");
      return;
    }

    // Array to store promises for all FileReader operations
    var fileReaderPromises = [];

    for (var i = 0; i < images.length; i++) {
      fileReaderPromises.push(readFileAsync(images[i]));
    }

    // Promise to handle display image FileReader
    var displayImagePromise = new Promise((resolve, reject) => {
      var image = $("#add-display-image")[0].files[0];
      var reader = new FileReader();
      reader.onload = function (e) {
        resolve(e.target.result);
      };
      reader.onerror = reject;
      reader.readAsDataURL(image);
    });
    var sendData = {
      name: formData.get("name"),
      price: formData.get("price"),
      stock: formData.get("stock"),
      sold: formData.get("sold"),
      description: formData.get("description"),
      category_id: formData.get("category_id"),
      sub_images: [],
      display_image: "",
    };

    // Promisified FileReader function
    function readFileAsync(file) {
      return new Promise((resolve, reject) => {
        var reader = new FileReader();
        reader.onload = function (e) {
          resolve(e.target.result);
        };
        reader.onerror = reject;
        reader.readAsDataURL(file);
      });
    }

    var images = $("#add-product-images")[0].files;
    if (images.length > 10) {
      alert("Please select a maximum of 10 images");
      return;
    }

    // Array to store promises for all FileReader operations
    var fileReaderPromises = [];

    for (var i = 0; i < images.length; i++) {
      fileReaderPromises.push(readFileAsync(images[i]));
    }

    // Promise to handle display image FileReader
    var displayImagePromise = new Promise((resolve, reject) => {
      var image = $("#add-display-image")[0].files[0];
      var reader = new FileReader();
      reader.onload = function (e) {
        resolve(e.target.result);
      };
      reader.onerror = reject;
      reader.readAsDataURL(image);
    });

    // Wait for all FileReader operations to complete
    Promise.all([...fileReaderPromises, displayImagePromise])
      .then((results) => {
        sendData.sub_images = results.slice(0, images.length); // Sub-images
        sendData.display_image = results[images.length]; // Display image

        // Now you can proceed to send the data
        var formData = new FormData();
        formData.append("name", sendData.name);
        formData.append("price", sendData.price);
        formData.append("stock", sendData.stock);
        formData.append("description", sendData.description);
        formData.append("category_id", sendData.category_id);
        formData.append("sub_images", JSON.stringify(sendData.sub_images));
        formData.append("display_image", sendData.display_image);

        console.log(sendData);

        $.ajax({
          type: "POST",
          url: "/Web_HomeAppliances/ProductAdd",
          data: formData,
          contentType: false,
          processData: false,
          success: function (data) {
            var out = JSON.parse(data);
            if (out.success) {
              showSnackbar(
                "src/img/white/check-circle.svg",
                "Product added successfully",
                "Please refresh the page to see the changes."
              );
              $("#add-product-reset").click();
            } else {
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Add product.",
                "Product add failed."
              );
            }
          },
        });
      })
      .catch((error) => {
        console.error("Error reading files:", error);
      });
  });
  //start
  $("#editProductForm").submit(function (e) {
    e.preventDefault();
    var formData = new FormData(this);
    var hasErr = false;
    //validate form
    if (formData.get("name") == "") {
      $("#edit-product-invalid-name")
        .text("Please enter a name")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("price") < 0) {
      $("#edit-product-invalid-price")
        .text("Please enter a valid price")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("stock") < 0) {
      $("#edit-product-invalid-stock")
        .text("Please enter a valid stock")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("description") == "") {
      $("#edit-product-invalid-description")
        .text("Please enter a description")
        .removeClass("hidden");
      hasErr = true;
    }

    if (formData.get("category_id") == "") {
      $("#edit-product-invalid-category")
        .text("Please select a category")
        .removeClass("hidden");
      hasErr = true;
    }

    if (hasErr) {
      return;
    }

    // Promisified FileReader function
    function readFileAsync(file) {
      return new Promise((resolve, reject) => {
        var reader = new FileReader();
        reader.onload = function (e) {
          resolve(e.target.result);
        };
        reader.onerror = reject;
        reader.readAsDataURL(file);
      });
    }

    var images = $("#edit-product-images")[0].files;
    if (images.length > 10) {
      alert("Please select a maximum of 10 images");
      return;
    }

    var sendData = {
      id: $("#alter-product-id").val(),
      name: formData.get("name"),
      price: formData.get("price"),
      stock: formData.get("stock"),
      sold: formData.get("sold"),
      description: formData.get("description"),
      category_id: formData.get("category_id"),
      sub_images: [],
      display_image: "",
    };

    // Array to store promises for all FileReader operations
    var fileReaderPromises = [];

    for (var i = 0; i < images.length; i++) {
      fileReaderPromises.push(readFileAsync(images[i]));
    }

    // Promise to handle display image FileReader
    var displayImagePromise = new Promise((resolve, reject) => {
      var image = $("#edit-display-image")[0].files[0];
      if (image == undefined) {
        resolve("");
        return;
      }
      var reader = new FileReader();
      reader.onload = function (e) {
        resolve(e.target.result);
      };
      reader.onerror = reject;
      reader.readAsDataURL(image);
    });

    // Wait for all FileReader operations to complete
    Promise.all([...fileReaderPromises, displayImagePromise])
      .then((results) => {
        sendData.sub_images = results.slice(0, images.length); // Sub-images
        sendData.display_image = results[images.length]; // Display image

        // Now you can proceed to send the data
        var formData = new FormData();
        formData.append("id", sendData.id);
        formData.append("name", sendData.name);
        formData.append("price", sendData.price);
        formData.append("stock", sendData.stock);
        formData.append("description", sendData.description);
        formData.append("category_id", sendData.category_id);
        formData.append("sub_images", JSON.stringify(sendData.sub_images));
        formData.append("display_image", sendData.display_image);
        formData.append("hasDisplayImage", sendData.display_image != "");
        formData.append("hasSubImages", sendData.sub_images.length > 0);
        
        $.ajax({
          type: "POST",
          url: "/Web_HomeAppliances/ProductUpdate",
          data: formData,
          contentType: false,
          processData: false,
          success: function (data) {
            var out = JSON.parse(data);
            if (out.success) {
              showSnackbar(
                "src/img/white/check-circle.svg",
                "Product updated successfully",
                "Please refresh the page to see the changes."
              );
              $("#edit-product-reset").click();
              $("#edit-product-tab").hide();
              $("#product-tab").show();
            } else {
              showSnackbar(
                "src/img/white/alert-circle.svg",
                "Edit product.",
                "Product edit failed."
              );
            }
          },
        });
      })
      .catch((error) => {
        console.error("Error reading files:", error);
      });
  });

  $("#add-product-reset").click(function () {
    $("#images-preview").empty();
    $("#display-image-preview").empty();
  });

  $("#edit-product-reset").click(function () {
    setTimeout(() => {
      $("#edit-images-preview").empty();
      $("#edit-display-image-preview").empty();
      for (var i = 0; i < subDpData.length; i++) {
        var img = document.createElement("img");
        img.src = subDpData[i];
        img.style.width = "100px";
        img.style.height = "100px";
        $("#edit-images-preview").append(img);
      }
      var img = document.createElement("img");
      img.src = dpData;
      img.style.width = "100px";
      img.style.height = "100px";
      $("#edit-display-image-preview").append(img);

      $("#edit-product-name").val($("#edit-product-name").attr("placeholder"));
      $("#edit-product-price").val(
        $("#edit-product-price").attr("placeholder")
      );
      $("#edit-product-stock").val(
        $("#edit-product-stock").attr("placeholder")
      );
      $("#edit-product-description").val(
        $("#edit-product-description").attr("placeholder")
      );
    }, 1);
  });
});
