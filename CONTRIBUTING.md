# Contributing

## How to detect default command property

```bash
defaults read > before.js

# Change settings on GUI

defaults read > after.js
diff before.js after.js
# Recommend using colordiff
```
