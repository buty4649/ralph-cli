module Ralph::CLI:Commands
  class Version < Hanami::CLI::Command
    def call(*)
      puts Ralph::CLI::VERSION
    end
  end
end
