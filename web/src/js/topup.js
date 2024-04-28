$(document).ready(function() {
    const amountButtons = $('.amount-buttons button');
    const selectedAmountDisplay = $('#displayedAmount');
    const bankAccountSection = $('#bankAccountSection');
    const cardSection = $('#cardSection');
    const paypalSection = $('#paypalSection');

    amountButtons.on('click', function() {
        const amount = $(this).val();
        selectedAmountDisplay.text(`RM ${amount}`);
    });

    function toggleSections(selectedMethod) {
        bankAccountSection.toggleClass('hidden', selectedMethod !== 'bank');
        cardSection.toggleClass('hidden', selectedMethod !== 'card');
        paypalSection.toggleClass('hidden', selectedMethod !== 'paypal');
    }
});