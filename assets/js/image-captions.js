/**
 * Automatic Image Caption Support
 * Converts Markdown images with title attributes into figure elements with captions
 * 
 * Usage in Markdown:
 * ![Alt text](/path/to/image.jpg "Caption text")
 */

document.addEventListener('DOMContentLoaded', function () {
    // Find all images in post content with title attribute
    const images = document.querySelectorAll('.post-content img[title]');

    images.forEach(img => {
        // Skip if already in a figure element
        if (img.parentElement.tagName === 'FIGURE') return;

        // Create figure element with existing styling class
        const figure = document.createElement('figure');
        figure.className = 'md-figure';

        // Create figcaption from title attribute
        const caption = document.createElement('figcaption');
        caption.textContent = img.title;

        // Replace img with figure structure
        img.parentNode.insertBefore(figure, img);
        figure.appendChild(img);
        figure.appendChild(caption);

        // Remove title attribute (already in caption)
        img.removeAttribute('title');
    });
});
