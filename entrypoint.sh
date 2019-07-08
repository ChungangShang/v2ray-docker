#cd /v2raybin
#echo -e "$CONFIG_JSON" > config.json

cd /v2ray
wget -O v2ray.zip http://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
unzip v2ray.zip
if [ ! -f "v2ray" ]; then
  mv /v2ray/v2ray-v$VER-linux-64/v2ray .
  mv /v2ray/v2ray-v$VER-linux-64/v2ctl .
  mv /v2ray/v2ray-v$VER-linux-64/geoip.dat .
  mv /v2ray/v2ray-v$VER-linux-64/geosite.dat .
fi

cp -f /config.json .
chmod +x v2ray v2ctl
sed -i "s/your_uuid/$UUID/g" config.json
sed -i "s/your_alter_id/$ALTER_ID/g" config.json
sed -i "s/your_domain/$DOMAIN/g" config.json

if [ "$CERT_PEM" != "$KEY_PEM" ]; then
 echo -e "$CERT_PEM" > /v2ray/cert.pem
 echo -e "$KEY_PEM"  > /v2ray/key.pem
fi

./v2ray

ping 1.1.1.1