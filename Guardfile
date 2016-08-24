
#:run_all disables running all tests on enter.  THIS IS OBVIOUSLY TOTALLY A HACK.  GIT BLAME MICHAEL GLASS NOT WB
guard 'rspec', :version => 1, :all_after_pass => false, :all_on_start => false, :cli => '--color', :run_all => { :cli => "--asdf" } do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch('app/controllers/document_downloads_controller.rb')  { "spec/controllers/document_downloads" }
  watch(%r{.*word_document.*\.rb})                    { "spec/models/word_document/" }
  watch(%r{.*word_user.*\.rb})                        { "spec/models/word_user/" }
  watch(%r{.*document_identifier.*\.rb})                        { "spec/models/document_identifiers/" }
  watch(%r{.*api_controller_methods.*\.rb})           { "spec/controller/api/" }
end