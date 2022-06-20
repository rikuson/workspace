# Contributing

## How to detect default command property

```bash
defaults read > before.json

# Change settings on GUI

defaults read > after.json
diff before.json after.json
# Recommend using colordiff
```
