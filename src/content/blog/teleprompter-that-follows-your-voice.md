---
title: "I built a teleprompter that follows your voice"
description: "The story behind VoicePrompter: why fixed-speed teleprompters make you sound robotic, and what it took to make the script follow the speaker instead."
date: 2026-07-06
---

For about a year I recorded podcasts and webinars over video calls almost every week, and the same small thing ruined take after take: reading. I had outlines, I rehearsed, and the moment the call started I was either glancing at notes off-camera (and everyone could tell) or trying to keep pace with a teleprompter scrolling at a fixed speed, like a treadmill that doesn't care whether you're keeping up.

That second problem is the one that got under my skin. Every teleprompter I tried made *me* adapt to *it*. Nobody speaks at a constant rate - you slow down for the line that matters, speed up through the setup, stop when someone asks a question. A fixed-speed scroll punishes all of that.

So I built [VoicePrompter](https://voiceprompter.app): a teleprompter where the script follows the speaker, not the other way around.

## The part that turned out to be hard

Making text scroll when speech is detected is easy - that's just a volume threshold, and several apps market it as "voice-activated." Making the text follow your *words* is a different problem, and the interesting difficulty isn't the speech recognition itself (Apple's on-device engine is excellent). It's the matching.

Real speakers are messy. They ad-lib a sentence that isn't in the script, skip a paragraph, repeat a word three times, or jump back to redo a line. If you match the transcript against just the next few words of the script - which is the obvious implementation - any of those behaviors strands the prompter. It stops, you notice it stopped, and now you're thinking about the software instead of what you're saying.

The approach I landed on matches your speech against the *entire* script at every moment, with repeated-word disambiguation so "the the the" or a phrase your script uses five times doesn't teleport the scroll. A side effect I didn't originally plan: the prompter can scroll *backward*. Start re-reading a line from earlier and it finds you there. As far as I can tell from testing the market, that's still unique.

## The second feature nobody had

The other thing I needed for calls specifically: the script had to be invisible to everyone else. On the Mac that's possible at the OS level - a window can be excluded from screen capture entirely - so the [Mac app](https://voiceprompter.app/mac/) floats above Zoom or your slides where only you can see it. Your screen share and recordings never contain it.

On [iPhone and iPad](https://voiceprompter.app/ios/) the equivalent trick is a picture-in-picture window that floats over Instagram or TikTok while their camera records you - the camera sees you, not your screen, so the script never appears in the video.

## Where it is now

VoicePrompter is a few years of evenings and weekends later: native apps for Mac, iPhone, and iPad, a free web version, 60+ languages with on-device recognition, and over 1,000 app users as of mid-2026. The whole [changelog is public](https://voiceprompter.app/changelog.html), which I like as a discipline - shipping something every few weeks is easier to sustain when the record is visible.

If you speak on camera - videos, sales calls, courses, live streams - and you've ever felt the treadmill effect of a classic prompter, [try it](https://voiceprompter.app). The free tier is a real product, not a trial, and the difference is obvious within one take.
