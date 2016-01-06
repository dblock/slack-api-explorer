require 'open3'

module SlackMetabot
  module Commands
    class Slack < SlackRubyBot::Commands::Base
      match(/^(?<bot>\w*)\s+(?<expression>.+)/)

      def self.call(client, data, match)
        expression = match['expression']
        expression.gsub! '—', '--'
        logger.info "SLACK: #{client.team} - #{expression}"
        args = Shellwords.shellwords(expression)
        execute(client, args) do |output|
          send_message client, data.channel, "```\n#{output}```"
        end
      end

      def self.execute(client, args)
        Open3.popen3(* [
          'slack',
          '--slack-api-token',
          client.team.token,
          args
        ].flatten) do |_, stdout, stderr, _|
          output = stderr.gets || stdout.gets
          yield output.strip
        end
      end
    end
  end
end
