# Telegraf Action

This action downloads and installs Telegraf that can be used in your automation.

This downloads the specified version (or `latest` or `nightly`), and adds the `telegraf` command to `/usr/local/bin`. A default configuration is also stored in `/usr/local/etc`.

# Usage

See [action.yml](action.yml)

### Install Telegraf
```yaml
steps:
  - name: Check out repo
    uses: actions/checkout@v2
  - name: Install Telegraf
    uses: influxdata/telegraf-action@v1
    with:
      telegraf_version: latest
```

### Use a specific version of Telegraf
```yaml
steps:
  - name: Check out repo
    uses: actions/checkout@v2
  - name: Install Telegraf
    uses: influxdata/telegraf-action@v1
    with:
      telegraf_version: 1.19.0
```