# README

## Usage
### Setup
```
$ bundle install
```

### Run Redis
```
$ redis-server
```

### Run Sidekiq
```
$ sidekiq
```

### Go to Rails Console
```
$ rails c
```

### Remove all table cache
```
2.7.1 :001 > AnalyzeJobService.remove
```

### Run analyze verbose
```
2.7.1 :001 > AnalyzeJobService.execute
```

### Check how many table has been analyzed
```
2.7.1 :001 > Rails.cache.redis.keys("table_*").count
```