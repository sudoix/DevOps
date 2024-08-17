Create script to find and push metrics to push gateway

```bash
#!/bin/bash

LOG_FILE=/var/log/etcd.log

while true

do

NUMBER_OF_CONNECTIONS=`netstat -pentaul | grep ESTABLISHED | awk '{print $4) | grep 2379 | wc -1`

cat <<< EOF | curl --data-binary @- http://192.168.80.100:9091/metrics/job/etcd-connections/instance/192.168.10.100 number_of_established_connections_on_etcd $NUMBER_OF_CONNECTIONS
EOF

echo "Number of connections at `date +%Y-%m-%d-%H-%M-%S`: $NUMBER_OF_CONNECTIONS" >> $LOG_FILE

sleep 10
done

```

Create a systmed service to run the script

```bash
vim /etc/systemd/system/etcd-connections.service
```

```bash
[Unit]
Description=etcd-connections
After=network.target

[Service]
User=root
Group=root
Type=simple
ExecStart=/root/pushgateway/etcd-connections.sh

[Install]
WantedBy=multi-user.target
```

and start the service

```bash
systemctl daemon-reload
systemctl start etcd-connections
systemctl enable etcd-connections
```

add pushgateway to prometheus

```bash
vim /etc/prometheus/prometheus.yml

- job_name: "pushgateway"
  honor_labels: true
  scrape_interval: 10s
  static_configs:
    - targets: ["192.168.80.100:9091"]