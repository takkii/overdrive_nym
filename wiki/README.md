### pumaのデーモン化

Windows → 2025-12-19 10:43:47 +0900 [5340] ERROR: worker mode not supported on ruby on this platform

WSL2で実行した結果↓

```markdown
bundle exec puma -C config/puma.rb

ps aux | grep puma

kill PID番号
```

※ puma永続化、Dockerだとローカル環境との相違でJSONが拾えないため。