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


### 참고

[![Travis Build Status](https://travis-ci.org/logstash-plugins/logstash-filter-java_filter_example.svg)](https://travis-ci.org/logstash-plugins/logstash-filter-java_filter_example)

This is a Java plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are free to use it however you want.

The documentation for Logstash Java plugins is available [here](https://www.elastic.co/guide/en/logstash/current/contributing-java-plugin.html).

