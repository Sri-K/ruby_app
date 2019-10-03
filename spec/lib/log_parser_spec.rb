require 'log_parser'

RSpec.describe LogParser do
  let(:logfile) { "spec/fixtures/files/testserver.log" }
  subject { described_class.new(logfile) }

  describe '#initialize' do
    context 'when initialize without a file' do
      let(:logfile) { "" }

      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, "File not found")
      end
    end

    context 'when initialize with a fake file' do
      let(:logfile) { "spec/fixtures/files/fakefile.log" }

      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, "File or the directory not exists: #{logfile}")
      end
    end

    context 'when initialize with a valid file' do
      it 'instantiates the class' do
        expect(subject).to be_a LogParser
      end

      it 'returns the logs as a Hash' do
        expect(subject.logs).to be_a Hash
      end
    end
  end

  describe "#parse_logfile" do
    let(:logs) {  
      {
        "/about" => ["061.945.150.735", "126.318.035.038"],
        "/about/2" => ["444.701.448.104", "444.701.448.104", "836.973.694.403"],
        "/contact" => ["184.123.665.067", "184.123.665.067", "543.910.244.929"],
        "/help_page/1" => ["126.318.035.038", "929.398.951.889", "722.247.931.582", "646.865.545.408", "543.910.244.929"],
        "/home" => ["184.123.665.067", "235.313.352.950", "316.433.849.805"],
        "/index" => ["444.701.448.104"]
      }
    }

    it 'parse the logs and return with an array of ip addresses' do
      expect(subject.parse_logfile).to eq logs
    end
  end

  describe "#print_total_views" do
    before { subject.parse_logfile }

    let(:total_views_ordererd_by_most_views) { 
      {
        "/help_page/1"=>5, 
        "/about/2"=>3, 
        "/home"=>3, 
        "/contact"=>3, 
        "/about"=>2, 
        "/index"=>1
      } 
    }

    it 'returns the list ordered from most pages views to less page views' do
      expect(subject.print_total_views).to eq total_views_ordererd_by_most_views
    end
  end

  describe "#print_total_unique_views" do
    before { subject.parse_logfile }

    let(:total_unique_views_ordererd_by_most_unique_views) { 
      {
        "/help_page/1"=>5, 
        "/home"=>3, 
        "/about"=>2, 
        "/about/2"=>2, 
        "/contact"=>2, 
        "/index"=>1
      }
    }

    it 'returns the list ordered from most pages views to less page views' do
      expect(subject.print_unique_views).to eq total_unique_views_ordererd_by_most_unique_views
    end
  end
  
end

