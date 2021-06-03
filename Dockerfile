# 基于 ofsm/ofsm 标准镜像修改 entrypoint，提供以下功能：
#
# 允许使用 PRE_DOWNLOAD_DIR 环境变量，配配合 -v 把外部提前下载好的 headless server 映射进到镜像内
# 避免 ofsm 默认每次启动都慢成狗的下载速度
#
# 可以 cron 例行调度 crawler.sh 脚本，实现抓取最新版本并下载到本地.
FROM ofsm/ofsm:latest
RUN apt update
RUN apt install tzdata -y
COPY ./entrypoint.sh /opt/entrypoint_pre_dl.sh
RUN ["chmod", "655", "/opt/entrypoint_pre_dl.sh"]
ENTRYPOINT ["/opt/entrypoint_pre_dl.sh"]
