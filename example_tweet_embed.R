<blockquote class="twitter-tweet" data-theme="dark" data-link-color="#19CF86"><p lang="en" dir="ltr">Sunsets don&#39;t get much better than this one over <a href="https://twitter.com/GrandTetonNPS?ref_src=twsrc%5Etfw">@GrandTetonNPS</a>. <a href="https://twitter.com/hashtag/nature?src=hash&amp;ref_src=twsrc%5Etfw">#nature</a> <a href="https://twitter.com/hashtag/sunset?src=hash&amp;ref_src=twsrc%5Etfw">#sunset</a> <a href="http://t.co/YuKy2rcjyU">pic.twitter.com/YuKy2rcjyU</a></p>&mdash; US Department of the Interior (@Interior) <a href="https://twitter.com/Interior/status/463440424141459456?ref_src=twsrc%5Etfw">May 5, 2014</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
  
  
  
  
  output$tweets <- renderUI({
    tags$blockquote(class="twitter-tweet", `data-theme`="dark",
                    `data-link-color`="#3b8540",
                    tags$a(href = "https://twitter.com/BenMcCready1/status/1161378012715200512"),
                    tags$script('twttr.widgets.load(document.getElementById("tweets"));'))
    
  })