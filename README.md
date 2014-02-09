# fluent-plugin-dummydata-producer 

This is a plugin for [Fluentd](http://fluentd.org)

## DummyDataProducerInput

Fluentd plugin to produce/generate dummy data and emits these data into Fluentd.

## Configuration

Configuration to emit dummy data with 3 variation:

    <source>
      type dummydata_producer
      tag  dummy.data
      rate 500        # messages per second
      dummydata0   {"type":"sample","code":50,"format":"json string allowed"}
      dummydata1   {"message":"other format needed?"}
      dummydata2   {"comment":"N of dummydataN is number and not limited"}
    </source>

With this configuration, this plugin emits about 500 messages in 1 second (0 -> 1 -> 2 -> 0 -> ...).

If you need message id for acknowledgement tests, incremental id feature available.

    <source>
      type dummydata_producer
      tag  dummy.data
      rate 500        # messages per second
      
      dummydata0   {"type":"sample","code":50,"format":"json string allowed"}
      dummydata1   {"message":"other format needed?"}
      dummydata2   {"comment":"N of dummydataN is number and not limited"}
      
      auto_increment_key id
    </source>

## TODO

* patches welcome!

## Copyright

* Copyright
  * Copyright (c) 2013- TAGOMORI Satoshi (tagomoris)
* License
  * Apache License, Version 2.0
