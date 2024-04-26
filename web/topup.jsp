<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="src/css/topup.css">
    <script src="src/js/topup.js"></script>
    <title>Top Up</title>
</head>
<body>
    <div class="container">
        <header>
            <h1>Top Up</h1>
        </header>
        <div class="balance" id="balance">Current Balance: $0</div>
        <form>
            <h2>Top Up Amount</h2>
            <div class="amount-buttons">
                <button type="button" value="10">$10</button>
                <button type="button" value="20">$20</button>
                <button type="button" value="50">$50</button>
                <button type="button" value="100">$100</button>
                <button type="button" value="200">$200</button>
                <button type="button" value="500">$500</button>
                <button type="button" value="1000">$1000</button>
                <button type="button" value="2000">$2000</button>
            </div>
            <div class="selected-amount">
                Selected Amount: <span id="displayedAmount">$0</span>
            </div>
            <h2>Top Up Method</h2>
            <div class="method-options">
                <button type="button" class="method-button" value="bank">Bank Transfer</button>
                <button type="button" class="method-button" value="card">Credit/Debit Card</button>
                <button type="button" class="method-button" value="paypal">PayPal</button>
            </div>
            <div id="bankAccountSection" class="form-group hidden">
                <label for="bankAccount">Bank Account:</label>
                <input type="text" id="bankAccount" name="bankAccount" required>
            </div>
            <div id="cardSection" class="form-group hidden">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" required>
                <label for="expiryDate">Expiry Date:</label>
                <input type="text" id="expiryDate" name="expiryDate" required>
            </div>
            <div id="paypalSection" class="form-group hidden">
                <label for="paypalEmail">PayPal Email:</label>
                <input type="email" id="paypalEmail" name="paypalEmail" required>
            </div>
            <button type="submit" class="top-up-button">Top Up</button>
        </form>
        <footer>
            &copy; 2024 Nelson Home Appliances. All rights reserved.
        </footer>
    </div>
</body>
</html>
