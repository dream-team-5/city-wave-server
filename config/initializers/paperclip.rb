if Rails.env.production?
  Paperclip::Attachment.default_options.merge! \
    storage: :dropbox,
    dropbox_credentials: {
      access_token: ENV['DROPBOX_ACCESS_TOKEN'],
      access_type: 'app_folder'
    },
    path: ':id/:style/:filename'
end
