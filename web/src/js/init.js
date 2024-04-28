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

function extension_toggle(extension) {
  const topupExtension = $(`#${extension}`);
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
  $("#inoti").click(function () {
    if ($(".noti-dropdown .noti-dropdown-content").css("display") === "block") {
      $(".noti-dropdown .noti-dropdown-content").css("display", "none");
    } else {
      $(".noti-dropdown .noti-dropdown-content").css("display", "block");
      $(".cart-dropdown .cart-dropdown-content").css("display", "none");
      $(".profile-dropdown .profile-dropdown-content").css("display", "none");
    }
  });

  $("#icart").click(function () {
    if ($(".cart-dropdown .cart-dropdown-content").css("display") === "block") {
      $(".cart-dropdown .cart-dropdown-content").css("display", "none");
    } else {
      $(".cart-dropdown .cart-dropdown-content").css("display", "block");
      $(".noti-dropdown .noti-dropdown-content").css("display", "none");
      $(".profile-dropdown .profile-dropdown-content").css("display", "none");
    }
  });

  $("#iprofile").click(function () {
    if (
      $(".profile-dropdown .profile-dropdown-content").css("display") ===
      "block"
    ) {
      $(".profile-dropdown .profile-dropdown-content").css("display", "none");
    } else {
      $(".profile-dropdown .profile-dropdown-content").css("display", "block");
      $(".cart-dropdown .cart-dropdown-content").css("display", "none");
      $(".noti-dropdown .noti-dropdown-content").css("display", "none");
    }
  });

  $(document).click(function (event) {
    if (window.getSelection().toString().length > 0) {
      return;
    }
    var target = $(event.target);
    if (!target.closest(".noti-dropdown").length) {
      $(".noti-dropdown .noti-dropdown-content").css("display", "none");
    }
    if (!target.closest(".cart-dropdown").length) {
      $(".cart-dropdown .cart-dropdown-content").css("display", "none");
    }
    if (!target.closest(".profile-dropdown").length) {
      $(".profile-dropdown .profile-dropdown-content").css("display", "none");
    }
  });

  $(document).bind("scroll", function (e) {
    var nav = $(".navigation-bar");
    var nav2 = $("#navigation-container");
    if ($(window).scrollTop() === 0) {
      nav.css("width", "95%");
      nav.css("border-radius", "50px");
      nav.css("top", "10px");

      nav2.css("width", "95%");
      nav2.css("border-radius", "50px");
      nav2.css("top", "10px");
    } else {
      nav.css("width", "100%");
      nav.css("border-radius", "0");
      nav.css("top", "0");

      nav2.css("width", "100%");
      nav2.css("border-radius", "0");
      nav2.css("top", "0");
    }
  });
  $("a[href='#']").click(function (event) {
    event.preventDefault();
  });

  $(".login-form").submit(function (event) {
    event.preventDefault();
    var username = $("input[name='username']").val();
    var password = $("input[name='password']").val();
    $.ajax({
      url: "/Web_HomeAppliances/Login",
      type: "POST",
      data: {
        username: username,
        password: password,
      },
      success: function (data) {
        console.log(data);
        const out = JSON.parse(data);
        if (out.success) {
          window.location.reload();
        } else {
          $(".invalid-login").css("display", "block");
        }
      },
    });
  });

  $("#log-out").click(function (e) {
    e.preventDefault();
    var cookies = document.cookie.split(";");
    var session = cookies
      .find((cookie) => cookie.includes("session"))
      .split('="')[1];
    session = session.slice(0, -1);
    var sessionIndex = cookies.findIndex((cookie) =>
      cookie.includes(`session="${session}"`)
    );
    if (sessionIndex !== -1) {
      cookies.splice(sessionIndex, 1);
    }
    var id = cookies.find((cookie) => cookie.includes("id")).split("id=")[1];
    cookies.splice(
      cookies.findIndex((cookie) => cookie.includes(`id=${id}`)),
      1
    );
    var type = cookies
      .find((cookie) => cookie.includes("type"))
      .split("type=")[1];
    $.ajax({
      url: "/Web_HomeAppliances/Logout",
      type: "POST",
      data: {
        id: id,
        session: session,
        type: type,
      },
      success: function (data) {
        window.location.reload();
      },
    });
  });

  $(".nelson-nav-extension").click(function () {
    const extension = $(this).attr("id");
    extension_toggle(extension);
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
