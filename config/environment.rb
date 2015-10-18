# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /\<label/
    html_tag
  else
    errors = Array(instance.error_message).join(',')
 	%(<div class="field_with_error"><label class="control-label"><i class="fa fa-times-circle-o"></i> #{errors}</label>#{html_tag}</div>).html_safe
 end

end
