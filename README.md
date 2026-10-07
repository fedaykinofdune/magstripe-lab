# 🧲 Magstripe Lab

A single self-contained HTML page that reads magnetic-stripe cards through an
audio-jack swipe reader (like the older non-encrypting Square dongles), decodes
the data, visualizes it, and gives you a pile of ways to play with it. Everything
runs locally in the browser — nothing is uploaded anywhere.

## Run it

1. Plug the reader into the mic port and select it in your sound control panel (done).
2. **Easiest:** just open `index.html` in Chrome/Firefox.
3. If the microphone is blocked (browsers only grant mic access on `https://` or
   `localhost`, not always on `file://`), run the tiny local server instead:

   ```
   ./serve.sh
   ```
   then open http://localhost:8000

Click **Start listening**, then swipe a card. No hardware handy? Click
**Generate a test swipe** — it synthesizes a real ISO-format stripe so every tool
works end-to-end.

## What's in it

Core:
1. **Capture** — live mic swipe (auto-detected), .wav upload, or synthesized test card.
2. **Audio-stream visualization** — waveform with detected flux transitions, the
   decoded-bit overlay, and an FFT spectrogram.
3. **Decoded data** — auto-detects Track 1 / Track 2, forward or reversed swipe;
   shows the raw bitstream (binary), per-character bits, hex, and ASCII, plus
   parity and LRC checksum status.
4. **Card anatomy & Luhn** — splits a Track-2 string into PAN / expiration /
   service code / discretionary data, guesses the issuer, and runs the Luhn check.

Experiments (labeled sections, for demos):
5. **F2F re-modulator** — re-encode the bits into the Aiken bi-phase waveform,
   play it, and round-trip decode it (modulate ↔ demodulate).
6. **Parity & LRC playground** — click bits to flip them and watch the error
   detection break.
7. **Bits → barcode** — paints the bit values and the physical flux pattern; save as PNG.
8. **Sonify the stripe** — plays the data as music (per-bit or per-character notes).
9. **DTMF dialer** — turns the card digits into telephone touch-tones and decodes
   them back (Goertzel).
10. **Text modem (AFSK)** — encode any text as two-tone modem sound and demodulate it back.
11. **Morse code** — beeps out the decoded text.

## Notes on the encoding

Magstripes use **Aiken bi-phase (F2F)** encoding: one flux reversal per bit clocks
a `0`; an extra reversal in the middle of a bit marks a `1`. Track 2 uses 5-bit
characters (4 data + odd parity) from a 16-char alphabet (`0-9 : ; < = > ?`), with
a `;` start sentinel, `?` end sentinel, and an LRC column-checksum. Track 1 uses
7-bit characters and a `%` start sentinel. Formats: ISO/IEC 7811 / 7813.

Only reads your own cards. Have fun.
