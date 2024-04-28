$(document).ready(function() {
    const form = $('#registrationForm');
    form.on('submit', function(event) {
        event.preventDefault();
        var formData = form.serializeArray();
        console.log(formData);

        formData.forEach(function(item) {
            switch(item.name) {
                case username:
                    case 'username':
                        var alphanumericRegex = /^[a-zA-Z0-9]+$/;
                        if (!alphanumericRegex.test(item.value)) {
                            $('#invalid-username').text("Username must alphanumeric.").removeClass('hidden');
                            return;
                        } else if (item.value.length < 3) {
                            $('#invalid-username').text("Username must be 3 or more characters.").removeClass('hidden');
                            return;
                        }
                        
                        break;
                    break;
            }
        });
        return;

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

function remove_reg_error() {
    $('#invalid-username').addClass('hidden');
    $('#invalid-email').addClass('hidden');
    $('#invalid-password').addClass('hidden');
    $('#invalid-password-confirm').addClass('hidden');
    $('#invalid-birth').addClass('hidden');
}