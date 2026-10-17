// V1.0

/* Alpine component: custom audio player controls (play/pause, skip, scrub, time display). */

// Guard against double registration if the script is included twice
if (!window.__audioPlayerLoaded) {
  window.__audioPlayerLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('playerData', () => ({
      playing: false,
      metaDataLoaded: false,
      // Use a stable unknown-duration placeholder instead of a hard-coded sample
      currentTime: '00:00/--:--',
      statusAnnouncement: '',
      progressBarWidth: null,
      resizeTimer: null,
      // Recomputes the progress bar width after window resizes settle, avoiding layout thrashing
      handleResize() {
        clearTimeout(this.resizeTimer);
        this.resizeTimer = setTimeout(() => {
          if (this.$refs.scrubber) {
            this.progressBarWidth = this.$refs.scrubber.clientWidth;
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
      // Jumps playback forward/backward by `t` seconds
      async skip(t = 0) {
        const player = this.$refs.player;
        if (!player) return;
        player.currentTime = player.currentTime + t;
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
      // Seeks playback based on click position along the scrubber bar
      scrub(e) {
        const player = this.$refs.player;
        const percentage = e.offsetX / this.$refs.scrubber.clientWidth;
        // If duration is unknown we cannot seek reliably — don't change playing state
        if (!isFinite(player.duration)) {
          return;
        }
        player.currentTime = percentage * player.duration;
        // Try to start playback and update the UI only if play actually starts
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
        const progress = this.$refs.progress;
        const display = (t) => {
          const minutes = Math.floor(t / 60);
          const seconds = Math.floor(t - minutes * 60);
          const minuteValue = minutes.toString().padStart(2, '0');
          const secondValue = seconds.toString().padStart(2, '0');
          return `${minuteValue}:${secondValue}`;
        };
        const current = isFinite(player.currentTime) ? display(player.currentTime) : '00:00';
        const duration = isFinite(player.duration) ? display(player.duration) : '--:--';
        this.currentTime = `${current}/${duration}`;
        let barLength = 0;
        if (isFinite(player.duration) && this.progressBarWidth) {
          barLength = this.progressBarWidth * (player.currentTime / player.duration || 0);
        }
        progress.style.width = `${barLength}px`;
        progress.style.opacity = 1;
      }
    }));
  });
}
