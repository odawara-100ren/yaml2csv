require "yaml2csv/version"
require 'yaml'
require 'csv'
require 'pry'

module Yaml2csv
  class Yaml2csv
    @@depth = 0
    @@array = []

    # @param [String] file Yamlのファイル名
    def self.yaml_to_csv(path)
      hash = YAML::load_file(path)
      depth(hash, 0)
      row_num = end_node_size(hash)
      @@array = Array.new(@@depth).map{ Array.new(row_num) }
      walk(hash, 0, 0)
      p @@array
      # @@array.each do |col|
      # end
    end

    # @param [Object] v walk対象
    # @param [Fixnum] depth 深さ
    # @param [Fixnum] row_num 行番号
    # @@array[depth][row_num]に新規に書き込む形になる。
    def self.walk(v, depth, row_num)
      # @@array[depth] ||= []
      case v
      when Hash
        cursor = row_num
        v.each do |key, val|
          # ひとつのkeyについて以下の作業
          walk(val, depth+1, cursor)
          row_size = end_node_size(val)
          # walkとend_node_sizeをまとめればよさそう。
          # 今のところは分けておく
          row_size.times do |i|
            @@array[depth][cursor] = key
            cursor += 1
          end
        end
      when Array
        v.each.with_index do |val, i|
          @@array[depth][row_num + i] = val
        end
      else
        @@array[depth][row_num] = v
      end
    end

    def self.end_node_size(v)
      case v
      when Hash
        size = 0
        v.values.each do |val|
          size += end_node_size(val)
        end
        size
      when Array
        v.size
      else
        1
      end
    end

    def self.depth(v, depth)
      case v
      when Hash
        v.values.each {|val| depth(val, depth + 1)}
      when Array
        @@depth = depth+2 if @@depth < depth+2
      else
        @@depth = depth+1 if @@depth < depth+1
      end
    end
  end
end
