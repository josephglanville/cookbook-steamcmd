actions :install, :remove
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :app_id, kind_of: Integer, required: true
attribute :target_dir, kind_of: String, required: true
attribute :login, kind_of: String, default: 'anonymous'
attribute :run_validate, kind_of: [TrueClass, FalseClass], default: false
