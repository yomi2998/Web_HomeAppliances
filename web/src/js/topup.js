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

function topup_toggle() {
    const topupExtension = $('#topup-extension');
    if (topupExtension.css('display') === 'none') {
        topupExtension.css('display', 'flex');
        topupExtension.css('opacity', '0');
        setTimeout(function() {
            topupExtension.css('opacity', '1');
        }, 1);
    } else {
        topupExtension.css('opacity', '0');
        setTimeout(function() {
            topupExtension.css('display', 'none');
        }, 1000);
    }
}
