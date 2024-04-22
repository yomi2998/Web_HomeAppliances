var toggles = {
  isearch: false,
  inoti: false,
  icart: false,
  iprofile: false,
  reset() {
    for (var key in this) {
      if (typeof this[key] === "boolean") {
        this[key] = false;
      }
    }
  },
  resetExcept(key) {
    for (var k in this) {
      if (k && k !== key && typeof this[k] === "boolean") {
        this[k] = false;
      }
    }
  },
};

function addCoverScreen() {
  let link = window.location.href;
  if (window.location.href[window.location.href.length - 1] === "#") {
    link = window.location.href.slice(0, -1);
  }
  var coverScreen = document.createElement("div");
  coverScreen.id = "coverScreen";
  coverScreen.style.position = "fixed";
  coverScreen.style.top = 0;
  coverScreen.style.left = 0;
  coverScreen.style.width = "100%";
  coverScreen.style.height = "100%";
  coverScreen.style.backgroundColor = "rgba(0,0,0,1)";
  coverScreen.style.zIndex = 1000;
  coverScreen.style.display = "flex";
  coverScreen.style.justifyContent = "center";
  coverScreen.style.alignItems = "center";
  coverScreen.style.fontSize = "3vw";
  coverScreen.style.color = "white";
  coverScreen.innerText = "Stuck in this page? ";
  var anchor = document.createElement("a");
  anchor.href = link;
  anchor.innerText = "[Reload]";
  anchor.style.color = "white";
  anchor.style.textDecoration = "underline";
  anchor.style.marginLeft = "0.5vw";
  coverScreen.appendChild(anchor);
  document.body.appendChild(coverScreen);
}

$(document).ready(function () {
  console.log("hello world!");
  $(".noti-dropdown").click(function () {
    if ($(".noti-dropdown .dropdown-content").css("display") === "block") {
      $(".noti-dropdown .dropdown-content").css("display", "none");
    } else {
      $(".noti-dropdown .dropdown-content").css("display", "block");
    }
  });

  $(".cart-dropdown").click(function () {
    if ($(".cart-dropdown .dropdown-content").css("display") === "block") {
      $(".cart-dropdown .dropdown-content").css("display", "none");
    } else {
      $(".cart-dropdown .dropdown-content").css("display", "block");
    }
  });

  $(".profile-dropdown").click(function () {
    if ($(".profile-dropdown .dropdown-content").css("display") === "block") {
      $(".profile-dropdown .dropdown-content").css("display", "none");
    } else {
      $(".profile-dropdown .dropdown-content").css("display", "block");
    }
  });

  $(document).click(function (event) {
    var target = $(event.target);
    if (!target.closest(".noti-dropdown").length) {
      $(".noti-dropdown .dropdown-content").css("display", "none");
    }
    if (!target.closest(".cart-dropdown").length) {
      $(".cart-dropdown .dropdown-content").css("display", "none");
    }
    if (!target.closest(".profile-dropdown").length) {
      $(".profile-dropdown .dropdown-content").css("display", "none");
    }
  });
});

// $(window).bind("popstate", function () {
//   document.body.style.animation = "fadeOut 0.25s";
//   document.body.style.opacity = 0;

//   setTimeout(function () {
//     addCoverScreen();
//     document.body.style.animation = "fadeIn 0.25s";
//     document.body.style.opacity = 1;
//   }, 100);
// });
