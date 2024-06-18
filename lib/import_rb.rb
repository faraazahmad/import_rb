# frozen_string_literal: true

require 'prism'

class Symbol
  def as(const_name)
    [self, const_name]
  end
end

def import(array, from: "")
  raise unless array.is_a? Array

  path = File.expand_path(from)
  const_map = {}
  array.each do |const|
    if const.is_a? Array
      const_map[const[0]] = const[1]
    elsif const.is_a? Symbol
      const_map[const] = const
    end
  end

  program_node = Prism.parse_file(path)
  statements = program_node.value.child_nodes[0]

  statements.body.each do |node|
    next unless (node.is_a?(Prism::ClassNode) || node.is_a?(Prism::ModuleNode))
    next unless const_map.key?(node.name)

    start_offset = node.start_offset
    end_offset = node.end_offset

    node_source = statements.source_lines.join()[start_offset..end_offset]
    node_source = node_source.sub(node.name.to_s, const_map[node.name].to_s)

    if self.is_a?(Module) || self.is_a?(Class)
      self.module_eval(node_source)
    else
      eval(node_source)
    end
  end
end

Class.define_method(:import, method(:import))
Module.define_method(:import, method(:import))
