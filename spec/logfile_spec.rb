require './lib/logfile'

describe Logfile do
  let(:path) { 'spec/webserver_sample.log' }
  let(:wrong_path) { 'spec/webserver_sample2.log' }

  subject(:logfile) { Logfile.new(path) }
  subject(:wrong_logfile) { Logfile.new(wrong_path) }

  describe '#initialize' do
    it 'should contain file path' do
      expect(logfile.path).to eq('spec/webserver_sample.log')
    end
  end

  describe '#parse' do
    it 'raises an error for a wrong file' do
      expect { wrong_logfile.parse }.to raise_error(RuntimeError, "Please check file, no file exists on this path")
    end

    it 'gives expected parsed data format' do
      parsed_data = logfile.parse
      expect(parsed_data).to eq(
        [["/help_page/1", "126.318.035.038"], ["/contact", "184.123.665.067"], ["/home", "184.123.665.067"], ["/about/2", "444.701.448.104"], ["/help_page/1", "929.398.951.889"], ["/index", "444.701.448.104"], ["/help_page/1", "722.247.931.582"], ["/about", "061.945.150.735"], ["/help_page/1", "646.865.545.408"], ["/home", "235.313.352.950"]]
      ) 
    end
  end

  describe '#most_views' do
    it 'returns most views pages as hash' do
      logfile.parse
      most_viewed_webpages = logfile.most_views
      expect(most_viewed_webpages).to eq(
        {"/help_page/1"=>4, "/home"=>2, "/about"=>1, "/index"=>1, "/about/2"=>1, "/contact"=>1}
      )
    end
  end

  describe '#most_unique_views' do
    it 'returns most unique views per page as hash' do
      logfile.parse
      most_unique_webpages = logfile.most_unique_views
      expect(most_unique_webpages).to eq(
        {"/help_page/1"=>4, "/home"=>2, "/index"=>1, "/contact"=>1, "/about/2"=>1, "/about"=>1}
      )
    end 
  end
end
