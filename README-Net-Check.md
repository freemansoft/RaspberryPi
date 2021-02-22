This document will eventually describe how to use your Pi an internet health monitor.

## Intention
The intention is to 
1. Capture the current health with the `speedtest` CLI.
1. Push the results into a data store
1. Publish the results on a web page or via API

## Example speedtest.net cli output
Raspberry Pi3 on 1GB port on 1GB FIOS internet service.

```
pi@pi-52863f1:~/Documents/RaspberryPi $ speedtest --format=human-readable

   Speedtest by Ookla

     Server: Windstream - Ashburn, VA (id = 17383)
        ISP: Verizon Fios
    Latency:     4.46 ms   (1.35 ms jitter)
   Download:    95.44 Mbps (data used: 61.2 MB)
     Upload:    93.90 Mbps (data used: 42.3 MB)
Packet Loss:     0.0%
 Result URL: https://www.speedtest.net/result/c/6e405b18-6135-4608-91a0-0da5e8e1cf58
```

## Scripts
| Script | Purpose |
| - | - |
| speedtest-cli-install.sh | downloads the Speedtest.net CLI |
| ?? | ?? | 