---
title: "A graph of my LinkedIn connections"
description: "A small browser tool that turns your LinkedIn connections export into an Obsidian-style force graph, grouped by company, role, or year."
date: 2026-05-10
---

I made a small tool that turns your LinkedIn connections into an Obsidian-style force graph - clusters of people grouped by company, role, or year, with you in the middle.

[**Try it →**](https://kosuvorov.github.io/linkedin-connections-graph/) · [Source on GitHub](https://github.com/kosuvorov/linkedin-connections-graph)

## How to use it

1. Export your connections from LinkedIn: Settings → Data Privacy → *Get a copy of your data* → tick *Connections* → wait for the email.
2. Open the [tool](https://kosuvorov.github.io/linkedin-connections-graph/), drop in the `Connections.csv`.
3. That's it. Everything runs in your browser - nothing is uploaded.

You can switch the **Group by** dropdown to slice your network differently - by company, by extracted role keyword (Engineer / Founder / Sales / ...), by year you connected, or by month/year. Hover for details. Click a person to open their profile.

## Why

I came across [Thanh-To's linkedin-network-visualization](https://github.com/Thanh-To/linkedin-network-visualization) - really cool idea, but it didn't quite work with my real export and I wanted a few more grouping options. So I built one that does.

It's just very interesting to see your network like this. The bubbles tell you a lot at a glance - which companies dominate your graph, where your year-by-year trajectory was densest, who's an orphan and who's part of a tribe.
