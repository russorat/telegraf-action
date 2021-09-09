if [ -z "$TELEGRAF_VERSION" ]; then
  echo 'You need to set telegraf_version. Exiting.'
  exit 1
else
  if [ "$TELEGRAF_VERSION" = "latest" ];
  then
      export TELEGRAF_VERSION=$(curl --silent "https://api.github.com/repos/influxdata/telegraf/releases" | jq -r '. | sort_by(.tag_name) | reverse[] | .tag_name | select(test("rc"; "i") | not)' | sed -e 's/v//g' | head -n 1)
      export TELEGRAF_DOWNLOAD_PATH="https://dl.influxdata.com/telegraf/releases"
  elif [ "$TELEGRAF_VERSION" = "nightly" ];
  then
      export TELEGRAF_DOWNLOAD_PATH="https://dl.influxdata.com/telegraf/nightlies"
  else
      export TELEGRAF_DOWNLOAD_PATH="https://dl.influxdata.com/telegraf/releases"
  fi
  cd /tmp
  wget -q $TELEGRAF_DOWNLOAD_PATH/telegraf-${TELEGRAF_VERSION}_linux_amd64.tar.gz
  tar xf telegraf-${TELEGRAF_VERSION}_linux_amd64.tar.gz
  TELEGRAF_DIR=$(find . -type d -name "telegraf-*" 2> /dev/null | head -n 1)
  sudo cp $TELEGRAF_DIR/usr/bin/telegraf /usr/local/bin/
  sudo cp -r $TELEGRAF_DIR/etc/* /usr/local/etc/
  rm -r $TELEGRAF_DIR
  cd -
fi