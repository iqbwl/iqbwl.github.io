/**
 * Automatic Image Caption Support
 * Converts Markdown images with title attributes into figure elements with captions
 * 
 * Usage in Markdown:
 * ![Alt text](/path/to/image.jpg "Caption text")
 */

document.addEventListener('DOMContentLoaded', function () {
    // Find all images in prose content
    const images = document.querySelectorAll('.prose img');

    images.forEach(img => {
        // Skip if already in a figure element
        if (img.parentElement.tagName === 'FIGURE') return;

        // Get caption text from title or alt
        const captionText = img.title || img.alt;

        // If no caption text, skip
        if (!captionText) return;

        // Create figure element with styling
        const figure = document.createElement('figure');
        figure.className = 'flex flex-col items-center justify-center my-8';

        // Create figcaption
        const caption = document.createElement('figcaption');
        caption.className = 'text-center italic text-sm text-stone-500 dark:text-stone-400 mt-2';
        caption.textContent = captionText;

        // Replace img with figure structure
        img.parentNode.insertBefore(figure, img);
        figure.appendChild(img);
        figure.appendChild(caption);

        // Remove title attribute to prevent tooltip duplication
        if (img.title) img.removeAttribute('title');
    });
});
