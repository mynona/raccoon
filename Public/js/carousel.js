// V1.0

/* Alpine component: image carousel with touch gestures, keyboard navigation, and custom event trigger. */

// Guard against double registration if the script is included twice
if (!window.__carouselLoaded) {
    window.__carouselLoaded = true;

    document.addEventListener('alpine:init', () => {
        Alpine.data('carouselData', (slides = []) => ({
            slides: Array.isArray(slides) ? slides : [],
            currentSlideIndex: 1,
            touchStartX: null,
            touchEndX: null,
            swipeThreshold: 50,
            showCarousel: false,
            showIndicators: false,
            showNavigation: false,
            lastTrigger: null,

            previous() {
                if (this.currentSlideIndex > 1) {
                    this.currentSlideIndex = this.currentSlideIndex - 1;
                } else {
                    this.currentSlideIndex = this.slides.length;
                }
            },

            next() {
                if (this.currentSlideIndex < this.slides.length) {
                    this.currentSlideIndex = this.currentSlideIndex + 1;
                } else {
                    this.currentSlideIndex = 1;
                }
            },

            close() {
                if (!this.showCarousel) {
                    return;
                }
                this.showCarousel = false;
                const trigger = this.lastTrigger;
                this.lastTrigger = null;
                if (!trigger || !trigger.isConnected) {
                    return;
                }
                // wait for x-trap to release focus before restoring it
                this.$nextTick(() => trigger.focus());
            },

            init() {
                window.addEventListener('showCarousel', (event) => {
                    const id = event.detail;
                    const index = this.slides.findIndex(slide => slide.imgId === id);
                    // slide belongs to a different carousel instance
                    if (index === -1) {
                        return;
                    }
                    const trigger = document.activeElement;
                    this.lastTrigger =
                        trigger instanceof HTMLElement && trigger !== document.body ? trigger : null;
                    this.currentSlideIndex = index + 1;
                    this.showCarousel = true;

                    this.$nextTick(() => {
                        const closeCarouselButton = this.$refs.closeCarousel;
                        if (closeCarouselButton) {
                            closeCarouselButton.focus();
                        }
                    });
                });

                if (this.slides.length > 1) {
                    this.showIndicators = true;
                    this.showNavigation = true;
                }
            },

            handleTouchStart(event) {
                if (event.touches && event.touches[0]) {
                    this.touchStartX = event.touches[0].clientX;
                }
            },

            handleTouchMove(event) {
                if (event.touches && event.touches[0]) {
                    this.touchEndX = event.touches[0].clientX;
                }
            },

            handleTouchEnd() {
                if (this.touchEndX !== null && this.touchStartX !== null) {
                    if (this.touchStartX - this.touchEndX > this.swipeThreshold) {
                        this.next();
                    } else if (this.touchStartX - this.touchEndX < -this.swipeThreshold) {
                        this.previous();
                    }
                    this.touchStartX = null;
                    this.touchEndX = null;
                }
            }
        }));
    });
}
