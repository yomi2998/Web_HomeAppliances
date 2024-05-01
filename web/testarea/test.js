$(document).ready(function () {
    $("#myform").submit(function (event) {
        event.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            type: "POST",
            url: "/Web_HomeAppliances/TestUpload",
            data: formData, // Pass the FormData object directly
            processData: false, // Add this line to prevent jQuery from processing the data
            contentType: false, // Add this line to prevent jQuery from setting the content type
            success: function (data) {
                const out = JSON.parse(data);
                if (out.success) {
                    console.log("Upload successful");
                } else {
                    console.log("Upload failed");
                }
            },
        });
    });
});