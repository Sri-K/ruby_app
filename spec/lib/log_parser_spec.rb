require 'log_parser'

RSpec.describe LogParser do
  subject { described_class.new(logfile) }

  describe '#initialize' do
    context 'when initialize without a file' do
      let(:logfile) { "spec/fixtures/files/fakeserver.log" }

      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, "File not found: #{logfile}")
      end
    end

    context 'when initialize with a valid file' do
      let(:logfile) { "spec/fixtures/files/testserver.log" }

      it 'instantiates the class' do
        expect(subject).to be_a LogParser
      end
    end
  end
  
end
