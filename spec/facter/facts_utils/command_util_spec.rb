# frozen_string_literal: true

describe 'CommandUtil' do
  context 'correct arguments' do
    let(:command) { 'test' }
    it 'returns output if all arguments are present' do
      logger = double(Facter::Log.new)
      allow(Facter::CommandUtil).to receive(:exec_command).with(command, logger).and_return('os_zone')
      expect(Facter::CommandUtil.exec_command(command, logger)).to eq('os_zone')
    end
  end
  context 'incorrect arguments' do
    it 'raises error if method arguments are nil' do
      expect { Facter::CommandUtil.exec_command(nil, nil) }
        .to raise_error('Command or logger is not provided as an argument for CommandUtil class')
    end
  end
end
