class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_files
    template 'service.rb', "app/services/#{ file_name }.rb"

    template 'service_spec.rb', "spec/services/#{ file_name }_spec.rb"
  end
end
