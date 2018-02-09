require "hyperender/version"

module Hyperender

  HATEOAS_MSG = {
    100 => "Continue",
    101 => "Switching Protocols",
    200 => "OK",
    201 => "Created",
    202 => "Accepted",
    203 => "Non-Authoritative Information",
    204 => "No Content",
    205 => "Reset Content",
    206 => "Partial Content",
    300 => "Multiple Choices",
    301 => "Moved Permanently",
    302 => "Found",
    303 => "See Other",
    304 => "Not Modified",
    307 => "Temporary Redirect",
    308 => "Permanent Redirect",
    400 => "Bad Request",
    401 => "Unauthorized",
    403 => "Forbidden",
    404 => "Not Found",
    405 => "Method Not Allowed",
    406 => "Not Acceptable",
    407 => "Proxy Authentication Required",
    408 => "Request Timeout",
    409 => "Conflict",
    410 => "Gone",
    411 => "Length Required",
    412 => "Precondition Failed",
    413 => "Payload Too Large",
    414 => "URI Too Long",
    415 => "Unsupported Media Type",
    416 => "Range Not Satisfiable",
    417 => "Expectation Failed",
    426 => "Upgrade Required",
    428 => "Precondition Required",
    429 => "Too Many Requests",
    431 => "Request Header Fields Too Large",
    451 => "Unavailable For Legal Reasons",
    500 => "Internal Server Error",
    501 => "Not Implemented",
    502 => "Bad Gateway",
    503 => "Service Unavailable",
    504 => "Gateway Timeout",
    505 => "HTTP Version Not Supported",
    511 => "Network Authentication Required"
  }

  def self.render data, errors, parameters, message, status, request
    {
      data:               (Hyperender.generated_data data, errors),
      query_parameters:   parameters,
      response: {
        message:          message,
        status:           status
      },
      request: {
        url:              request.original_url,
        method:           request.request_method,
        headers:          (Hyperender.generated_headers request),
      }
    }
  end

  def self.generated_data data, errors
    data[:errors] = errors unless errors.blank?
    data
  end

  def self.generated_headers request
    enviroment = [
      #Server specific variables
      # "SERVER_SOFTWARE", "SERVER_NAME", "GATEWAY_INTERFACE",
      #Request specific variables
     "SERVER_PROTOCOL", "SERVER_PORT", "REQUEST_METHOD", "PATH_INFO", "PATH_TRANSLATED", "SCRIPT_NAME", "QUERY_STRING", "REMOTE_HOST", "REMOTE_ADDR", "AUTH_TYPE", "REMOTE_USER", "REMOTE_IDENT", "CONTENT_TYPE", "CONTENT_LENGTH", "HTTP_USER_AGENT", "X_CUSTOM_HEADER"
    ]
    headers = {}
    enviroment.each do |env|
      attribute = request.headers[env]
      headers[env.downcase] = attribute unless attribute.blank?
    end
    headers
  end

  module Action
    def self.included(base)
      base.class_eval do
        def hateoas_data *args
          case args.count
          when 0 then @hateoas_data_render ||= {}
          when 1 then @hateoas_data_render = args[0]
          else        @hateoas_data_render = args
          end
          @hateoas_data_render
        end

        def hateoas_error *args
          case args.count
          when 0 then @errors ||= {}
          when 1 then @errors = args[0]
          else        @errors = args
          end
          @errors
        end

        def hateoas_params *args
          case args.count
          when 0 then @params ||= request.query_parameters
          when 1 then @params = args[0]
          else        @params = args
          end
          params_class = @params.class.to_s rescue nil
          unless params_class.in? ["Hash","Array","String"]
            @params = (@params.as_json rescue (@params.to_s rescue "not renderable"))
          end
          @params
        end

        def hateoas_message
          @message ||= HATEOAS_MSG[response.status]
          @message
        end

        def hateoas_status
          @status ||= response.status
          @status
        end

        def hateoas_request
          @request ||= request
          @request
        end

        def hateoas_render
          Hyperender.render (hateoas_data), (hateoas_error), (hateoas_params), (hateoas_message), (hateoas_status), (hateoas_request)
        end

        def hateoas_rendering
          render json: hateoas_render
        end
      end
    end
  end
end
