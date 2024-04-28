function show_more() {
  const topupExtension = $("#category-extension");
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
