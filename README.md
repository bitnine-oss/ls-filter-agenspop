# Logstash Java Plugin

## summary

logstash 를 이용해 ES 에 vertex, edge 자료구조로 변환 적재할 수 있는 filter plugin

- input 을 csv, jdbc, kafka 등 자유롭게 선택 가능
- output 은 저장하고자 하는 es 와 index 지정

## build & deploy

- build : ./gradlew gem 
- deplay : ./logstash-filter-agenspop_filter-0.7.2.gem
- plugin install : bin/logstash-plugin install --no-verify --local /path/to/javaPlugin.gem
    --> 참고문서 https://www.elastic.co/guide/en/logstash/current/java-filter-plugin.html
- sample data : ./samples <== northwind, airroutes

## dependencies

- jruby-dist:^9.2.7.0
- gradle:^4.8
- groovy:^2.4.12
- jvm:1.8.0

## gradle.property 환경변수 및 logstash_core 다운로드 

filter plugin 은 logstash source 내용을 기반으로 build 되기 때문에 source 다운로드가 필요하다.

==> logstash [branch 7.2](https://github.com/elastic/logstash/tree/7.2) or logstash [release 7.2.1](https://github.com/elastic/logstash/releases/tag/v7.2.1)

this.project 의 root_path 에 gradle.properties 를 생성 (핵심은 LOGSTASH_CORE_PATH)

```bash
export OSS=true
export LOGSTASH_SOURCE=<downloaded_path>
echo "LOGSTASH_CORE_PATH=${LOGSTASH_SOURCE}/logstash-core" > gradle.properties
```

## deploy plugin 

* ref. [How to write a java filter plugin](https://www.elastic.co/guide/en/logstash/current/java-filter-plugin.html#_installing_the_java_plugin_in_logstash_3)

* 최초 등록시에는 시간이 꽤 걸린다. (약 5분?) 인내심을 가지세요.

```bash
cd $LS_HOME
bin/logstash-plugin install --no-verify --local ~/Workspaces/agens/logstash-filter-agenspop_filter-0.7.2.gem
```

<img src="">


### 참고

[![Travis Build Status](https://travis-ci.org/logstash-plugins/logstash-filter-java_filter_example.svg)](https://travis-ci.org/logstash-plugins/logstash-filter-java_filter_example)

This is a Java plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are free to use it however you want.

The documentation for Logstash Java plugins is available [here](https://www.elastic.co/guide/en/logstash/current/contributing-java-plugin.html).

