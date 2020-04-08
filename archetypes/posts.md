---

title: {{ replace .Name "-" " " | replaceRE "^\\d\\d\\d\\d \\d\\d \\d\\d (.*)$" "$1" | title }}
date: {{ .Date }}

draft: false
toc: false

summary: ""

cover: &image img/{{ now.Format "2006" }}/test.png
coverSpecs:
  photog: ""
  username: ""
images: 
- *image

tags: &tags
- untagged
keywords: *tags

---

[Neat]({{< ref "about.md" >}})

[Who]({{< relref "about.md#who" >}})

{{< img "test.png" >}}

{{< imgext "https://images.unsplash.com/photo-1558980395-be8a5fcb4251" >}}

{{< image src="/img/test.png" alt="Hello Friend" position="center" >}}

{{< instagram B-hKPUlBlJn >}}

{{< tweet 1247590104769724416 >}}

{{< youtube wnFqOfR5a7I >}}

{{< imagecredit >}}