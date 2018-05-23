# kdumpcalltime

A tiny Ruby script for summarising [`ktrace`][ktrace] files.

## Synopsis

```
kdumpcalltime [FILE]
```

## Example

```
-% ktrace -i find /tmp >/dev/null
-% kdumpcalltime
getdirentries: 0.11080s   376 calls | Avg=0.00029s Max=0.00254s Min=0.00002s StdDev=0.00055s
      fstatat: 0.00968s    78 calls | Avg=0.00012s Max=0.00029s Min=0.00005s StdDev=0.00008s
        write: 0.00489s   170 calls | Avg=0.00003s Max=0.00008s Min=0.00002s StdDev=0.00001s
         open: 0.00487s   161 calls | Avg=0.00003s Max=0.00006s Min=0.00002s StdDev=0.00001s
        fstat: 0.00415s   162 calls | Avg=0.00003s Max=0.00007s Min=0.00002s StdDev=0.00001s
       fchdir: 0.00209s   155 calls | Avg=0.00001s Max=0.00006s Min=0.00001s StdDev=0.00000s
        close: 0.00199s   162 calls | Avg=0.00001s Max=0.00002s Min=0.00001s StdDev=0.00000s
      fstatfs: 0.00110s    78 calls | Avg=0.00001s Max=0.00004s Min=0.00001s StdDev=0.00000s
       execve: 0.00052s     9 calls | Avg=0.00006s Max=0.00019s Min=0.00003s StdDev=0.00005s
      madvise: 0.00040s     8 calls | Avg=0.00005s Max=0.00011s Min=0.00001s StdDev=0.00004s
         mmap: 0.00031s    16 calls | Avg=0.00002s Max=0.00004s Min=0.00001s StdDev=0.00001s
        lstat: 0.00030s     6 calls | Avg=0.00005s Max=0.00006s Min=0.00004s StdDev=0.00001s
```



[ktrace]: https://en.wikipedia.org/wiki/Ktrace
