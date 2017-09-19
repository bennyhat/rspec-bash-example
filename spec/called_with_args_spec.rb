require 'rspec/bash'

describe 'gist' do
  include Rspec::Bash
  let(:stubbed_env) { create_stubbed_env }
  let!(:first_command) { stubbed_env.stub_command('first_command') }

  context '#should_fail?' do
    context 'when given multiple command calls' do
      before(:each) do
        stubbed_env.execute_inline(
          <<-multiline_script
              first_command first_argument second_argument
              first_command first_argument second_argument third_argument
        multiline_script
        )
      end

      it 'displays the diff between what was called and what was expected' do
          expect(first_command).to be_called_with_arguments('not_first_argument', 'second_argument')
      end
    end
  end
end
