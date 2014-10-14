require 'spec_helper'
require 'marko/cli'

describe Marko::CLI do
  let(:marko)         { Marko }

  describe '#version' do
    it 'shows the current version' do
      expect(STDOUT).to receive(:puts).with(/#{ ::Marko::VERSION }/)

      subject.version
    end
  end
end
