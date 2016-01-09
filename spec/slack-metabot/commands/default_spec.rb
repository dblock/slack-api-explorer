require 'spec_helper'

describe SlackMetabot::Commands::Default do
  let!(:team) { Fabricate(:team) }
  let(:app) { SlackMetabot::Server.new(team: team) }
  let(:client) { app.send(:client) }
  it 'default' do
    expect(client).to receive(:say).with(channel: 'channel', text: SlackMetabot::INFO)
    expect(client).to receive(:say).with(channel: 'channel', gif: 'robot')
    app.send(:message, client, channel: 'channel', text: SlackRubyBot.config.user)
  end
  it 'upcase' do
    expect(client).to receive(:say).with(channel: 'channel', text: SlackMetabot::INFO)
    expect(client).to receive(:say).with(channel: 'channel', gif: 'robot')
    app.send(:message, client, channel: 'channel', text: SlackRubyBot.config.user.upcase)
  end
end
