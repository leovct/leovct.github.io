# 🌱 leovct.github.io

This is my personal blog. The website is simple, it references the articles I have written, a page about me and some links to my networks.

I use [`hugo`](https://gohugo.io/) because it's a powerful open-source static site generator and I combine it with the minimalist [`nodejh/hugo-theme-mini`](https://github.com/nodejh/hugo-theme-mini) theme. The website is hosted on Github Pages which makes it super easy to maintain (and it's free!).

## Usage

```sh
$ make
Usage:
  make <target>

Help
  help             Display this help.

Lint
  lint             Run markdownlint.

Start
  start            Start the website locally.
```

### Lint

```sh
$ make lint
markdownlint **/*.md --disable MD013
```

### Start

```sh
$ make start
hugo server
port 1313 already in use, attempting to use an available port
Start building sites … 
hugo v0.107.0+extended darwin/amd64 BuildDate=unknown

                   | EN  
-------------------+-----
  Pages            | 24  
  Paginator pages  |  0  
  Non-page files   |  1  
  Static files     |  4  
  Processed images |  0  
  Aliases          |  7  
  Sitemaps         |  1  
  Cleaned          |  0  

Built in 132 ms
Watching for changes in /Users/leovct/Documents/website/{content,static}
Watching for config changes in /Users/leovct/Documents/website/config.yaml, /Users/leovct/Documents/website/go.mod
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at http://localhost:57213/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```
