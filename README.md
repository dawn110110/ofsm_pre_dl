# ofsm_pre_dl

modified [open factorio server manager](https://github.com/OpenFactorioServerManager/factorio-server-manager) which provides an option of using pre-download headless server tar.xz

## why this?

headless server downloading could be rather slow in China. and ofsm download it every time you start the container.

## crawler.sh

crawling from factorio.com for latest healess server tar, and download it to `./download` dir. run this every 3 hours by cron:

```
crontab -e

# input
0 */3 * * * /root/factorio-server/ofsm_pre_dl/crawler.sh >> /root/factorio-server/ofsm_pre_dl/cw.log 2>&1
# or you can rsync from other hosts.
```

## build and run the ofsm_pre_dl

```bash
# install axel and docker engine
apt install axel -y

# download healess server (for the first time), you should config cron later
sh /opt/crawler.sh

# build
sh build.sh

# run the ofsm
sh run_with_pre_dl.sh

# docker logs ofsm_pre_dl, you should see ..
PRE_DOWNLOAD_DIR=/opt/pre_download given. won't download, woooo!
Found latest file. [file_name=factorio_linux64_headless_1.1.34.tar.xz]
Extract done
...
```

