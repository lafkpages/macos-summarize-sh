# macos-summarize-sh

A Bash utility for MacOS for summarising large texts using AppleScript.

## Usage

Once you've cloned the repository:

```sh
./summarize.sh demo_text.txt
```

If you want a longer summary, of let's say five sentences, do:

```sh
./summarize.sh -s 5 demo_text.txt
```

It can also be piped to:

```sh
cat demo_text.txt | ./summarize.sh
```
