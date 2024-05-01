$(document).ready(function () {
    $.ajax({
        type: "GET",
        url: "/Web_HomeAppliances/TestDownload",
        success: function (data) {
            const out = JSON.parse(data);
            if (out.success) {
                console.log("Download successful");
                const imgData = out.file;
                const imgElement = document.createElement('img');
                imgElement.src = 'data:image/png;base64,' + imgData;
                document.body.appendChild(imgElement);
            } else {
                console.log("Download failed");
            }
        },
    });
});