// V2.0

/* Alpine component: custom audio player controls (play/pause, skip, pointer-drag scrub, floating tooltip, time display). */

// Guard against double registration if the script is included twice
if (!window.__audioPlayerLoaded) {
  window.__audioPlayerLoaded = true;

  function registerPlayerData() {
    if (typeof Alpine === 'undefined') return;

    Alpine.data('playerData', () => ({
      playing: false,
      metaDataLoaded: false,
      // Use a stable unknown-duration placeholder instead of a hard-coded sample
      currentTime: '00:00/--:--',
      statusAnnouncement: '',
      progressPercent: 0,
      hoverPercent: 0,
      previewTimeFormatted: '00:00',
      showThumb: false,
      isHovered: false,
      isFocused: false,
      isDragging: false,
      progressBarWidth: null,
      resizeTimer: null,

      // Formats seconds into MM:SS string
      formatTime(t) {
        if (!isFinite(t) || t < 0) return '00:00';
        const minutes = Math.floor(t / 60);
        const seconds = Math.floor(t - minutes * 60);
        const minuteValue = minutes.toString().padStart(2, '0');
        const secondValue = seconds.toString().padStart(2, '0');
        return `${minuteValue}:${secondValue}`;
      },

      // Recomputes the progress bar width after window resizes settle, avoiding layout thrashing
      handleResize() {
        clearTimeout(this.resizeTimer);
        this.resizeTimer = setTimeout(() => {
          if (this.$refs.scrubber) {
            this.progressBarWidth = this.$refs.scrubber.clientWidth;
          }
          const progress = this.$refs.progress;
          if (progress) {
            progress.style.width = `${this.progressPercent}%`;
          }
        }, 150);
      },

      // Formats current/duration as a natural-language phrase for screen readers (e.g. "1 minute 23 seconds of 4 minutes 56 seconds")
      spokenTime() {
        const player = this.$refs.player;
        if (!player) return '';
        const format = (t) => {
          if (!isFinite(t)) return 'unknown';
          const minutes = Math.floor(t / 60);
          const seconds = Math.floor(t - minutes * 60);
          const minuteText = minutes === 1 ? '1 minute' : `${minutes} minutes`;
          const secondText = seconds === 1 ? '1 second' : `${seconds} seconds`;
          return minutes === 0 ? secondText : `${minuteText} ${secondText}`;
        };
        return `${format(player.currentTime)} of ${format(player.duration)}`;
      },

      // Computes 0..1 ratio along the scrubber from clientX
      getRatioFromEvent(e) {
        const scrubber = this.$refs.scrubber;
        if (!scrubber) return 0;
        const rect = scrubber.getBoundingClientRect();
        if (rect.width <= 0) return 0;
        return Math.min(Math.max((e.clientX - rect.left) / rect.width, 0), 1);
      },

      // Jumps playback forward/backward by `t` seconds
      async skip(t = 0) {
        const player = this.$refs.player;
        if (!player) return;
        player.currentTime = player.currentTime + t;
        this.showThumb = player.currentTime >= 1;
        this.setTime();
        try {
          const playPromise = player.play();
          if (playPromise && typeof playPromise.then === 'function') {
            await playPromise;
          }
          this.playing = true;
          this.statusAnnouncement = `Skipped ${t > 0 ? t : Math.abs(t)} seconds. Now playing.`;
        } catch (err) {
          console.warn('[audioPlayer] Playback was prevented or aborted:', err);
          this.playing = false;
        }
      },

      // Seeks directly to a specific target second
      seek(targetSeconds = 0) {
        const player = this.$refs.player;
        if (!player || !isFinite(player.duration)) return;
        player.currentTime = Math.min(Math.max(targetSeconds, 0), player.duration);
        this.showThumb = player.currentTime >= 1;
        this.setTime();
      },

      // Toggles play/pause state
      async toggle(e) {
        const player = this.$refs.player;
        if (!player) return;
        if (this.playing) {
          player.pause();
          this.playing = false;
          this.statusAnnouncement = 'Audio paused';
        } else {
          try {
            const playPromise = player.play();
            if (playPromise && typeof playPromise.then === 'function') {
              await playPromise;
            }
            this.playing = true;
            this.statusAnnouncement = 'Audio playing';
          } catch (err) {
            console.warn('[audioPlayer] Playback was prevented or aborted:', err);
            this.playing = false;
          }
        }
      },

      // Pointer down: initiates drag scrubbing with pointer capture
      startDrag(e) {
        const player = this.$refs.player;
        if (!player || !isFinite(player.duration)) return;
        this.isDragging = true;
        this.isHovered = true;
        if (e.target && e.target.setPointerCapture) {
          try { e.target.setPointerCapture(e.pointerId); } catch (err) {}
        }
        const ratio = this.getRatioFromEvent(e);
        this.progressPercent = ratio * 100;
        this.hoverPercent = this.progressPercent;
        const targetTime = ratio * player.duration;
        this.showThumb = targetTime >= 1;
        this.previewTimeFormatted = this.formatTime(targetTime);
        player.currentTime = targetTime;
        const progress = this.$refs.progress;
        if (progress) progress.style.width = `${this.progressPercent}%`;
      },

      // Pointer move: updates hover preview time or active scrub position
      onDrag(e) {
        const player = this.$refs.player;
        if (!player || !isFinite(player.duration)) return;
        const ratio = this.getRatioFromEvent(e);
        this.hoverPercent = ratio * 100;
        const targetTime = ratio * player.duration;
        this.previewTimeFormatted = this.formatTime(targetTime);

        if (this.isDragging) {
          this.progressPercent = this.hoverPercent;
          this.showThumb = targetTime >= 1;
          player.currentTime = targetTime;
          const progress = this.$refs.progress;
          if (progress) progress.style.width = `${this.progressPercent}%`;
        }
      },

      // Pointer up/cancel: releases pointer capture and completes seek
      endDrag(e) {
        if (!this.isDragging) return;
        const player = this.$refs.player;
        if (e.target && e.target.releasePointerCapture) {
          try { e.target.releasePointerCapture(e.pointerId); } catch (err) {}
        }
        const ratio = this.getRatioFromEvent(e);
        this.isDragging = false;
        if (player && isFinite(player.duration)) {
          player.currentTime = ratio * player.duration;
          this.progressPercent = ratio * 100;
          this.showThumb = player.currentTime >= 1;
          const progress = this.$refs.progress;
          if (progress) progress.style.width = `${this.progressPercent}%`;
          if (player.paused) {
            player.play().then(() => { this.playing = true; }).catch(() => { this.playing = false; });
          }
        }
      },

      // Fallback click seek
      scrub(e) {
        const player = this.$refs.player;
        if (!player || !isFinite(player.duration)) return;
        const ratio = this.getRatioFromEvent(e);
        player.currentTime = ratio * player.duration;
        this.progressPercent = ratio * 100;
        this.showThumb = player.currentTime >= 1;
        const progress = this.$refs.progress;
        if (progress) {
          progress.style.width = `${this.progressPercent}%`;
          progress.style.opacity = '1';
        }
        if (player.paused) {
          const playPromise = player.play();
          if (playPromise && typeof playPromise.then === 'function') {
            playPromise.then(() => { this.playing = true; }).catch(() => { this.playing = false; });
          } else {
            this.playing = true;
          }
        } else {
          this.playing = true;
        }
      },

      // Updates the time label and progress bar width to match current playback
      setTime(skip = 0) {
        const player = this.$refs.player;
        if (!player) return;
        const current = this.formatTime(player.currentTime);
        const duration = isFinite(player.duration) ? this.formatTime(player.duration) : '--:--';
        this.currentTime = `${current}/${duration}`;

        if (isFinite(player.duration) && player.duration > 0) {
          if (!this.isDragging) {
            const ratio = Math.min(Math.max(player.currentTime / player.duration, 0), 1);
            this.progressPercent = ratio * 100;
            if (!this.isHovered) {
              this.previewTimeFormatted = current;
              this.hoverPercent = this.progressPercent;
            }
          }
          this.showThumb = player.currentTime >= 1;
        } else {
          this.progressPercent = 0;
          this.showThumb = false;
        }

        const progress = this.$refs.progress;
        if (progress) {
          progress.style.width = `${this.progressPercent}%`;
          progress.style.opacity = '1';
        }
      }
    }));
  }

  if (window.Alpine) {
    registerPlayerData();
  } else {
    document.addEventListener('alpine:init', registerPlayerData);
  }
}
