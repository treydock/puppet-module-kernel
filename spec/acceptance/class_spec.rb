require 'spec_helper_acceptance'

describe 'kernel class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'kernel': }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
