$(document).ready(function() {
    const form = $('#registrationForm');
    form.on('submit', function(event) {
        event.preventDefault();
        const checkbox = $('#term');
        if (!checkbox.prop('checked')) {
            alert('Please agree to the terms and conditions before registering.');
            return;
        }

        const inputs = form.find('input[required], textarea[required], select[required]');
        let isValid = true;

        inputs.each(function() {
            if (!$(this).val().trim()) {
                isValid = false;
                $(this).addClass('error');
            } else {
                $(this).removeClass('error');
            }
        });

        if (!isValid) {
            alert('Please fill in all required fields.');
            return;
        }

        $.ajax({
            url: '/Web_HomeAppliances/Register',
            type: 'POST',
            data: form.serialize(),
            success: function(data) {
                console.log(data);
                const out = JSON.parse(data);
                if (out.success) {
                    alert('Registration successful!');
                    window.location.href = '/Web_HomeAppliances/';
                } else {
                    alert('Registration failed. Please try again.');
                }
            },
        });
    });
    $(".cancel-btn").click()(function (e) {
        e.preventDefault();
        window.location.href = '/Web_HomeAppliances/';
    });
});