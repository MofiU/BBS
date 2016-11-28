module API
  module V1
    class Base < Grape::API
      format :json
      mount API::V1::Topics

      before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'
      end

      add_swagger_documentation format: :json,
                                hide_documentation_path: false,
                                api_version: 'v1',
                                info: {
                                  title: "API for BBS",
                                  description: "Just try it and you will find it is so interesting!"
                                },
                                mount_path: 'bbs'
    end
  end
end