# prerequisite

- copy .env from walklog to ./resources
- download japan_verXX.zipfrom  http://www.esrij.com/products/gis_data/japanshp/japanshp.html and extract files in ./volumes/walklog-tmp . 
- and...

```
alias k=kubectl
```

# create resources

```
cd resources; ./create_resources.sh
```

# run manifests

```
cd manifests
```

## walklog 

```
WALKLOG_DB_VER="v$(date +%Y%m%d%H%M)" envsubst < walklog/db.yaml | k apply -f -
k apply -f walklog/job-setup-areas.yaml
WALKLOG_WEB_VER="v$(date +%Y%m%d%H%M)" envsubst < walklog/web.yaml | k apply -f -
```

backup db periodically

```
k apply -f walklog/cronjob-backup-db.yaml
```

## redash

```
for f in redash/*.yaml; do k apply -f $f; done
```

## front

### let's encrypt certificate

issue


```
k apply -f front/job-lego-issue.yaml
```

renewal periodically

```
k apply -f front/cronjob-lego-renew.yaml
```
### nginx

```
NGINX_VER="v$(date +%Y%m%d%H%M)" envsubst < front/nginx.yaml | k apply -f -
```
