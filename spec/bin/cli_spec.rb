require 'rails_helper'
require 'open3'

RSpec.describe 'cli' do
  before :all do
    create(:robot)
  end

  describe 'file input' do
    context 'when the file is not provided' do
      it 'outputs File not found to stdout' do
        stdout, = Open3.capture3('bin/cli -f')

        expect(stdout.chomp)
          .to eq 'File path is missing. Please provide a file path to read the commands from.'
      end
    end

    context 'when the file is not found' do
      it 'outputs File not found to stdout' do
        stdout, = Open3.capture3('bin/cli -f /any/path')

        expect(stdout.chomp).to eq('File not found')
      end
    end

    context 'when the file is provided' do
      it 'outputs the file report to stdout' do
        stdout, = Open3.capture3('bin/cli -f spec/fixtures/sample_a')
        expect(stdout.chomp).to eq('0,1,SOUTH')
      end
    end
  end

  describe 'interactive input' do
    context 'when the input is valid' do
      it 'outputs the report to stdout' do
        stdout, = Open3.capture3(
          'bin/cli',
          stdin_data: "PLACE 0,0,SOUTH\nMOVE\nREPORT\n"
        )

        expect(stdout.chomp).to eq('0,1,SOUTH')
      end
    end
  end
end
