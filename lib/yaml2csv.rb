require "yaml2csv/version"
require 'yaml'
require 'csv'
require 'pry'

module Yaml2csv
  class Yaml2csv
    # クラス変数の初期化
    @@depth = 0
    @@array = []

    # @param [String] file Yamlのファイル名
    def self.yaml_to_csv(path)
      hash = YAML::load_file(path)
      init_array(hash)
      walk(hash, 0, 0)
      puts gen_csv_str
    end

    # @param [Hash] yamlを読み込んでハッシュ化したもの
    def self.init_array(hash)
      depth(hash, 0)
      row_num = end_node_size(hash)
      @@array = Array.new(@@depth).map{ Array.new(row_num) }
    end

    def self.gen_csv_str
      CSV.generate do |csv|
        @@array.each {|row| csv << row}
      end
    end

    # @param [Object] v walk対象
    # @param [Fixnum] depth 深さ
    # @param [Fixnum] row_num 行番号
    # @@array[depth][row_num]に新規に書き込む形になる。
    # @return [Fixnum] walk対象が持つ末端ノードの数
    def self.walk(v, depth, row_num)
      case v
      when Hash
        end_node_size = 0
        cursor = row_num
        v.each do |key, val|
          row_size = walk(val, depth+1, cursor)
          row_size.times do |i|
            @@array[depth][cursor] = key
            cursor += 1
          end
          end_node_size += row_size
        end
      when Array
        v.each.with_index do |val, i|
          @@array[depth][row_num + i] = val
        end
        end_node_size = v.size
      else
        @@array[depth][row_num] = v
        end_node_size = 1
      end
      end_node_size
    end

    # @param [Object] v walk対象
    # @return [Fixnum] walk対象が持つ末端ノードの数
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

    # クラス変数@@depth（対象のハッシュの階層の深さ）を初期化する
    # @param [Object] v walk対象
    # @param [Fixnum] depth 深さを表す数値。ルートが0
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
