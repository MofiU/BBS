GrapeSwaggerRails.options.url      = '/api/bbs'

# GrapeSwaggerRails.options.app_url  = ''
GrapeSwaggerRails.options.app_name = 'BBS_API'

GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
