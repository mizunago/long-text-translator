# Setup

## Configure .env file

1. Register and obtain an access key at the [following site](https://www.deepl.com/ja/docs-api).
A credit card is required, but it is free!
2. Write the access key in the dot-env file.
This must be kept secret to prevent others from using it.


Example:

```
DEEPL_AUTH_KEY="XXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX:fx"
DEEPL_PRO=True
# OR
# DEEPL_PRO=False
```

## How to use

1. `bundle`
2. Prepare a long text in English in `eng.txt`.
3. `bundle exec ruby auto_translator.rb`
4. If you set it up well, `jpn.txt` will be output
