# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( bootstrap/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( admin/font-awesome/css/font-awesome.css )
Rails.application.config.assets.precompile += %w( slick.css )
Rails.application.config.assets.precompile += %w( select2.min.css )
Rails.application.config.assets.precompile += %w( adminpanel.css )
Rails.application.config.assets.precompile += %w( admin/css/datatables.min.css )
Rails.application.config.assets.precompile += %w( custom.css )

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w( select2.min.js )
Rails.application.config.assets.precompile += %w( bundle.js )
Rails.application.config.assets.precompile += %w( main.js )
Rails.application.config.assets.precompile += %w( modernizr.min.js )
Rails.application.config.assets.precompile += %w( adminpanel.js )
Rails.application.config.assets.precompile += %w( rateyo.min.js )
Rails.application.config.assets.precompile += %w( charges.js )
Rails.application.config.assets.precompile += %w( admin/js/scripts.js )
Rails.application.config.assets.precompile += %w( admin/js/bootstrap.min.js )
Rails.application.config.assets.precompile += %w( admin/js/bootstrap-confirmation.min.js )
Rails.application.config.assets.precompile += %w( admin/js/popper.min.js )
Rails.application.config.assets.precompile += %w( admin/js/mdb.min.js )
Rails.application.config.assets.precompile += %w( admin/js/scripts-frontend.js )
Rails.application.config.assets.precompile += %w( admin/js/misc/holder.min.js )
Rails.application.config.assets.precompile += %w( admin/js/misc/ie10-viewport-bug-workaround.js )
Rails.application.config.assets.precompile += %w( admin/js/misc/jquery.easing.1.3.js )
Rails.application.config.assets.precompile += %w( admin/js/misc/moment.min.js )
Rails.application.config.assets.precompile += %w( admin/js/jquery/jquery-3.1.1.min.js )
Rails.application.config.assets.precompile += %w( admin/js/jquery/jquery-ui.min.js )
Rails.application.config.assets.precompile += %w( jquery/jquery_ujs.js )
Rails.application.config.assets.precompile += %w( admin/js/fullcalendar.min.js )
Rails.application.config.assets.precompile += %w( admin/js/highcharts.js )
Rails.application.config.assets.precompile += %w( admin/js/datatables.min.js )
Rails.application.config.assets.precompile += %w( admin/js/plugins/chartjs/chart.bundle.min.js )
Rails.application.config.assets.precompile += %w( admin/js/plugins/custom-scrollbar/jquery.mCustomScrollbar.concat.min.js)
Rails.application.config.assets.precompile += %w( admin/js/plugins/toastr/toastr.min.js)
Rails.application.config.assets.precompile += %w( ckeditor/*)


# Rails.application.config.assets.precompile += %w( admin/js/bootstrap.min.js admin/js/plugins/metisMenu/jquery.metisMenu.js admin/js/plugins/slimscroll/jquery.slimscroll.min.js admin/js/inspinia.js admin/js/plugins/pace/pace.min.js admin/js/plugins/iCheck/icheck.min.js )


# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
