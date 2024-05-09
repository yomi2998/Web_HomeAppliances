<!DOCTYPE html>
<html>

    <head>
        <title>About us - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/about.css">

        <%
            //CONFIGURATION

            final boolean ALLOW_ADMIN = true;
            final boolean ALLOW_STAFF = true;
            final boolean ALLOW_CUSTOMER = true;
            final boolean ALLOW_GUEST = true;

            //END OF CONFIGURATION
        %>
    </head>

    <body>
        <div class="nelson-greeter">
            <p style="font-size: 10vw;">About us</p>
        </div>
        <%@ include file="navigation.jsp" %>
        <div class="container" style="display: none;">
            <div class="side">
            <img class="item-center" src="src/img/aboutus1.jpg" alt="Nelson Logo" class="logo" style="margin: 0 auto; display: block;">
            <div class="item-center">
                <h3>Welcome to Nelson</h3>
                <p>Your one-stop destination for all your home appliance needs.</p>
            </div>
            </div>
            <div class="side">
                <div class="item-center">
                    <h3>Located in the heart of the city</h3>
                    <p>Nelson is a premier home appliance shop committed to providing you with a wide range of top-quality products and exceptional customer service.</p>
                </div>
                <iframe class="item-center" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3983.5377912546624!2d101.72398217569263!3d3.2152605527411953!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc3843bfb6a031%3A0x2dc5e067aae3ab84!2sTunku%20Abdul%20Rahman%20University%20of%20Management%20and%20Technology%20(TAR%20UMT)!5e0!3m2!1sen!2smy!4v1715155313430!5m2!1sen!2smy" width="600" height="450" style="border:0; border-radius: 20px;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
            <div class="side">
            <img class="item-center" src="src/img/Happliance.jpeg" alt="Nelson Logo" class="logo" style="width: 500px ;margin: 0 auto; display: block;">
            <div class="item-center">
                <h3>Variety of Home Appliances</h3>
                <p>Whether you're looking for kitchen appliances, laundry machines, refrigerators, air conditioners, or any other home appliance, we have you covered.</p>
            </div>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>
