document.addEventListener('DOMContentLoaded', function() {
    const amountButtons = document.querySelectorAll('.amount-buttons button');
    const selectedAmountDisplay = document.getElementById('displayedAmount');
    const bankAccountSection = document.getElementById('bankAccountSection');
    const cardSection = document.getElementById('cardSection');
    const paypalSection = document.getElementById('paypalSection');

    amountButtons.forEach(button => {
        button.addEventListener('click', function() {
            const amount = this.value;
            selectedAmountDisplay.textContent = `RM ${amount}`;
        });
    });

    const methodButtons = document.querySelectorAll('.method-button');
    methodButtons.forEach(button => {
        button.addEventListener('click', function() {
            const selectedMethod = button.value;
            toggleSections(selectedMethod);
        });
    });

    function toggleSections(selectedMethod) {
        bankAccountSection.classList.toggle('hidden', selectedMethod !== 'bank');
        cardSection.classList.toggle('hidden', selectedMethod !== 'card');
        paypalSection.classList.toggle('hidden', selectedMethod !== 'paypal');
    }
});