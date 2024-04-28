$(document).ready(function() {
    const amountButtons = $('.amount-buttons button');
    const selectedAmountDisplay = $('#displayedAmount');

    amountButtons.on('click', function() {
        const amount = $(this).val();
        selectedAmountDisplay.text(`RM ${amount}`);
    });
});