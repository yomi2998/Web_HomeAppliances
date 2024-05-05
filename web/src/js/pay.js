function toggleCardDetails(){
    var cardDetails = document.getElementById("card-details");
    var visaRadio = document.getElementById("visa-radio");
    if(visaRadio.checked){
        cardDetails.style.display = "block";
    } else{
        cardDetails.style.display = "none";
    }
}