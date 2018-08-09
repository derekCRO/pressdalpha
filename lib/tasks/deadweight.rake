begin
  require 'deadweight'
rescue LoadError
end

desc "run Deadweight CSS check (requires script/server)"
task :deadweight => :environment do
  dw = Deadweight.new
  dw.stylesheets = ["/stylesheets/jednotka_green.css"]
  dw.pages = ["/", "/task1"]
  dw.ignore_selectors = /flash_notice|flash_error|errorExplanation|fieldWithErrors/
  puts dw.run
end
