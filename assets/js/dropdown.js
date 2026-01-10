
document.addEventListener('DOMContentLoaded', () => {
    // Only activate on mobile/tablet widths or if we want click-toggle on desktop too
    // For now, let's apply the logic universally but check if it conflicts with hover
    // actually, the requirement said "dropdown pada tampilan mobile", but "click" is better for accessibility generally.
    // However, desktop usually expects hover. Let's make it work for click, which is safer for touch.

    const dropdowns = document.querySelectorAll('.dropdown');

    dropdowns.forEach(dropdown => {
        const toggle = dropdown.querySelector('.dropdown-toggle');

        if (toggle) {
            toggle.addEventListener('click', (e) => {
                e.preventDefault();

                // Close other dropdowns
                dropdowns.forEach(other => {
                    if (other !== dropdown) {
                        other.classList.remove('active');
                    }
                });

                // Toggle current
                dropdown.classList.toggle('active');
            });
        }
    });

    // Close when clicking outside
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.dropdown')) {
            dropdowns.forEach(dropdown => {
                dropdown.classList.remove('active');
            });
        }
    });
});
