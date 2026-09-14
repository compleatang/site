import { existsSync } from "node:fs";
import { readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDirectory = "dist";
const feeds = ["feed.xml", "posts/feed.xml", "archive/feed.xml"];

const extractContent = (html) => {
  const marker = '<div class="content">';
  const start = html.indexOf(marker);
  if (start < 0) throw new Error("Post content container not found");

  const tags = /<\/?div(?:\s[^>]*)?>/gi;
  tags.lastIndex = start;
  let depth = 0;
  let contentStart;
  let match = tags.exec(html);
  while (match) {
    if (match[0].startsWith("</")) {
      depth -= 1;
      if (depth === 0) return html.slice(contentStart, match.index).trim();
    } else {
      depth += 1;
      if (depth === 1) contentStart = tags.lastIndex;
    }

    match = tags.exec(html);
  }

  throw new Error("Post content container is not closed");
};

const toOutputPath = (url) => {
  const pathname = decodeURIComponent(new URL(url).pathname);
  return join(outputDirectory, `${pathname.replace(/^\//, "") || "index"}.html`);
};

const addFullContent = async (feedPath) => {
  if (!existsSync(feedPath)) return;

  let feed = await readFile(feedPath, "utf8");
  feed = feed.replace(
    '<rss version="2.0">',
    '<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/">',
  );

  feed = await replaceAsync(feed, /<item>([\s\S]*?)<\/item>/g, async (item) => {
    const link = item.match(/<link>(.*?)<\/link>/)?.[1];
    if (!link) throw new Error(`RSS item in ${feedPath} is missing a link`);

    const html = await readFile(toOutputPath(link), "utf8");
    const encoded = extractContent(html).replaceAll("]]>", "]]&gt;");
    return item.replace("</item>", `<content:encoded><![CDATA[${encoded}]]></content:encoded></item>`);
  });

  await writeFile(feedPath, feed);
};

async function replaceAsync(source, pattern, replace) {
  const matches = [...source.matchAll(pattern)];
  const replacements = await Promise.all(matches.map((match) => replace(match[0])));
  let offset = 0;

  for (let index = 0; index < matches.length; index += 1) {
    const match = matches[index];
    source = `${source.slice(0, match.index + offset)}${replacements[index]}${source.slice(match.index + offset + match[0].length)}`;
    offset += replacements[index].length - match[0].length;
  }

  return source;
}

for (const feed of feeds) {
  await addFullContent(join(outputDirectory, feed));
}
