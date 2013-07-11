# -*- coding: utf-8 -*-

require 'fluent/mixin/config_placeholders'

module Fluent
  class DummyDataProducerInput < Input
    Fluent::Plugin.register_input('dummydata_producer', self)

    include Fluent::Mixin::ConfigPlaceholders

    config_param :tag, :string
    config_param :rate, :integer

    config_param :auto_increment_key, :string, :default => nil
    # X: number
    # dummydataX {"field1":"data1","field2":"data2"}

    attr_reader :dummydata

    def configure(conf)
      super

      @increment_value = 0

      @dummydata = []
      re = /^dummydata(\d+)$/
      conf.keys.select{|key| key =~ re}.sort{|a,b| re.match(a)[1].to_i <=> re.match(b)[1].to_i}.each do |key|
        @dummydata.push(JSON.parse(conf[key]))
      end

      if @dummydata.size < 1
        raise Fluent::ConfigError, "no one dummydata exists"
      end
      @dummydata_index = 0
    end

    def start
      super
      @running = true
      @producer = Thread.new(&method(:run))
    end

    def shutdown
      @running = false
      @producer.join
    end

    def generate
      d = @dummydata[@dummydata_index]
      unless d
        @dummydata_index = 0
        d = @dummydata[0]
      end
      @dummydata_index += 1
      d = d.dup
      if @auto_increment_key
        d[@auto_increment_key] = @increment_value
        @increment_value += 1
      end
      d
    end

    def run
      batch_num = (@rate / 9).to_i + 1
      while @running
        current_time = Fluent::Engine.now
        rate_count = 0

        while @running && rate_count < @rate && Fluent::Engine.now == current_time
          batch_num.times do
            Fluent::Engine.emit(@tag, Fluent::Engine.now, generate())
          end
          rate_count += batch_num
          sleep 0.1
        end
        # wait for next second
        while @running && Fluent::Engine.now == current_time
          sleep 0.04
        end
      end
    end
  end
end
