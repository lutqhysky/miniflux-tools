# Miniflux ➜ Bark 推送脚本

定时检查 Miniflux 中标题包含“福利汇总”的文章，并通过 Bark 发送推送至 iPhone。

## ⚙️ 使用步骤

1. `git clone https://github.com/lutqhysky/miniflux-tools.git`
2. `cd miniflux-tools`
3. `cp .env.example .env` 并编辑 `.env` 填入真实参数
4. 安装依赖：`apt install jq`
5. 手动运行：`bash scripts/rss_push_bark.sh`
6. 添加定时任务：

   ```bash
   crontab -e
   */10 * * * * /path/to/miniflux-tools/scripts/rss_push_bark.sh >> /tmp/rss_push.log 2>&1
   ```
