<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top Up</title>
</head>
<style>
    header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #333;
        color: #fff;
        padding: 10px;
        top: 0;
    }
    header button {
        background-color: blue;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    header button:hover {
        background-color: skyblue;
    }
    header a {
        color: #fff;
        text-decoration: none;
    }
    body {
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
    }
    div {
        margin: 50px;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    h1 {
        text-align: center;
        margin-top: 50px;
    }
    .hidden {
        display: none;
    }
    table {
        border-collapse: collapse;
        width: 100%;
    }
    th, td {
        text-align: left;
        padding: 8px;
    }
    th {
        background-color: #333;
        color: #fff;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
</style>
<header>
    <h1>Top Up</h1>
    <button><a href="#">Payment History</a></button>
</header>
<body>
    <div id="top-up-amount">
        <h2>Top Up Amount</h2>
        <form>
            <label for="amount">Enter Amount:</label>
            <input type="number" id="amount" name="amount" required>
            <button type="submit">Top Up</button>
        </form>
    </div>    
    <div>
        <h2>Top Up Method</h2>
        <div>
            <label for="bank">Bank Transfer:</label>
            <input type="radio" id="bank" name="method" value="bank" onchange="togglePaymentMethod()">
        </div>
        <div>
            <label for="card">Credit/Debit Card:</label>
            <input type="radio" id="card" name="method" value="card" onchange="togglePaymentMethod()">
        </div>
        <div>
            <label for="paypal">PayPal:</label>
            <input type="radio" id="paypal" name="method" value="paypal" onchange="togglePaymentMethod()">
        </div>

        <div id="bank-account-section" class="hidden">
            <label for="bank-account">Bank Account:</label>
            <input type="text" id="bank-account" name="bank-account" required>
        </div>
        <div id="card-section" class="hidden">
            <label for="card-number">Card Number:</label>
            <input type="text" id="card-number" name="card-number" required>
            <label for="card-expiry">Card Expiry:</label>
            <input type="text" id="card-expiry" name="card-expiry" required>
            <label for="card-cvv">Card CVV:</label>
            <input type="text" id="card-cvv" name="card-cvv" required>
        </div>
        <div id="paypal-section" class="hidden">
            <label for="paypal-email">PayPal Email:</label>
            <input type="email" id="paypal-email" name="paypal-email" required>
        </div>
    </div>
    <div>
        <h2>Top Up History</h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
    <script>
        function togglePaymentMethod() {
            var bankSection = document.getElementById('bank-account-section');
            var cardSection = document.getElementById('card-section');
            var paypalSection = document.getElementById('paypal-section');
    
            var method = document.querySelector('input[name="method"]:checked').value;
    
            bankSection.style.display = method === 'bank' ? 'block' : 'none';
            cardSection.style.display = method === 'card' ? 'block' : 'none';
            paypalSection.style.display = method === 'paypal' ? 'block' : 'none';
        }
    
        function scrollToTopUpAmount() {
            const topUpAmountSection = document.querySelector('#top-up-amount');
            topUpAmountSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    
        const form = document.querySelector('form');
    
        form.addEventListener('submit', function(event) {
            event.preventDefault();
    
            const inputs = form.querySelectorAll('input[required], textarea[required], select[required]');
            let isValid = true;
    
            inputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.classList.add('error');
                } else {
                    input.classList.remove('error');
                }
            });
    
            if (!isValid) {
                alert('Please fill in all required fields.');
                scrollToTopUpAmount();
                return;
            }
            form.submit();
        });
    </script>
    
    
</body>
</html>    
