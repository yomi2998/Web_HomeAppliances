$(document).ready(function () {
    $("#add-tab").click(function () {
        $("#view-tab").removeClass("focus");
        $("#add-tab").addClass("focus");
        $("#product-tab").hide();
        $("#add-product-tab").show();
    });

    $("#view-tab").click(function () {
        $("#add-tab").removeClass("focus");
        $("#view-tab").addClass("focus");
        $("#add-product-tab").hide();
        $("#product-tab").show();
    });

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
    
    $("#add-product-images").change(function () {
        // multiple images preview in browser
        var images = document.getElementById("add-product-images").files;
        if (images.length > 10) {
            alert("Please select a maximum of 10 images");
            return;
        }
        var imagesPreview = document.querySelector("#images-preview");
        imagesPreview.innerHTML = "";
        for (var i = 0; i < images.length; i++) {
            var img = document.createElement("img");
            img.src = URL.createObjectURL(images[i]);
            img.style.width = "100px";
            img.style.height = "100px";
            imagesPreview.appendChild(img);
        }
    });
});