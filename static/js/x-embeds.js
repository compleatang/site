(() => {
  const embeds = [...document.querySelectorAll("[data-x-post]")];
  if (!embeds.length) return;

  const showFallback = (embed) => {
    const link = document.createElement("a");
    // biome-ignore lint/style/useTemplate: Seité's minifier corrupts URL template literals.
    link.href = "https://x.com/i/web/status/" + embed.dataset.xPost;
    link.textContent = "View this post on X";
    embed.replaceChildren(link);
  };

  const renderEmbeds = (twttr) => {
    for (const embed of embeds) {
      const postId = embed.dataset.xPost;
      const width = Math.floor(embed.getBoundingClientRect().width);

      embed.replaceChildren();
      twttr.widgets.createTweet(postId, embed, { dnt: true, theme: "dark", width }).catch(() => {
        showFallback(embed);
      });
    }
  };

  let twttr = window.twttr;
  if (!twttr) {
    twttr = {};
    window.twttr = twttr;
  }

  if (twttr.widgets) {
    renderEmbeds(twttr);
    return;
  }

  twttr._e = twttr._e || [];
  twttr.ready = twttr.ready || ((callback) => twttr._e.push(callback));
  twttr.ready(renderEmbeds);

  if (document.getElementById("twitter-wjs")) return;

  const script = document.createElement("script");
  script.id = "twitter-wjs";
  script.src = "https://platform.twitter.com/widgets.js";
  script.async = true;
  document.head.append(script);
})();
