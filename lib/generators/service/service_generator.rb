class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_files
    path = [*class_path, file_name].join '/'

    template 'service.rb', "app/services/#{ path }.rb"

    template 'service_spec.rb', "spec/services/#{ path }_spec.rb"
  end
end
