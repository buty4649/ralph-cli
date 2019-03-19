require 'hanami/cli'
require 'ralph/cli/commands/base'
require 'ralph/cli/commands/get'
require 'ralph/cli/commands/post'
require 'ralph/cli/commands/delete'
require 'ralph/cli/commands/token'
require 'ralph/cli/commands/version'

require 'json'

module Ralph::CLI
  module Commands
    extend Hanami::CLI::Registry
    register "token",   Token
    register "version", Version

    json = File.open(File.expand_path("../../ralph_api.json", __FILE__)) do |io|
      JSON.load(io.read)
    end

    json.each do |category, metadata|
      # convert safe name
      name = category.split(/[-_]/).map(&:capitalize).join
      klass = self.const_set(name.to_sym, Class.new)

      # Get
      get_klass = klass.const_set(:Get, Class.new(Get) { self.path = "/api/#{category}/"} )
      get_klass.desc "Get #{metadata["name"]}"
      metadata["filtering"]&.each do |item|
        get_klass.option item.to_sym, type: :string
      end
      register "#{category} get", get_klass

      # Post
      post_klass = klass.const_set(:Post, Class.new(Post) { self.path = "/api/#{category}/"} )
      post_klass.desc "Post #{metadata["name"]}"
      post_klass.required_parameters = Array.new
      metadata["actions"]&.fetch("POST")&.each do |name, attr|
        next if attr["read_only"]
        type = attr["type"].to_sym
        required = attr["required"]
        if required
          post_klass.required_parameters <<= name.to_sym
        end

        desc = if required
                 "(Required)"
               else
                 "(Optional)"
               end
        post_klass.option name.to_sym, type: type, desc: desc

      end
      post_klass.option :file, type: :string, desc: "(Optional)"
      register "#{category} post", post_klass

      # Delete
      delete_klass = klass.const_set(:Delete, Class.new(Delete) { self.path = "/api/#{category}/"} )
      delete_klass.desc "Delete #{metadata["name"]}"
      delete_klass.option :id, type: :string
      register "#{category} delete", delete_klass
    end
  end
end
