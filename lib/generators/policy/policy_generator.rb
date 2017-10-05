class PolicyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_files
    path = [*class_path, file_name].join '/'

    template 'policy.rb', "app/policies/#{ path }_policy.rb"

    template 'policy_spec.rb', "spec/policies/#{ path }_policy_spec.rb"
  end
end
