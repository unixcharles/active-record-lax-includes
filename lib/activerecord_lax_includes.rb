module ActiveRecordLaxIncludes
  module Preloader
    def self.included(base)
      base.class_eval do
        alias_method :records_by_reflection_default, :records_by_reflection
        alias_method :records_by_reflection, :records_by_reflection_with_lax_include

        alias_method :preload_hash_default, :preload_hash
        alias_method :preload_hash, :preload_hash_with_lax_include
      end
    end

    def preload_hash_with_lax_include(association)
      if lax_includes_enabled?
        association.each do |parent, child|
          ActiveRecord::Associations::Preloader.new(records, parent, options).run
          associated_records = filtered_records_by_reflection(parent).map { |record| record.send(parent) }.flatten
          ActiveRecord::Associations::Preloader.new(associated_records, child).run
        end
      else
        preload_hash_default(association)
      end
    end

    def records_by_reflection_with_lax_include(association)
      if lax_includes_enabled?
        filtered_records_by_reflection(association).group_by do |record|
          record.class.reflections[association]
        end
      else
        records_by_reflection_default(association)
      end
    end

    def filtered_records_by_reflection(association)
      records.select do |record|
        record.class.reflections[association].present?
      end
    end

    def lax_includes_enabled?
      !!Thread.current[:active_record_lax_includes_enabled]
    end
  end

  module BaseHelper
    def lax_includes
      Thread.current[:active_record_lax_includes_enabled] = true
      yield
    ensure
      Thread.current[:active_record_lax_includes_enabled] = false
    end
  end
end

require 'active_record'

ActiveRecord::Associations::Preloader.send(:include, ActiveRecordLaxIncludes::Preloader)
ActiveRecord.send(:extend, ActiveRecordLaxIncludes::BaseHelper)
