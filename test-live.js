const ids = ['07Xnj7q2c9Y', 'kghLPeFlYIA', '6rFrufpU6ug'];
(async () => {
  for (const id of ids) {
    const res = await fetch(`https://www.youtube.com/watch?v=${id}`, { headers: { cookie: 'SOCS=CAI' } });
    const html = await res.text();
    const isLive = html.includes('isLiveBroadcast') || html.includes('isLiveNow');
    const isShort = html.includes('"isShorts":true') || html.includes('isShorts');
    console.log(id, 'isLive:', isLive, 'isShort:', isShort);
  }
})();
