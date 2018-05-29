# kdumpcalltime

A tiny Ruby script for summarising system call times in [`ktrace`][ktrace] files.

Tested on FreeBSD, hopefully works on other systems with ktrace.  Please open an
issue (or ideally a pull request) if it does not.


## Synopsis

```
kdumpcalltime [FILE]
```

`FILE` defaults to ktrace.out, matching `ktrace` and `kdump`.


## Example

```
-% ktrace -i /bin/sh -c "ps ax | wc -l"
     199
-% kdumpcalltime
        wait4: 0.03042s     2 calls | Avg=0.01521s Max=0.02967s Min=0.00075s StdDev=0.01446s
         read: 0.02237s    18 calls | Avg=0.00124s Max=0.02019s Min=0.00003s StdDev=0.00460s
     __sysctl: 0.01115s   297 calls | Avg=0.00004s Max=0.00157s Min=0.00002s StdDev=0.00010s
         mmap: 0.00235s    83 calls | Avg=0.00003s Max=0.00025s Min=0.00001s StdDev=0.00003s
        fstat: 0.00152s    33 calls | Avg=0.00005s Max=0.00009s Min=0.00002s StdDev=0.00002s
        lstat: 0.00128s    18 calls | Avg=0.00007s Max=0.00014s Min=0.00004s StdDev=0.00003s
        close: 0.00119s    39 calls | Avg=0.00003s Max=0.00015s Min=0.00001s StdDev=0.00003s
  sigprocmask: 0.00101s    66 calls | Avg=0.00002s Max=0.00006s Min=0.00001s StdDev=0.00001s
       execve: 0.00089s     3 calls | Avg=0.00030s Max=0.00038s Min=0.00016s StdDev=0.00010s
       openat: 0.00084s    21 calls | Avg=0.00004s Max=0.00011s Min=0.00002s StdDev=0.00002s
       access: 0.00084s    13 calls | Avg=0.00006s Max=0.00012s Min=0.00003s StdDev=0.00003s
         stat: 0.00082s    18 calls | Avg=0.00005s Max=0.00014s Min=0.00003s StdDev=0.00003s
       munmap: 0.00076s    31 calls | Avg=0.00002s Max=0.00008s Min=0.00001s StdDev=0.00002s
         open: 0.00060s    14 calls | Avg=0.00004s Max=0.00007s Min=0.00003s StdDev=0.00001s
         fork: 0.00031s     2 calls | Avg=0.00015s Max=0.00019s Min=0.00012s StdDev=0.00003s
        write: 0.00027s     5 calls | Avg=0.00005s Max=0.00008s Min=0.00003s StdDev=0.00002s
getdirentries: 0.00017s     6 calls | Avg=0.00003s Max=0.00004s Min=0.00002s StdDev=0.00001s
```

[ktrace]: https://en.wikipedia.org/wiki/Ktrace
