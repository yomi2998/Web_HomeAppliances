$(document).ready(function() {
    const form = $('#registrationForm');
    form.on('submit', function(event) {
        event.preventDefault();

        // Validate the form
        if (form[0].checkValidity()) {
            // Perform additional validation for username
            const username = $('#username').val();
            if (username.trim() === '') {
                // Handle empty username
                $('#invalid-username').text('Username is required.').removeClass('hidden');
            } else {
                // Perform AJAX request to check if username is available
                $.ajax({
                    url: '/Web_HomeAppliances/CheckUsername',
                    type: 'POST',
                    data: { username: username },
                    success: function(data) {
                        const response = JSON.parse(data);
                        if (response.available) {
                            // Username is available
                            $('#invalid-username').addClass('hidden');
                            // Continue with form submission
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
                        } else {
                            // Username is already taken
                            $('#invalid-username').text('Username is already taken.').removeClass('hidden');
                        }
                    },
                });
            }
        } else {
            // Handle form validation errors
            form[0].reportValidity();
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
});

function register_toggle() {
    const topupExtension = $('#register-extension');
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