window.onload = function(){
    const totalClicks = document.querySelectorAll(".totalClicks");
    totalClicks.forEach(element => {
        element.innerText = "1";
    });
}

function totalClick(click){
    const sum = parseInt(event.target.parentNode.querySelector(".totalClicks").innerText) + click;
    if (click === 0) {
        event.target.parentNode.querySelector(".totalClicks").innerText = 1;
        return;
    }
    if (sum === 0) {
        const confirmed = window.confirm("Do you want to delete the item?");
        if (!confirmed) {
            event.target.parentNode.querySelector(".totalClicks").innerText = 1;
            return;
        }
    }
    if (sum < 0) {
        event.target.parentNode.querySelector(".totalClicks").innerText = 0;
        return;
    }
    event.target.parentNode.querySelector(".totalClicks").innerText = sum;
}

function clearCart() {
    var tableContainer = document.querySelector(".table-container");
    tableContainer.style.display = "none";
}